package ohos_app_cangjie_entry

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*
import ohos.prompt_action.PromptAction
import overscrolldecor.*
import ohos.resource_manager.__GenerateResource__
import ohos.hilog.Hilog

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
        model.setUpOverScroll(true)
        .setOrientation(ORIENTATION.VERTICAL)
        .setOverScrollBounceEffect(true)
        .setScrollBar(true)
        .setWidth(100.percent)
        .setHeight(85.percent)
        .setMargin(20.0)
        .setUpOverScroll(true)
        .setOffsetX(10.0)
        .setOffsetY(15.0)
        .setTextColor("0X333333")
        .setClearColor("0X444444")
        .setDragColorLeft("0Xff555555")
        .setBounceBackColorLeft("0Xff666666")
        .setDragColorRight("0Xff777777")
        .setBounceBackColorRight("0Xff888888")
        .setDragColorTop("0Xff999999")
        .setBounceBackColorTop("0Xffaaaaaa")
        .setDragColorBottom("0Xffbbbbbb")
        .setBounceBackColorBottom("0Xffcccccc")
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
        Column(){
            Button().width(90.percent).height(40).onClick({
                event =>
                    checkResult()
            })
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
        }.width(100.percent).height(100.percent)
    }

    func checkResult(): Unit {
        var mHeight = model.getHeight().value
        var mWidth = model.getWidth().value
        var mMargin = model.getMargin()
        var mOrientation = model.getOrientation()
        var mScrollBar = model.isScrollBar()
        var mBounceEffect = model.isOverScrollBounceEffect()
        var mUpOverScroll = model.isUpOverScroll()
        var mOffsetX = model.getOffsetX()
        var mOffsetY = model.getOffsetY()
        var mTextColor = model.getTextColor()
        var mClearColor = model.getClearColor()
        var mDragColorLeft = model.getDragColorLeft()
        var mBounceBackColorLeft = model.getBounceBackColorLeft()
        var mDragColorRight = model.getDragColorRight()
        var mBounceBackColorRight = model.getBounceBackColorRight()
        var mDragColorTop = model.getDragColorTop()
        var mBounceBackColorTop = model.getBounceBackColorTop()
        var mDragColorBottom = model.getDragColorBottom()
        var mBounceBackColorBottom = model.getBounceBackColorBottom()

        Hilog.error(333, "checkResult", "mHeight-------> ${mHeight == 0.85}")
        Hilog.error(333, "checkResult", "mWidth-------> ${mWidth == 1.0}")
        Hilog.error(333, "checkResult", "mMargin-------> ${mMargin == 20.0}")
        Hilog.error(333, "checkResult", "mOrientation-------> ${mOrientation == ORIENTATION.VERTICAL}")
        Hilog.error(333, "checkResult", "mScrollBar-------> ${mScrollBar}")
        Hilog.error(333, "checkResult", "mBounceEffect-------> ${mBounceEffect}")
        Hilog.error(333, "checkResult", "mUpOverScroll-------> ${mUpOverScroll}")
        Hilog.error(333, "checkResult", "mOffsetX-------> ${mOffsetX == 10.0}")
        Hilog.error(333, "checkResult", "mOffsetY-------> ${mOffsetY == 15.0}")
        Hilog.error(333, "checkResult", "mTextColor-------> ${mTextColor == "0X333333"}")
        Hilog.error(333, "checkResult", "mClearColor-------> ${mClearColor == "0X444444"}")
        Hilog.error(333, "checkResult", "mDragColorLeft-------> ${mDragColorLeft == "0Xff555555"}")
        Hilog.error(333, "checkResult", "mBounceBackColorLeft-------> ${mBounceBackColorLeft == "0Xff666666"}")
        Hilog.error(333, "checkResult", "mDragColorRight-------> ${mDragColorRight == "0Xff777777"}")
        Hilog.error(333, "checkResult", "mBounceBackColorRight-------> ${mBounceBackColorRight == "0Xff888888"}")
        Hilog.error(333, "checkResult", "mDragColorTop-------> ${mDragColorTop == "0Xff999999"}")
        Hilog.error(333, "checkResult", "mBounceBackColorTop-------> ${mBounceBackColorTop == "0Xffaaaaaa"}")
        Hilog.error(333, "checkResult", "mDragColorBottom-------> ${mDragColorBottom == "0Xffbbbbbb"}")
        Hilog.error(333, "checkResult", "mBounceBackColorBottom-------> ${mBounceBackColorBottom == "0Xffcccccc"}")
    }
}
