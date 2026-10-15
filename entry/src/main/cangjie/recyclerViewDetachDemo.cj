package ohos_app_cangjie_entry

import ohos.state_macro_manage.*
import ohos.component.*
import ohos.state_manage.*

@Entry
@Component
class RecyclerViewDetachDemo {

  func build() {
    Column() {
        BaseView(overScrollBounceEffect: true, viewPort: "Attach over-scroll", uri: "RecyclerViewAttachDemo")
    }
  }
}
