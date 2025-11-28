# overScrollDecor4cj 特性文档

## 介绍
> 类似iOS风格的边缘滚动效果视图。 
> 支持下列视图：RecyclerView, ListView, GridView, ViewPager, ScrollView, HorizontalScrollView, Any View - Text, Image...

## 1 滚动容器视图
### 1.1 OverScrollDecorModel class API Description
```cangjie
@Observed
public class OverScrollDecorModel {
    
    /*
     * 获取边框高度。
     *
     * 返回值 Length - 边框高度
     */
    public func getHeight(): Length 

    /*
     * 设置边框高度
     *
     * 参数 height - 高度
     * 返回值 OverScrollDecorModel - 滚动容器数据实例
     */
    public func setHeight(height: Length): OverScrollDecorModel 

    /*
     * 获取边框宽度。
     *
     * 返回值 Length - 边框宽度
     */
    public func getWidth(): Length 

    /*
     * 设置边框宽度。
     *
     * 参数 width - 宽度大小
     * 返回值 OverScrollDecorModel - 滚动容器数据实例
     */
    public func setWidth(width: Length): OverScrollDecorModel 

    /*
     * 获取边距。
     *
     * 返回值 Float64 - 边距
     */
    public func getMargin(): Float64 

    /*
     * 设置边距。
     *
     * 参数 margin - 边距大小
     * 返回值 OverScrollDecorModel - 滚动容器数据实例
     */
    public func setMargin(margin: Float64): OverScrollDecorModel 

    /*
     * 获取滚动方向
     *
     * 返回值 ORIENTATION - 滚动方向
     */
    public func getOrientation(): ORIENTATION 

    /*
     * 设置滚动方向。
     *
     * 参数 orientation - 滚动方向
     * 返回值 OverScrollDecorModel - 滚动容器数据实例
     */
    public func setOrientation(orientation: ORIENTATION): OverScrollDecorModel 

    /*
     * 判断是否需要滚动条。
     *
     * 返回值 Bool
     */
    public func isScrollBar(): Bool 

    /*
     * 设置是否需要滚动条。
     *
     * 参数 scrollBar - 默认true
     * 返回值 OverScrollDecorModel - 滚动容器数据实例
     */
    public func setScrollBar(scrollBar: Bool): OverScrollDecorModel 

    /*
     * 判断是否需要过度滚动反弹效果。
     *
     * 返回值 Bool
     */
    public func isOverScrollBounceEffect(): Bool 

    /*
     * 设置是否需要滑动效果。
     *
     * 参数 overScrollBounceEffect - 默认false
     * 返回值 OverScrollDecorModel - 滚动容器数据实例
     */
    public func setOverScrollBounceEffect(overScrollBounceEffect: Bool): OverScrollDecorModel 

    /*
     * 是否可以滑动。
     *
     * 返回值 Bool
     */
    public func isUpOverScroll(): Bool 

    /*
     * 设置是否可以滑动。
     *
     * 参数 upOverScroll - true
     * 返回值 OverScrollDecorModel - 滚动容器数据实例
     */
    public func setUpOverScroll(upOverScroll: Bool): OverScrollDecorModel 

    /*
     * 获取x偏移量。
     *
     * 返回值 Float64 - x偏移量
     */
    public func getOffsetX(): Float64 

    /*
     * 设置x偏移量。
     *
     * 参数 offsetX - x偏移量
     * 返回值 OverScrollDecorModel - 滚动容器数据实例
     */
    public func setOffsetX(offsetX: Float64): OverScrollDecorModel 

    /*
     * 获取y偏移量。
     *
     * 返回值 Float64 - y偏移量
     */
    public func getOffsetY(): Float64 

    /*
     * 设置y偏移量。
     *
     * 参数 offsetY - y偏移量
     * 返回值 OverScrollDecorModel - 滚动容器数据实例
     */
    public func setOffsetY(offsetY: Float64): OverScrollDecorModel 

    /*
     * 获取text颜色
     *
     * 返回值 String - text颜色
     */
    public func getTextColor(): String 

    /*
     * 设置text颜色
     *
     * 参数 textColor - 颜色
     * 返回值 OverScrollDecorModel - 滚动容器数据实例
     */
    public func setTextColor(textColor: String): OverScrollDecorModel
}


public enum ORIENTATION {
    | VERTICAL //垂直方向滚动
    | HORIZONTAL //水平方向滚动

    /*
     * 判等
     *
     * 参数 that - 要对比的对象
     * 返回值 Bool - 是否相等
     */
    public operator func ==(that: ORIENTATION): Bool

    /*
     * 判不等
     *
     * 参数 that - 要对比的对象
     * 返回值 Bool - 是否不等
     */
    public operator func !=(that: ORIENTATION): Bool
```

