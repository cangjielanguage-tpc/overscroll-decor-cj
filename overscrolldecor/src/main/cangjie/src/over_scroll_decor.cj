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
                            this.model.mOffsetY = floor(this.scroller.currentOffset().yOffset)
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
            }
        } else if (this.model.mOrientation == ORIENTATION.HORIZONTAL) {
            Flex(FlexParams(alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center)) {
                Scroll(this.scroller) {
                    this.child()
                }.margin(this.model.mMargin).scrollable(ScrollDirection.Horizontal).scrollBar(
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
                        case Edge.Start => this.endOffsetX = this.scroller.currentOffset().xOffset //BASELINE
                        case _ => ()
                    }
                }).onScroll(
                    {
                        offset =>
                        this.model.mOffsetX = floor(this.scroller.currentOffset().xOffset)
                        if (this.model.mOffsetX < 0.0) {
                            this.model.mOffsetX = -floor(this.model.mOffsetX)
                            if (this.isBounceEffect) {
                                this.model.mTextColor = this.model.mDragColorLeft
                            } else {
                                this.model.mTextColor = this.model.mBounceBackColorLeft
                            }
                            if (this.model.mOffsetX == 1.0) {
                                this.scroller.scrollTo(xOffset: Length(0), yOffset: Length(0))
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

public class OverScrollDecorModel {
    var mHeight: ?Length = px2vp(Length(2340))
    var mWidth: ?Length = px2vp(lpx2px(Length(720)).getOrThrow())
    var mMargin: Float64 = 16.0
    //设置滚动方向
    var mOrientation: ORIENTATION = VERTICAL
    //是否需要滚动条
    var mScrollBar: Bool = true
    //是否需要滑动效果
    var mOverScrollBounceEffect: Bool = false
    //是否可以滑动
    var mUpOverScroll: Bool = true
    var mOffsetY: Float64 = 0.0
    var mOffsetX: Float64 = 0.0
    var mTextColor: String = "#727171"
    var mClearColor: String = "#727171"
    var mDragColorLeft: String = "#ffaa66cc"
    var mBounceBackColorLeft: String = "#ff33b5e5"
    var mDragColorRight: String = "#ffff4444"
    var mBounceBackColorRight: String = "#ffff8800"
    var mDragColorTop: String = "#ffff4444"
    var mBounceBackColorTop: String = "#ffff8800"
    var mDragColorBottom: String = "#ffaa66cc"
    var mBounceBackColorBottom: String = "#ff33b5e5"

    public func getHeight(): ?Length {
        return this.mHeight
    }

    public func setHeight(height: ?Length): OverScrollDecorModel {
        this.mHeight = height
        return this
    }

    public func getWidth(): ?Length {
        return this.mWidth
    }

    public func setWidth(width: ?Length): OverScrollDecorModel {
        this.mWidth = width
        return this
    }

    public func getMargin(): Float64 {
        return this.mMargin
    }

    public func setMargin(margin: Float64): OverScrollDecorModel {
        this.mMargin = margin
        return this
    }

    public func getOrientation(): ORIENTATION {
        return this.mOrientation
    }

    public func setOrientation(orientation: ORIENTATION): OverScrollDecorModel {
        this.mOrientation = orientation
        return this
    }

    public func isScrollBar(): Bool {
        return this.mScrollBar
    }

    public func setScrollBar(scrollBar: Bool): OverScrollDecorModel {
        this.mScrollBar = scrollBar
        return this
    }

    public func isOverScrollBounceEffect(): Bool {
        return this.mOverScrollBounceEffect
    }

    public func setOverScrollBounceEffect(overScrollBounceEffect: Bool): OverScrollDecorModel {
        this.mOverScrollBounceEffect = overScrollBounceEffect
        return this
    }

    public func isUpOverScroll(): Bool {
        return this.mUpOverScroll
    }

    public func setUpOverScroll(upOverScroll: Bool): OverScrollDecorModel {
        this.mUpOverScroll = upOverScroll
        return this
    }

    public func getOffsetX(): Float64 {
        return this.mOffsetX
    }

    public func setOffsetX(offsetX: Float64): OverScrollDecorModel {
        this.mOffsetX = offsetX
        return this
    }

    public func getOffsetY(): Float64 {
        return this.mOffsetY
    }

    public func setOffsetY(offsetY: Float64): OverScrollDecorModel {
        this.mOffsetY = offsetY
        return this
    }

    public func getTextColor(): String {
        return this.mTextColor
    }

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
