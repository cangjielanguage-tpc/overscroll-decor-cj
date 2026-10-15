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
