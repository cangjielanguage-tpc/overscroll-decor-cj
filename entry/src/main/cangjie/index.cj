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
import std.math.floor
import std.convert.Parsable
import std.sync.*
import std.time.*
import overscrolldecor.*

@Entry
@Component
public class EntryView {
    func build() {
         Column {
            Text("测试主页面")
                // 宽度
                .width(100.percent)
                // 文本颜色
                .fontColor(0x000000)
                // 背景颜色
                .backgroundColor(0xFFFFFF)
                // 字体大小
                .fontSize(25)
                //设置文字居中
                .textAlign(TextAlign.Center)
            Divider()
                // 分割线颜色
                .color(0x000000)
                // 分割线高度
                .strokeWidth(1)
                // 内边距属性
                .margin(top: 10, bottom: 10)
            Scroll() {
                Column {
                    Button("HLT Test")
                        .height(40)
                        .width(80.percent)
                        .shape(ShapeType.Capsule)
                        .fontColor(0xFFFFFF)
                        .padding(5)
                        .align(Alignment.Center)
                        .margin(5)
                        .fontSize(13)
                        .onClick {Router.push(url: "InitTest")}

                    Button("ViewPagerDemo Test").id("ViewPagerDemo")
                        .height(40)
                        .width(80.percent)
                        .shape(ShapeType.Capsule)
                        .fontColor(0xFFFFFF)
                        .padding(5)
                        .align(Alignment.Center)
                        .margin(5)
                        .fontSize(13)
                        .onClick {Router.push(url: "ViewPagerDemo")}

                    Button("GridViewDemo Test").id("GridViewDemo")
                        .height(40)
                        .width(80.percent)
                        .shape(ShapeType.Capsule)
                        .fontColor(0xFFFFFF)
                        .padding(5)
                        .align(Alignment.Center)
                        .margin(5)
                        .fontSize(13)
                        .onClick {Router.push(url: "GridViewDemo")}

                    Button("ListViewDemo Test").id("ListViewDemo")
                        .height(40)
                        .width(80.percent)
                        .shape(ShapeType.Capsule)
                        .fontColor(0xFFFFFF)
                        .padding(5)
                        .align(Alignment.Center)
                        .margin(5)
                        .fontSize(13)
                        .onClick {Router.push(url: "ListViewDemo")}

                    Button("MiscViewsDemo Test").id("MiscViewsDemo")
                        .height(40)
                        .width(80.percent)
                        .shape(ShapeType.Capsule)
                        .fontColor(0xFFFFFF)
                        .padding(5)
                        .align(Alignment.Center)
                        .margin(5)
                        .fontSize(13)
                        .onClick {Router.push(url: "MiscViewsDemo")}

                    Button("NestedScrollViewDemo Test").id("NestedScrollViewDemo")
                        .height(40)
                        .width(80.percent)
                        .shape(ShapeType.Capsule)
                        .fontColor(0xFFFFFF)
                        .padding(5)
                        .align(Alignment.Center)
                        .margin(5)
                        .fontSize(13)
                        .onClick {Router.push(url: "NestedScrollViewDemo")}

                    Button("RecyclerViewAttachDemo Test").id("RecyclerViewAttachDemo")
                        .height(40)
                        .width(80.percent)
                        .shape(ShapeType.Capsule)
                        .fontColor(0xFFFFFF)
                        .padding(5)
                        .align(Alignment.Center)
                        .margin(5)
                        .fontSize(13)
                        .onClick {Router.push(url: "RecyclerViewAttachDemo")}

                    Button("RecyclerViewDetachDemo Test").id("RecyclerViewDetachDemo")
                        .height(40)
                        .width(80.percent)
                        .shape(ShapeType.Capsule)
                        .fontColor(0xFFFFFF)
                        .padding(5)
                        .align(Alignment.Center)
                        .margin(5)
                        .fontSize(13)
                        .onClick {Router.push(url: "RecyclerViewDetachDemo")}

                     Button("RecyclerViewStaggeredGridDemo Test").id("RecyclerViewStaggeredGridDemo")
                        .height(40)
                        .width(80.percent)
                        .shape(ShapeType.Capsule)
                        .fontColor(0xFFFFFF)
                        .padding(5)
                        .align(Alignment.Center)
                        .margin(5)
                        .fontSize(13)
                        .onClick {Router.push(url: "RecyclerViewStaggeredGridDemo")}

                     Button("ScrollViewDemo Test").id("ScrollViewDemo")
                        .height(40)
                        .width(80.percent)
                        .shape(ShapeType.Capsule)
                        .fontColor(0xFFFFFF)
                        .padding(5)
                        .align(Alignment.Center)
                        .margin(5)
                        .fontSize(13)
                        .onClick {Router.push(url: "ScrollViewDemo")}

                     Button("Case19 Test").id("Case19")
                        .height(40)
                        .width(80.percent)
                        .shape(ShapeType.Capsule)
                        .fontColor(0xFFFFFF)
                        .padding(5)
                        .align(Alignment.Center)
                        .margin(5)
                        .fontSize(13)
                        .onClick {Router.push(url: "Case19")}

                    Button("Case21 Test").id("Case21")
                        .height(40)
                        .width(80.percent)
                        .shape(ShapeType.Capsule)
                        .fontColor(0xFFFFFF)
                        .padding(5)
                        .align(Alignment.Center)
                        .margin(5)
                        .fontSize(13)
                        .onClick {Router.push(url: "Case21")}
                }
                .width(100.percent)
            }
            .scrollable(ScrollDirection.Vertical)
        }
    }
}
