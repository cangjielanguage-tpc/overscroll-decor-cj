/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package ohos_app_cangjie_entry

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
