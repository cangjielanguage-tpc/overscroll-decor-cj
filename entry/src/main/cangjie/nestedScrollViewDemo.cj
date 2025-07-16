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
public class NestedScrollViewDemo {
    private var scroller: Scroller = Scroller()
    @State
    var textView: OverScrollDecorModel = OverScrollDecorModel()
    @State
    var scrollView: OverScrollDecorModel = OverScrollDecorModel()
    @State
    var isVisibility: Visibility = Visibility.None
    @State
    var backOffset: Float64 = 0.0

    protected override func aboutToAppear(): Unit {
        this.textView.setUpOverScroll(true).setOrientation(ORIENTATION.VERTICAL).setOverScrollBounceEffect(false).
            setScrollBar(false).setWidth(100.percent).setHeight(30.percent).setMargin(16.0)

        this.scrollView.setUpOverScroll(true).setOrientation(ORIENTATION.VERTICAL).setOverScrollBounceEffect(false).
            setScrollBar(false).setWidth(100.percent).setHeight(92.percent)
    }

    @Builder
    func scrollViewVerticalItem() {
        Row(20) {
            Image(@r(app.media.image)).objectFit(ImageFit.Contain).width(20.percent).height(13.percent)
            Text("EverythingMe").fontSize(31).fontColor(0XA9A9A9)
        }
    }

    @Builder
    func textViewScroll() {
        Column() {
            Text(
                "This text box is scrollable thanks to being situated inside a nested scroll view. That makes it scrollable regardless of the scrolling of the content of the entire screen, which can be scrolled independently.\nThe point here is to demonstrate how the over-scroll effect can work in the presence of nested scroll-views, provided it is applied over the parent (root) view, regardless of having inner nested scroll-views as children.\nIn this demo, the root view is merely a ScrollView, and therefore applying the effect over it is straightforward (i.e. using the OverScrollHelper)."
            ).fontSize(40).fontWeight(W600).fontColor(0X727171)
        }.width(100.percent)
    }

    @Builder
    func specificChild() {
        Column(20) {
            OverScrollDecor(model: this.textView, child: this.textViewScroll)
            this.scrollViewVerticalItem()
            this.scrollViewVerticalItem()
            this.scrollViewVerticalItem()
            this.scrollViewVerticalItem()
            this.scrollViewVerticalItem()
            this.scrollViewVerticalItem()
            this.scrollViewVerticalItem()
            this.scrollViewVerticalItem()
            this.scrollViewVerticalItem()
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
                    Text("NestedScrollView Over-Scroll Demo").fontSize(38).maxLines(1).fontColor(Color.WHITE).
                        textOverflow(TextOverflow.Ellipsis).width(80.percent)
                }.width(100.percent).height(8.percent).backgroundColor(0Xffffbb33)
                OverScrollDecor(model: this.scrollView, child: this.specificChild)
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
