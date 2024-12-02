/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package ohos_app_cangjie_entry

import ohos.state_macro_manage.*
import ohos.component.*
import ohos.state_manage.*

@Entry
@Component
class RecyclerViewAttachDemo {

  func build() {
    Column() {
        BaseView(overScrollBounceEffect: false, viewPort: "Detach over-scroll", uri: "RecyclerViewDetachDemo")
    }
  }
}