### 1.2 OverScrollDecor Component API Description
```cangjie
@Component
public class OverScrollDecor {
    @Link
    var model: OverScrollDecorModel		// 滚动容器对象Model
    @BuilderParam
    let child: () -> Unit				// 布局样式
	...
}
```

### 1.3 示例
#### 1.3.1 RecyclerView视图
```cangjie
import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*
import ohos.prompt_action.PromptAction
import ohos.router.Router
import std.math.floor
import std.convert.Parsable
import std.sync.{Timer, sleep}
import std.time.{Duration, MonoTime}
import overscrolldecor.*

@Entry
@Component
public class EntryView {
    var overScrollBounceEffect: Bool = true
    @State
    var viewPort: String = "Detach over-scroll"
    @State
    var uri: String = "RecyclerViewDetachDemo"

    private var color: Array<UInt32> = [0Xffaa66cc, 0Xff0099cc, 0Xff33b5e5, 0X00e0e0, 0Xff669900, 0Xff99cc00, 0Xf0e000,
        0Xffffbb33, 0Xffff8800, 0Xffff4444, 0Xffcc0000]
    private var colorName: Array<String> = ["PURPLE", "BLUE", "LIGHT BLUE", "CYAN", "GREEN", "LIGHT GREEN", "YELLOW",
        "LIGHT ORANGE", "ORANGE", "LIGHT RED", "RED"]
    @State
    var horizontalView: OverScrollDecorModel = OverScrollDecorModel()
    @State
    var verticalView: OverScrollDecorModel = OverScrollDecorModel()
    @State
    var isVisibility: Visibility = Visibility.None
    @State
    var backOffset: Float64 = 0.0

    protected override func aboutToAppear(): Unit {
        this.horizontalView.setUpOverScroll(true).setOrientation(ORIENTATION.HORIZONTAL).setOverScrollBounceEffect(
            this.overScrollBounceEffect).setScrollBar(false).setWidth(100.percent).setHeight(24.percent)

        this.verticalView.setUpOverScroll(true).setOrientation(ORIENTATION.VERTICAL).setOverScrollBounceEffect(
            this.overScrollBounceEffect).setScrollBar(false).setWidth(100.percent).setHeight(54.percent)
    }

    @Builder
    func recyclerViewVertical() {
        Flex(FlexParams(direction: FlexDirection.Column, alignItems: ItemAlign.Center)) {
            ForEach(
                this.colorName,
                itemGeneratorFunc: {
                    item: String, index: Int64 => Text(this.colorName[this.colorName.size - 1 - index]).width(
                        100.percent).height(20.percent).fontSize(35).textAlign(TextAlign.Center).backgroundColor(
                        this.color[this.colorName.size - 1 - index]).onClick(
                        {
                        evt => PromptAction.showToast(
                            message: "Tapped on: " + this.colorName[this.colorName.size - 1 - index],
                            duration: 2000
                        )
                    })
                }
            )
        }
    }

    @Builder
    func RecyclerViewHorizontal() {
        Flex(FlexParams(direction: FlexDirection.Row, alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center)) {
            ForEach(
                this.colorName,
                itemGeneratorFunc: {
                    item: String, index: Int64 =>
                        Text(item).width(20.percent).height(90.percent).fontSize(25).textAlign(
                        TextAlign.Center).backgroundColor(this.color[index]).onClick(
                        {
                        evt => PromptAction.showToast(message: "Tapped on: " + item, duration: 2000)
                    })
                }
            )
        }
    }

    func build() {
        Stack(Alignment.TopStart) {
            Flex(
                FlexParams(direction: FlexDirection.Column, alignItems: ItemAlign.Center,
                justifyContent: FlexAlign.Center)) {
                Row() {
                    Image(@r(app.media.ic_more)).objectFit(ImageFit.Contain).width(10.percent).height(65.percent).margin(
                        left: 16, right: 20).onClick(
                        {
                            evt =>
                            this.isVisibility = Visibility.Visible
                        }
                    )
                    Text("RecyclerView Over-Scroll Demo").fontSize(38).maxLines(1).fontColor(Color.WHITE).textOverflow(
                        TextOverflow.Ellipsis).width(60.percent)
                    Blank()
                    Image(@r(app.media.ic_select)).objectFit(ImageFit.Contain).width(8.percent).height(80.percent).
                        margin(left: 20, right: 10).bindMenu(
                        [
                            Action(
                                value: this.viewPort,
                                action: {
                                    => Router.push(url: uri)
                                }
                            )
                        ]
                    )
                }.width(100.percent).height(8.percent).backgroundColor(0Xffffbb33)

                Row() {
                    Text("⇔ Drag Horizontally").fontSize(24).fontColor(0X727171)
                    Blank()
                    Text(Int64(floor(this.horizontalView.getOffsetX())).toString()).fontSize(35).fontWeight(
                        FontWeight.W600).fontColor(UInt32.parse(this.horizontalView.getTextColor()))
                }.width(100.percent).padding(left: 16, right: 16)

                OverScrollDecor(model: this.horizontalView, child: this.RecyclerViewHorizontal)

                Row() {
                    Text("⇳ Drag Vertically").fontSize(24).fontColor(0X727171)
                    Blank()
                    Text(Int64(floor(this.verticalView.getOffsetY())).toString()).fontSize(35).fontWeight(
                        FontWeight.W600).fontColor(UInt32.parse(this.verticalView.getTextColor()))
                }.width(100.percent).padding(left: 16, right: 16)

                OverScrollDecor(model: this.verticalView, child: this.recyclerViewVertical)
            }

            Stack(Alignment.TopStart) {
                Flex() {
                    
                }.width(100.percent).height(100.percent).backgroundColor(Color.BLACK).opacity(0.5 + this.backOffset * 0.3
                ).onClick(
                    {
                        evt =>
                        this.isVisibility = Visibility.Visible
                    }
                )

                Flex() {
                    SideBar()
                }.offset(x: this.backOffset * 500.0, y: 0.0)
            }.width(100.percent).height(100.percent).visibility(this.isVisibility)
        }
    }
}

```

