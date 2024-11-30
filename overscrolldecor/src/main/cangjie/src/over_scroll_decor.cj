/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package overscrolldecor

import ohos.state_macro_manage.*
import std.math.*

@Component
public class OverScrollDecor {
    @Link
    var model: OverScrollDecorModel
    @BuilderParam
    let child: () -> Unit

    private var scroller: Scroller = Scroller()
    private var endOffsetY: Float64 = 0.0
    private var endOffsetX: Float64 = 0.0
    private var isBounceEffect = true
    func build() {
        if (this.model.mUpOverScroll) {
            if (this.model.mOrientation == ORIENTATION.VERTICAL) {
                Flex(FlexParams(alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center)) {
                    Scroll(this.scroller) {
                        this.child()
                    }.margin(this.model.mMargin).scrollable(ScrollDirection.Vertical).scrollBar(BarState.Auto).scrollBar(
                        {
                        => if (this.model.mScrollBar) {
                            BarState.Auto
                        } else {
                            BarState.Off
                        }
                    }())
                        //.edgeEffect(this.model.mOverScrollBounceEffect ? EdgeEffect.Spring : EdgeEffect.None)
                        .onScrollEdge(
                        {
                        side => match (side) {
                            case Edge.Bottom => this.endOffsetY = this.scroller.currentOffset().yOffset
                            case _ => ()
                        }
                    }).onScroll(
                        {
                            offset =>
                            this.model.mOffsetY = this.scroller.currentOffset().yOffset
                            if (this.model.mOffsetY < 0.0) {
                                this.model.mOffsetY = -floor(this.model.mOffsetY)
                                if (this.isBounceEffect) {
                                    this.model.mTextColor = this.model.mDragColorTop
                                } else {
                                    this.model.mTextColor = this.model.mBounceBackColorTop
                                }
                                if (this.model.mOffsetY == 1.0) {
                                    this.scroller.scrollTo(xOffset: 0, yOffset: 0)
                                }
                            } else if (this.model.mOffsetY > this.endOffsetY && this.endOffsetY != 0.0) {
                                this.model.mOffsetY = floor(this.endOffsetY - this.model.mOffsetY)
                                if (this.isBounceEffect) {
                                    this.model.mTextColor = this.model.mDragColorBottom
                                } else {
                                    this.model.mTextColor = this.model.mBounceBackColorBottom
                                }
                            } else {
                                this.model.mOffsetY = 0.0
                                this.model.mTextColor = this.model.mClearColor
                            }
                        }
                    ).onTouch(
                        {
                        event => match (event.eventType) {
                            case TouchType.Down => this.isBounceEffect = true
                            case TouchType.Up => this.isBounceEffect = false
                            case _ => return
                        }
                    })
                }.height(this.model.mHeight).width(this.model.mWidth)
            } else if (this.model.mOrientation == ORIENTATION.HORIZONTAL) {
                Flex(FlexParams(alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center)) {
                    Scroll(this.scroller) {
                        this.child()
                    }.margin(this.model.mMargin).scrollable(ScrollDirection.Horizontal).scrollBar(BarState.Auto).scrollBar(
                        {
                        => if (this.model.mScrollBar) {
                            BarState.Auto
                        } else {
                            BarState.Off
                        }
                    }())
                        //.edgeEffect(this.model.mOverScrollBounceEffect ? EdgeEffect.Spring : EdgeEffect.None)
                    .onScrollEdge(
                    {
                    side => match (side) {
                        case Edge.End => this.endOffsetX = this.scroller.currentOffset().xOffset //BASELINE
                        case _ => ()
                    }
                }).onScroll(
                        {
                            offset =>
                            this.model.mOffsetX = this.scroller.currentOffset().xOffset
                            if (this.model.mOffsetX < 0.0) {
                                this.model.mOffsetX = -floor(this.model.mOffsetX)
                                if (this.isBounceEffect) {
                                    this.model.mTextColor = this.model.mDragColorLeft
                                } else {
                                    this.model.mTextColor = this.model.mBounceBackColorLeft
                                }
                                if (this.model.mOffsetX == 1.0) {
                                    this.scroller.scrollTo(xOffset: 0, yOffset: 0)
                                }
                            } else if (this.model.mOffsetX > this.endOffsetX && this.endOffsetX != 0.0) {
                                this.model.mOffsetX = floor(this.endOffsetX - this.model.mOffsetX)
                                if (this.isBounceEffect) {
                                    this.model.mTextColor = this.model.mDragColorRight
                                } else {
                                    this.model.mTextColor = this.model.mBounceBackColorRight
                                }
                            } else {
                                this.model.mOffsetX = 0.0
                                this.model.mTextColor = this.model.mClearColor
                            }
                        }
                    ).onTouch(
                        {
                        event => match (event.eventType) {
                            case TouchType.Down => this.isBounceEffect = true
                            case TouchType.Up => this.isBounceEffect = false
                            case _ => return
                        }
                    })
                }.height(this.model.mHeight).width(this.model.mWidth)
             }
        } else {
            Flex(FlexParams(alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center)) {
                Scroll(this.scroller) {
                    this.child()
                }.margin(this.model.mMargin).scrollable(ScrollDirection.None)
            }.height(this.model.mHeight).width(this.model.mWidth)
        }
    }
}

