/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package ohos_app_cangjie_entry

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*
import ohos.router.*

@Component
class SideBar {

 func build() {
    Column(10) {
      Row(5) {
        Image(@r(app.media.image)).objectFit(ImageFit.Contain)
          .width(29.percent).height(53.percent)
          .margin(left: 16, right: 16)
        Column(10) {
          Text("Over-Scroll Demo App").fontSize(30).fontColor(Color.WHITE).width(60.percent)
          Text("EverythingMe").fontSize(22).fontColor(Color.WHITE)
        }.alignItems(HorizontalAlign.Start)
      }
      .height(20.percent).width(100.percent)
      .backgroundColor(0Xffffbb33)

      Row(15) {
        Image(@r(app.media.ic_recycler)).objectFit(ImageFit.Contain)
          .width(10.percent).height(65.percent).margin(left: 8)
        Text("RecyclerView Demo").fontSize(14).fontColor(0X727171)
      }.height(6.percent).width(100.percent)
      .onClick({ evn =>
        Router.push(url: "RecyclerViewAttachDemo" )
      })

      Row(15) {
        Image(@r(app.media.ic_recycler)).objectFit(ImageFit.Contain)
          .width(10.percent).height(65.percent).margin(left: 8)
        Text("RecyclerView - St.Grid Demo").fontSize(14).fontColor(0X727171)
      }.height(6.percent).width(100.percent)
      .onClick({evn =>
        Router.push( url: "RecyclerViewStaggeredGridDemo" )
      })

      Row(15) {
        Image(@r(app.media.ic_grid)).objectFit(ImageFit.Contain)
          .width(10.percent).height(65.percent).margin(left: 8)
        Text("Grid Demo").fontSize(14).fontColor(0X727171)
      }.height(6.percent).width(100.percent)
      .onClick({ evn =>
         Router.push(url: "GridViewDemo" )
      })

      Row(15) {
        Image(@r(app.media.ic_list)).objectFit(ImageFit.Contain)
          .width(10.percent).height(65.percent).margin(left: 8)
        Text("ListView Demo").fontSize(14).fontColor(0X727171)
      }.height(6.percent).width(100.percent)
      .onClick({evn =>
        Router.push( url: "ListViewDemo" )
      })

      Row(15) {
        Image(@r(app.media.ic_scroller)).objectFit(ImageFit.Contain)
          .width(10.percent).height(65.percent).margin(left: 8)
        Text("ScrollView Demo").fontSize(14).fontColor(0X727171)
      }.height(6.percent).width(100.percent)
      .onClick({evn =>
        Router.push( url: "ScrollViewDemo" )
      })

      Row(15) {
        Image(@r(app.media.ic_view_pager)).objectFit(ImageFit.Contain)
          .width(10.percent).height(65.percent).margin(left: 8)
        Text("ViewPager Demo").fontSize(14).fontColor(0X727171)
      }.height(6.percent).width(100.percent)
      .onClick({evn =>
        Router.push( url: "ViewPagerDemo" )
      })

      Row(15) {
        Image(@r(app.media.ic_nested)).objectFit(ImageFit.Contain)
          .width(10.percent).height(65.percent).margin(left: 8)
        Text("NestedScrollView Demo").fontSize(14).fontColor(0X727171)
      }.height(6.percent).width(100.percent)
      .onClick({ evn =>
        Router.push(url: "NestedScrollViewDemo" )
      })

      Row(15) {
        Image(@r(app.media.ic_misc)).objectFit(ImageFit.Contain)
          .width(10.percent).height(65.percent).margin(left: 8)
        Text("Misc-Views  Demo").fontSize(14).fontColor(0X727171)
      }.height(6.percent).width(100.percent)
      .onClick({ evn =>
        Router.push(url: "MiscViewsDemo")
      })
    }
    .height(100.percent).width(85.percent)
    .backgroundColor(Color.WHITE)
  }
}