#### 1.3.2 ListView视图
```cangjie
import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*
import ohos.prompt_action.PromptAction
import overscrolldecor.*

@Entry
@Component
class ListViewDemo {

    private var color: Array<UInt32> = [0Xffaa66cc, 0Xff0099cc, 0Xff33b5e5, 0X00e0e0, 0Xff669900, 0Xff99cc00, 0Xf0e000,
        0Xffffbb33, 0Xffff8800, 0Xffff4444, 0Xffcc0000]
    private var colorName: Array<String> = ["PURPLE", "BLUE", "LIGHT BLUE", "CYAN", "GREEN", "LIGHT GREEN", "YELLOW",
        "LIGHT ORANGE", "ORANGE", "LIGHT RED", "RED"]
    @State
    var model: OverScrollDecorModel = OverScrollDecorModel()
    @State
    var isVisibility: Visibility = Visibility.None
    @State
    var backOffset: Float64 = 0.0

    protected override func aboutToAppear(): Unit {
        this.model.setUpOverScroll(true).setOrientation(ORIENTATION.VERTICAL).setOverScrollBounceEffect(true).
            setScrollBar(true).setWidth(100.percent).setHeight(85.percent)
    }

    @Builder
    func specificChild() {
        Flex(FlexParams(direction: FlexDirection.Column, alignItems: ItemAlign.Center)) {
            ForEach(
                this.colorName,
                itemGeneratorFunc: {
                    item: String, index: Int64 =>
                        Text(item)
                        .width(100.percent).height(20.percent)
                        .fontSize(35).textAlign(TextAlign.Center)
                        .backgroundColor(this.color[index])
                        .onClick({
                            evt =>
                            PromptAction.showToast(
                                message: "Tapped on: " + this.colorName[this.colorName.size - 1 - index],
                                duration: 2000
                            )
                        })
                }
            )
        }
    }

    func build() {
        Stack(Alignment.TopStart) {
            Flex(
                FlexParams(direction: FlexDirection.Column, alignItems: ItemAlign.Center,
                justifyContent: FlexAlign.Center)) {
                Row() {
                    Image(@r(app.media.ic_more)).objectFit(ImageFit.Contain).width(10.percent).height(65.percent).margin(
                        left: 16, right: 20).onClick({
                        evt =>

                        this.isVisibility = Visibility.Visible
                    })
                    Text("ListView Over-Scroll Demo").fontSize(38).maxLines(1).fontColor(Color.WHITE)
                    .textOverflow(TextOverflow.Ellipsis).width(80.percent)
               }.width(100.percent).height(8.percent).backgroundColor(0Xffffbb33)

              Text("⇳ Drag Vertically")
              .textAlign(TextAlign.Center).fontSize(35).width(100.percent).height(7.percent)
                .fontColor(0X727171).padding(top: 15)

                OverScrollDecor(model: this.model, child: this.specificChild)

            }

            Stack(Alignment.TopStart) {
                Flex() {

                }.width(100.percent).height(100.percent).backgroundColor(Color.BLACK)
                .opacity(0.5 + this.backOffset * 0.3
                ).onClick({
                    evt =>
                    this.isVisibility = Visibility.Visible
                })

                Flex() {
                    SideBar()
                }.offset(x: this.backOffset * 500.0, y: 0.0)
            }.width(100.percent).height(100.percent).visibility(this.isVisibility)
        }

    }
}
```

