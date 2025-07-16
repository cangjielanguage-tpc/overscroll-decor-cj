/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package ohos_app_cangjie_entry

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*
import ohos.prompt_action.PromptAction
import ohos.router.Router
import std.convert.Parsable
import std.math.floor
import std.sync.*
import std.time.*
import overscrolldecor.*
import ohos.resource_manager.__GenerateResource__

@Component
public class BaseView {
    var overScrollBounceEffect: Bool = true
    @State
    var viewPort: String = "Detach over-scroll"
    @State
    var uri: String = "recyclerViewDetachDemo"

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
    func RecyclerViewVertical() {
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
        Flex(FlexParams(direction: FlexDirection.Row, alignItems: ItemAlign.Center)) {
            ForEach(
                this.colorName,
                itemGeneratorFunc: {
                    item: String, index: Int64 => Text(item).width(20.percent).height(90.percent).fontSize(25).textAlign(
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
                    Text(Int64(floor(this.horizontalView.getOffsetX())).toString()).fontSize(35).fontWeight(FontWeight.W600).
                        fontColor(UInt32.parse(this.horizontalView.getTextColor()))
                }.width(100.percent).padding(left: 16, right: 16)

                OverScrollDecor(model: this.horizontalView, child: this.RecyclerViewHorizontal)

                Row() {
                    Text("⇳ Drag Vertically").fontSize(24).fontColor(0X727171)
                    Blank()
                    Text(Int64(floor(this.verticalView.getOffsetY())).toString()).fontSize(35).fontWeight(FontWeight.W600).
                        fontColor(UInt32.parse(this.verticalView.getTextColor()))
                }.width(100.percent).padding(left: 16, right: 16)

                OverScrollDecor(model: this.verticalView, child: this.RecyclerViewVertical)
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
