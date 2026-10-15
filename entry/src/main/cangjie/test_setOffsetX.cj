package ohos_app_cangjie_entry

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*
import ohos.prompt_action.PromptAction
import ohos.router.Router
import std.math.floor
import std.convert.Parsable
import std.sync.*
import std.time.*
import overscrolldecor.*

@Entry
@Component
class Case19 {
    var caseNameBase: String = "Case19_setOffsetX_02"
    var caseNameDetail: String = "正常值（100.00）"
    var curValue=100.00

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

    protected override func aboutToAppear(): Unit {
        this.horizontalView.setUpOverScroll(true).setOrientation(ORIENTATION.HORIZONTAL).setOverScrollBounceEffect(
            true).setScrollBar(true).setWidth(100.percent).setHeight(24.percent).setOffsetX(curValue)
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
        Column(){
            Row(){
                Text("test_${caseNameBase}").width(100.percent).fontSize(20)
            }
            Row(){
                Text(caseNameDetail).width(100.percent).fontSize(20)
            }
            Row(){
                Text("getOffsetX = ${this.horizontalView.getOffsetX()}").width(100.percent).fontSize(20)
            }
            Stack(Alignment.TopStart) {
                Flex(
                    FlexParams(direction: FlexDirection.Column, alignItems: ItemAlign.Center,
                    justifyContent: FlexAlign.Center)) {
                    OverScrollDecor(model: this.horizontalView, child: this.RecyclerViewHorizontal)
                }
            }
        }
    }
}