#### 1.3.3 GridView视图
```cangjie
import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*
import ohos.prompt_action.PromptAction
import overscrolldecor.*

@Entry
@Component
class GridViewDemo {

    private var color: Array<UInt32> = [0Xffaa66cc, 0Xff0099cc, 0Xff33b5e5, 0X00e0e0, 0Xff669900, 0Xff99cc00, 0Xf0e000,
        0Xffffbb33, 0Xffff8800, 0Xffff4444, 0Xffcc0000]
    private var colorName: Array<String> = ["PURPLE", "BLUE", "LIGHT BLUE", "CYAN", "GREEN", "LIGHT GREEN", "YELLOW",
        "LIGHT ORANGE", "ORANGE", "LIGHT RED", "RED"]
    @State
    var model: OverScrollDecorModel = OverScrollDecorModel()
    @State
    var isVisibility: Visibility = Visibility.None
    @State
    var backOffset: Float64 = 0.0

    protected override func aboutToAppear(): Unit {
        this.model.setUpOverScroll(true).setOrientation(ORIENTATION.VERTICAL).setOverScrollBounceEffect(true).
            setScrollBar(true).setWidth(100.percent).setHeight(85.percent)
    }

    @Builder
    func verticallyView(leftColorName: String, rightColorName: String, leftColor: UInt32, rightColor: UInt32) {
        Row(10) {
            Text(leftColorName).height(100.percent).width(50.percent).fontSize(30).textAlign(TextAlign.Center).
                backgroundColor(leftColor)
                    .onClick { evt =>
                    PromptAction.showToast( message: "Tapped on: " + leftColorName, duration: 2000)
            }

            Text(rightColorName).height(100.percent).width(50.percent).fontSize(30).textAlign(TextAlign.Center).
                backgroundColor(rightColor)
                    .onClick { evt =>
                     PromptAction.showToast( message: "Tapped on: " + rightColorName, duration: 2000)
            }
        }.width(100.percent).height(25.percent)
    }

    @Builder
    func specificChild() {
        Column(10) {
            this.verticallyView(this.colorName[0], this.colorName[1], this.color[0], this.color[1])
            this.verticallyView(this.colorName[2], this.colorName[3], this.color[2], this.color[3])
            this.verticallyView(this.colorName[4], this.colorName[5], this.color[4], this.color[5])
            this.verticallyView(this.colorName[6], this.colorName[7], this.color[6], this.color[7])
            this.verticallyView(this.colorName[8], this.colorName[9], this.color[8], this.color[9])
            this.verticallyView(this.colorName[10], this.colorName[10], this.color[10], this.color[10])
        }.width(100.percent)
    }

    func build() {
        Stack(Alignment.TopStart) {
            Flex(
                FlexParams(direction: FlexDirection.Column, alignItems: ItemAlign.Center,
                justifyContent: FlexAlign.Center)) {
                Row() {
                    Image(@r(app.media.ic_more)).objectFit(ImageFit.Contain).width(10.percent).height(65.percent).margin(
                        left: 16, right: 20).onClick({
                        evt =>

                        this.isVisibility = Visibility.Visible
                    })
                    Text("GridView Over-Scroll Demo").fontSize(38).maxLines(1).fontColor(Color.WHITE)
                    .textOverflow(TextOverflow.Ellipsis).width(80.percent)
               }.width(100.percent).height(8.percent).backgroundColor(0Xffffbb33)

              Text("⇳ Drag Vertically")
              .textAlign(TextAlign.Center).fontSize(35).width(100.percent).height(7.percent)
                .fontColor(0X727171).padding(top: 15)

                OverScrollDecor(model: this.model, child: this.specificChild)

            }

            Stack(Alignment.TopStart) {
                Flex() {

                }.width(100.percent).height(100.percent).backgroundColor(Color.BLACK)
                .opacity(0.5 + this.backOffset * 0.3
                ).onClick({
                    evt =>
                    this.isVisibility = Visibility.Visible
                })

                Flex() {
                    SideBar()
                }.offset(x: this.backOffset * 500.0, y: 0.0)
            }.width(100.percent).height(100.percent).visibility(this.isVisibility)
        }

    }
}
```

