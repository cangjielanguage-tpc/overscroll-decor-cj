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