public enum ORIENTATION {
    | VERTICAL //0
    | HORIZONTAL //1

    public operator func ==(that: ORIENTATION): Bool {
        match ((this, that)) {
            case (VERTICAL, VERTICAL) => true
            case (HORIZONTAL, HORIZONTAL) => true
            case _ => false
        }
    }

    public operator func !=(that: ORIENTATION): Bool {
        return !(this == that)
    }
}

@Observed
public class OverScrollDecorModel {
    var mHeight: Length = 2340.vp
    var mWidth: Length = 720.vp
    var mMargin: Float64 = 16.0
    //设置滚动方向
    var mOrientation: ORIENTATION = VERTICAL
    //是否需要滚动条
    var mScrollBar: Bool = true
    //是否需要滑动效果
    var mOverScrollBounceEffect: Bool = false
    //是否可以滑动
    var mUpOverScroll: Bool = true
    @Publish
    var mOffsetY: Float64 = 0.0
    @Publish
    var mOffsetX: Float64 = 0.0
    @Publish
    var mTextColor: String = "0X727171"
    var mClearColor: String = "0X727171"
    var mDragColorLeft: String = "0Xffaa66cc"
    var mBounceBackColorLeft: String = "0Xff33b5e5"
    var mDragColorRight: String = "0Xffff4444"
    var mBounceBackColorRight: String = "0Xffff8800"
    var mDragColorTop: String = "0Xffff4444"
    var mBounceBackColorTop: String = "0Xffff8800"
    var mDragColorBottom: String = "0Xffaa66cc"
    var mBounceBackColorBottom: String = "0Xff33b5e5"

    /*
     * 获取边框高度。
     *
     * 返回值 Length - 边框高度
     */
    public func getHeight(): Length {
        return this.mHeight
    }

    /*
     * 设置边框高度
     *
     * 参数 height - 高度
     * 返回值 OverScrollDecorModel - 滚动容器数据实例
     */
    public func setHeight(height: Length): OverScrollDecorModel {
        this.mHeight = height
        return this
    }

    /*
     * 获取边框宽度。
     *
     * 返回值 Length - 边框宽度
     */
    public func getWidth(): Length {
        return this.mWidth
    }

    /*
     * 设置边框宽度。
     *
     * 参数 width - 宽度大小
     * 返回值 OverScrollDecorModel - 滚动容器数据实例
     */
    public func setWidth(width: Length): OverScrollDecorModel {
        this.mWidth = width
        return this
    }

    /*
     * 获取边距。
     *
     * 返回值 Float64 - 边距
     */
    public func getMargin(): Float64 {
        return this.mMargin
    }

    /*
     * 设置边距。
     *
     * 参数 margin - 边距大小
     * 返回值 OverScrollDecorModel - 滚动容器数据实例
     */
    public func setMargin(margin: Float64): OverScrollDecorModel {
        this.mMargin = margin
        return this
    }

    /*
     * 获取滚动方向
     *
     * 返回值 ORIENTATION - 滚动方向
     */
    public func getOrientation(): ORIENTATION {
        return this.mOrientation
    }

    /*
     * 设置滚动方向。
     *
     * 参数 orientation - 滚动方向
     * 返回值 OverScrollDecorModel - 滚动容器数据实例
     */
    public func setOrientation(orientation: ORIENTATION): OverScrollDecorModel {
        this.mOrientation = orientation
        return this
    }

    /*
     * 判断是否需要滚动条。
     *
     * 返回值 Bool
     */
    public func isScrollBar(): Bool {
        return this.mScrollBar
    }

    /*
     * 设置是否需要滚动条。
     *
     * 参数 scrollBar - 默认true
     * 返回值 OverScrollDecorModel - 滚动容器数据实例
     */
    public func setScrollBar(scrollBar: Bool): OverScrollDecorModel {
        this.mScrollBar = scrollBar
        return this
    }