#### 1.3.4 ScrollView视图
```cangjie
import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*
import ohos.prompt_action.PromptAction
import overscrolldecor.*

@Entry
@Component
public class ScrollViewDemo {
    private var scroller: Scroller = Scroller()
    @State
    var horizontalView: OverScrollDecorModel = OverScrollDecorModel()
    @State
    var verticalView: OverScrollDecorModel = OverScrollDecorModel()
    @State
    var isVisibility: Visibility = Visibility.None
    @State
    var backOffset: Float64 = 0.0

    protected override func aboutToAppear(): Unit {
        this.horizontalView.setUpOverScroll(true).setOrientation(ORIENTATION.HORIZONTAL).setOverScrollBounceEffect(true).
            setScrollBar(true).setWidth(100.percent).setHeight(27.percent)

        this.verticalView.setUpOverScroll(true).setOrientation(ORIENTATION.VERTICAL).setOverScrollBounceEffect(true).
            setScrollBar(true).setWidth(100.percent).setHeight(51.percent)
    }

    @Builder
    func scrollViewVerticalItem() {
        Row(20) {
            Image(@r(app.media.image)).objectFit(ImageFit.Contain).width(20.percent).height(100)
            Text("EverythingMe").fontSize(31).fontColor(0XA9A9A9)
        }
    }

    @Builder
    func scrollViewVertical() {
        Flex(FlexParams(direction: FlexDirection.Column, alignItems: ItemAlign.Start)) {
            Column(20) {
                this.scrollViewVerticalItem()
                this.scrollViewVerticalItem()
                this.scrollViewVerticalItem()
                this.scrollViewVerticalItem()
                this.scrollViewVerticalItem()
                this.scrollViewVerticalItem()
                this.scrollViewVerticalItem()
                this.scrollViewVerticalItem()
                this.scrollViewVerticalItem()
                this.scrollViewVerticalItem()
            }
        }.width(100.percent)
    }

    @Builder
    func scrollViewHorizontalItem() {
        Column(20) {
            Image(@r(app.media.image)).objectFit(ImageFit.Contain).width(20.percent).height(42.percent)
            Text("EverythingMe").fontSize(28).fontColor(0XA9A9A9)
        }
    }

    @Builder
    func scrollViewHorizontal() {
        Flex(FlexParams(direction: FlexDirection.Column)) {
            Row(20) {
                this.scrollViewHorizontalItem()
                this.scrollViewHorizontalItem()
                this.scrollViewHorizontalItem()
                this.scrollViewHorizontalItem()
                this.scrollViewHorizontalItem()
                this.scrollViewHorizontalItem()
                this.scrollViewHorizontalItem()
                this.scrollViewHorizontalItem()
                this.scrollViewHorizontalItem()
                this.scrollViewHorizontalItem()
            }
        }
    }

    func build() {
        Stack(Alignment.TopStart) {
            Flex(
                FlexParams(direction: FlexDirection.Column, alignItems: ItemAlign.Center,
                justifyContent: FlexAlign.Center)) {
                Row() {
                    Image(@r(app.media.ic_more)).objectFit(ImageFit.Contain).width(10.percent).height(65.percent).margin(
                        left: 16, right: 20).onClick({
                        evt => this.isVisibility = Visibility.Visible
                    })
                    Text("ScrollView Over-Scroll Demo").fontSize(38).maxLines(1).fontColor(Color.WHITE).textOverflow(
                        TextOverflow.Ellipsis).width(80.percent)
                }.width(100.percent).height(8.percent).backgroundColor(0Xffffbb33)


                Text("⇔ Drag Horizontally").textAlign(TextAlign.Center).fontSize(35).width(100.percent).height(
                    7.percent).fontColor(0X727171)
                OverScrollDecor(model: this.horizontalView, child: this.scrollViewHorizontal)

                Text("⇳ Drag Vertically").textAlign(TextAlign.Center).fontSize(35).width(100.percent).height(
                    7.percent).fontColor(0X727171)
                OverScrollDecor(model: this.verticalView, child: this.scrollViewVertical)
            }

            Stack(Alignment.TopStart) {
                Flex() {

                }.width(100.percent).height(100.percent).backgroundColor(Color.BLACK).opacity(
                    0.5 + this.backOffset * 0.3).onClick({
                    evt =>

                    this.isVisibility = Visibility.Visible
                })

                Flex() {
                    SideBar()
                }.offset(x: this.backOffset * 500.0, y: 0.0)
            }.width(100.percent).height(100.percent).visibility(this.isVisibility)

        }
    }
}
```

