package ohos_app_cangjie_entry

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