    /*
     * 判断是否需要过度滚动反弹效果。
     *
     * 返回值 Bool
     */
    public func isOverScrollBounceEffect(): Bool {
        return this.mOverScrollBounceEffect
    }

    /*
     * 设置是否需要滑动效果。
     *
     * 参数 overScrollBounceEffect - 默认false
     * 返回值 OverScrollDecorModel - 滚动容器数据实例
     */
    public func setOverScrollBounceEffect(overScrollBounceEffect: Bool): OverScrollDecorModel {
        this.mOverScrollBounceEffect = overScrollBounceEffect
        return this
    }

    /*
     * 是否可以滑动。
     *
     * 返回值 Bool
     */
    public func isUpOverScroll(): Bool {
        return this.mUpOverScroll
    }

    /*
     * 设置是否可以滑动。
     *
     * 参数 upOverScroll - true
     * 返回值 OverScrollDecorModel - 滚动容器数据实例
     */
    public func setUpOverScroll(upOverScroll: Bool): OverScrollDecorModel {
        this.mUpOverScroll = upOverScroll
        return this
    }

    /*
     * 获取x偏移量。
     *
     * 返回值 Float64 - x偏移量
     */
    public func getOffsetX(): Float64 {
        return this.mOffsetX
    }

    /*
     * 设置x偏移量。
     *
     * 参数 offsetX - x偏移量
     * 返回值 OverScrollDecorModel - 滚动容器数据实例
     */
    public func setOffsetX(offsetX: Float64): OverScrollDecorModel {
        this.mOffsetX = offsetX
        return this
    }

    /*
     * 获取y偏移量。
     *
     * 返回值 Float64 - y偏移量
     */
    public func getOffsetY(): Float64 {
        return this.mOffsetY
    }

    /*
     * 设置y偏移量。
     *
     * 参数 offsetY - y偏移量
     * 返回值 OverScrollDecorModel - 滚动容器数据实例
     */
    public func setOffsetY(offsetY: Float64): OverScrollDecorModel {
        this.mOffsetY = offsetY
        return this
    }

    /*
     * 获取text颜色
     *
     * 返回值 String - text颜色
     */
    public func getTextColor(): String {
        return this.mTextColor
    }

    /*
     * 设置text颜色
     *
     * 参数 textColor - 颜色
     * 返回值 OverScrollDecorModel - 滚动容器数据实例
     */
    public func setTextColor(textColor: String): OverScrollDecorModel {
        this.mTextColor = textColor
        return this
    }

    public func getClearColor(): String {
        return this.mClearColor
    }

    public func setClearColor(clearColor: String): OverScrollDecorModel {
        this.mClearColor = clearColor
        return this
    }

    public func getDragColorLeft(): String {
        return this.mDragColorLeft
    }

    public func setDragColorLeft(dragColorLeft: String): OverScrollDecorModel {
        this.mDragColorLeft = dragColorLeft
        return this
    }

    public func getBounceBackColorLeft(): String {
        return this.mBounceBackColorLeft
    }

    public func setBounceBackColorLeft(bounceBackColorLeft: String): OverScrollDecorModel {
        this.mBounceBackColorLeft = bounceBackColorLeft
        return this
    }

    public func getDragColorRight(): String {
        return this.mDragColorRight
    }

    public func setDragColorRight(dragColorRight: String): OverScrollDecorModel {
        this.mDragColorRight = dragColorRight
        return this
    }

    public func getBounceBackColorRight(): String {
        return this.mBounceBackColorRight
    }

    public func setBounceBackColorRight(bounceBackColorRight: String): OverScrollDecorModel {
        this.mBounceBackColorRight = bounceBackColorRight
        return this
    }

    public func getDragColorTop(): String {
        return this.mDragColorTop
    }

    public func setDragColorTop(dragColorTop: String): OverScrollDecorModel {
        this.mDragColorTop = dragColorTop
        return this
    }

    public func getBounceBackColorTop(): String {
        return this.mBounceBackColorTop
    }

    public func setBounceBackColorTop(bounceBackColorTop: String): OverScrollDecorModel {
        this.mBounceBackColorTop = bounceBackColorTop
        return this
    }

    public func getDragColorBottom(): String {
        return this.mDragColorBottom
    }

    public func setDragColorBottom(dragColorBottom: String): OverScrollDecorModel {
        this.mDragColorBottom = dragColorBottom
        return this
    }

    public func getBounceBackColorBottom(): String {
        return this.mBounceBackColorBottom
    }

    public func setBounceBackColorBottom(bounceBackColorBottom: String): OverScrollDecorModel {
        this.mBounceBackColorBottom = bounceBackColorBottom
        return this
    }
}