#### 1.3.5 Any View视图
```cangjie
import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*
import ohos.prompt_action.PromptAction
import std.sync.*
import std.time.{Duration, MonoTime}
import overscrolldecor.*

@Entry
@Component
public class MiscViewsDemo {
    private var timer: String = ""
    @State
    var textView: OverScrollDecorModel = OverScrollDecorModel()
    @State
    var imageView: OverScrollDecorModel = OverScrollDecorModel()
    @State
    var chronometer: OverScrollDecorModel = OverScrollDecorModel()
    @State
    var isVisibility: Visibility = Visibility.None
    @State
    var backOffset: Float64 = 0.0
    var textTimerController: TextTimerController = TextTimerController()
    @State var format: String = 'mm:ss'


    protected override func aboutToAppear(): Unit {

        this.textView.setUpOverScroll(true).setOrientation(ORIENTATION.HORIZONTAL).setOverScrollBounceEffect(true).
            setScrollBar(false).setWidth(100.percent).setHeight(28.percent)

        this.imageView.setUpOverScroll(true).setOrientation(ORIENTATION.VERTICAL).setOverScrollBounceEffect(true).
            setScrollBar(false).setWidth(100.percent).setHeight(36.percent)

        this.chronometer.setUpOverScroll(true).setOrientation(ORIENTATION.HORIZONTAL).setOverScrollBounceEffect(true).
            setScrollBar(false).setWidth(100.percent).setHeight(28.percent)
    }

    @Builder
    func textViewScroll() {
        Flex(FlexParams(direction: FlexDirection.Column, alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center)
        ) {
            Text("Practically any clickable widget can be over-scrolled.\nTry it!").textAlign(TextAlign.Center).fontSize(
                30).width(75.percent).fontColor(0X727171)
        }.width(105.percent)
    }

    @Builder
    func imageViewScroll() {
        Flex(FlexParams(alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center)) {
            Image(@r(app.media.image)).objectFit(ImageFit.Contain).width(33.percent).height(50.percent)
        }.width(100.percent).height(105.percent)
    }

    @Builder
    func chronometerViewScroll() {
        Flex(FlexParams(direction: FlexDirection.Column, alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center)
        ) {
             TextTimer(isCountDown: false, controller: this.textTimerController)
                .format(this.format)
                .fontColor(Color.BLACK)
                .fontSize(50)
        }.width(105.percent)
    }

    func build() {
        Stack(Alignment.TopStart) {
            Flex(
                FlexParams(direction: FlexDirection.Column, alignItems: ItemAlign.Center,
                justifyContent: FlexAlign.Center)) {
                Row() {
                    Image(@r(app.media.ic_more)).objectFit(ImageFit.Contain).width(10.percent).height(65.percent).margin(
                        left: 16, right: 20).onClick({
                        evt => this.isVisibility = Visibility.Visible
                    })
                    Text("Misc. Over-Scroll Demo").fontSize(38).maxLines(1).fontColor(Color.WHITE).textOverflow(
                        TextOverflow.Ellipsis).width(80.percent)
                }.width(100.percent).height(8.percent).backgroundColor(0Xffffbb33)
                OverScrollDecor(model: this.textView, child: this.textViewScroll)
                OverScrollDecor(model: this.imageView, child: this.imageViewScroll)
                OverScrollDecor(model: this.chronometer, child: this.chronometerViewScroll)
            }

            Stack(Alignment.TopStart) {
                Flex() {
                    
                }.width(100.percent).height(100.percent).backgroundColor(Color.BLACK).opacity(0.5 + this.backOffset * 0.3
                ).onClick({
                    evt => this.isVisibility = Visibility.Visible
                })

                Flex() {
                    SideBar()
                }.offset(x: this.backOffset * 500.0, y: 0.0)
            }.width(100.percent).height(100.percent).visibility(this.isVisibility)
        }.onTouch({
                    evt => this.textTimerController.start()
                })
    }
}
```

