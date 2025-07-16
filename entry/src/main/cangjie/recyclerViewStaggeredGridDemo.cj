/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package ohos_app_cangjie_entry

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*
import ohos.prompt_action.PromptAction
import overscrolldecor.*
import ohos.resource_manager.__GenerateResource__

@Entry
@Component
public class RecyclerViewStaggeredGridDemo {
    private var leftColor: Array<UInt32> = [0Xffcc0000, 0Xffff8800, 0Xf0e000, 0Xff99cc00, 0Xff33b5e5, 0Xffaa66cc]
    private var leftColorName: Array<String> = ["RED", "ORANGE", "YELLOW", "LIGHT GREEN", "LIGHT BLUE", "PURPLE"]
    private var leftHeight: Array<Int64> = [220, 220, 220, 330, 330, 220]

    private var rightColor: Array<UInt32> = [0Xffff4444, 0Xffffbb33, 0Xff669900, 0X00e0e0, 0Xff0099cc]
    private var rightColorName: Array<String> = ["LIGHT RED", "LIGHT ORANGE", "GREEN", "CYAN", "BLUE"]
    private var rightHeight: Array<Int64> = [330, 330, 220, 220, 220]

    @State
    var model: OverScrollDecorModel = OverScrollDecorModel()
    @State
    var isVisibility: Visibility = Visibility.None
    @State
    var backOffset: Float64 = 0.0

    protected override func aboutToAppear(): Unit {
        this.model.setUpOverScroll(true).setOrientation(ORIENTATION.VERTICAL).setOverScrollBounceEffect(true).
            setScrollBar(false).setWidth(100.percent).setHeight(85.percent)
    }

    @Builder
    func leftView() {
        Column() {
            ForEach(
                this.leftColorName,
                itemGeneratorFunc: {
                    item: String, index: Int64 => Text(item).fontSize(35).width(100.percent).height(
                        this.leftHeight[index]).textAlign(TextAlign.Center).backgroundColor(this.leftColor[index]).
                        onClick({
                        evt => PromptAction.showToast(message: "Tapped on: " + item, duration: 2000)
                    })
                }
            )
        }.width(100.percent)
    }

    @Builder
    func rightView() {
        Column() {
            ForEach(
                this.rightColorName,
                itemGeneratorFunc: {
                    item: String, index: Int64 => Text(item).fontSize(35).width(100.percent).height(
                        this.rightHeight[index]).textAlign(TextAlign.Center).backgroundColor(this.rightColor[index]).
                        onClick({
                        evt => PromptAction.showToast(message: "Tapped on: " + item, duration: 2000)
                    })
                }
            )
        }.width(100.percent)
    }

    @Builder
    func specificChild() {
        Flex(FlexParams(direction: FlexDirection.Column)) {
            Flex(FlexParams(alignItems: ItemAlign.Start)) {
                Flex() {
                    this.leftView()
                }.width(50.percent)

                Flex() {
                    this.rightView()
                }.width(50.percent)
            }
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
                        evt => this.isVisibility = Visibility.Visible
                    })
                    Text("RecyclerView St.Grid Over-Scroll Demo").fontSize(38).maxLines(1).fontColor(Color.WHITE).
                        textOverflow(TextOverflow.Ellipsis).width(80.percent)
                }.width(100.percent).height(8.percent).backgroundColor(0Xffffbb33)

                Text("⇳ Drag Vertically").textAlign(TextAlign.Center).fontSize(35).width(100.percent).height(7.percent).
                    fontColor(0X727171).padding(top: 15)

                OverScrollDecor(model: this.model, child: this.specificChild)
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
        }
    }
}