## 2 ViewPager视图
### 2.1 ViewPagerOverScrollModel class API Description
```cangjie
@Observed
public class ViewPagerOverScrollModel {
    /*
     * 获取边框高度。
     *
     * 返回值 Length - 边框高度
     */
    public func getHeight(): Length 

    /*
     * 设置边框高度
     *
     * 参数 height - 高度
     * 返回值 ViewPagerOverScrollModel - 滚动容器数据实例
     */
    public func setHeight(height: Length): ViewPagerOverScrollModel 

    /*
     * 获取边框宽度。
     *
     * 返回值 Length - 边框宽度
     */
    public func getWidth(): Length 

    /*
     * 设置边框宽度。
     *
     * 参数 width - 宽度大小
     * 返回值 ViewPagerOverScrollModel - 滚动容器数据实例
     */
    public func setWidth(width: Length): ViewPagerOverScrollModel 
}
```

### 2.2 ViewPagerOverScroll Component API Description
```cangjie
@Component
public class ViewPagerOverScroll {
    @Link
    var model: ViewPagerOverScrollModel
    @BuilderParam
    let child: () -> Unit

    func build() {
        Flex(FlexParams(alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center)) {
            this.child()
        }.height(this.model.mHeight).width(this.model.mWidth)
    }
}
```

### 2.3 示例
```cangjie
import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*
import ohos.prompt_action.PromptAction
import std.sync.{Timer, sleep}
import std.time.{Duration, MonoTime}
import overscrolldecor.*

@Entry
@Component
public class ViewPagerDemo {
    private var color: Array<UInt32> = [0Xffaa66cc, 0Xff0099cc, 0Xff33b5e5, 0X00e0e0, 0Xff669900, 0Xff99cc00, 0Xf0e000,
        0Xffffbb33, 0Xffff8800, 0Xffff4444, 0Xffcc0000]
    private var colorName: Array<String> = ["PURPLE", "BLUE", "LIGHT BLUE", "CYAN", "GREEN", "LIGHT GREEN", "YELLOW",
        "LIGHT ORANGE", "ORANGE", "LIGHT RED", "RED"]
    @State
    var model: ViewPagerOverScrollModel = ViewPagerOverScrollModel()
    @State
    var isVisibility: Visibility = Visibility.None
    @State
    var backOffset: Float64 = 0.0
    private var controller: TabsController = TabsController()
    private var itemIndex: Int64 = 0

    protected override func aboutToAppear(): Unit {
        this.model.setWidth(100.percent).setHeight(92.percent)
    }

    @Builder
    func SquareText(index: Int64) {
        Flex(FlexParams(direction: FlexDirection.Column, alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center)
        ) {
            Text(this.colorName[index]).fontSize(28).textAlign(TextAlign.Center)
        }.height(100.percent).width(100.percent).backgroundColor(this.color[index])
    }

    @Builder
    func specificChild() {
        Tabs(this.controller) {
            TabContent() {
                this.SquareText(0)
            }
            TabContent() {
                this.SquareText(1)
            }
            TabContent() {
                this.SquareText(2)
            }
            TabContent() {
                this.SquareText(3)
            }
            TabContent() {
                this.SquareText(4)
            }
            TabContent() {
                this.SquareText(5)
            }
            TabContent() {
                this.SquareText(6)
            }
            TabContent() {
                this.SquareText(7)
            }
            TabContent() {
                this.SquareText(8)
            }
            TabContent() {
                this.SquareText(9)
            }
            TabContent() {
                this.SquareText(10)
            }
        }.height(100.percent).width(100.percent).barWidth(0).barHeight(0).padding(16)
    }

    func build() {
        Stack(Alignment.TopStart) {
            Flex(
                FlexParams(direction: FlexDirection.Column, alignItems: ItemAlign.Center,
                justifyContent: FlexAlign.Center)) {
                Row() {
                    Image(@r(app.media.ic_more)).objectFit(ImageFit.Contain).width(10.percent).height(65.percent).margin(
                        left: 16, right: 20).onClick({
                        evt =>
                        this.isVisibility = Visibility.Visible
                    })
                    Text("ViewPager Over-Scroll Demo").fontSize(38).maxLines(1).fontColor(Color.WHITE).textOverflow(
                        TextOverflow.Ellipsis).width(80.percent)
                }.width(100.percent).height(8.percent).backgroundColor(0Xffffbb33)

                ViewPagerOverScroll(model: this.model, child: this.specificChild)
            }

            Stack(Alignment.TopStart) {
                Flex() {

                }.width(100.percent).height(100.percent).backgroundColor(Color.BLACK).opacity(0.5 + this.backOffset * 0.3
                ).onClick({
                        evt =>

                        this.isVisibility = Visibility.Visible
                })

                Flex() {
                    SideBar()
                }.offset(x: this.backOffset * 500.0, y: 0.0)
            }.width(100.percent).height(100.percent).visibility(this.isVisibility)
        }
    }
}
```