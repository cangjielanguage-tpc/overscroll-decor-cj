package ohos_app_cangjie_entry

internal import ohos.base.LengthProp
internal import ohos.component.Column
internal import ohos.component.Row
internal import ohos.component.Button
internal import ohos.component.Text
internal import ohos.component.CustomView
internal import ohos.component.CJEntry
internal import ohos.component.loadNativeView
internal import ohos.state_manage.SubscriberManager
internal import ohos.state_manage.ObservedProperty
internal import ohos.state_manage.LocalStorage
import ohos.state_macro_manage.Entry
import ohos.state_macro_manage.Component
import ohos.state_macro_manage.State
import ohos.state_macro_manage.r
import overscrolldecor.*
import ohos.base.*
import ohos.component.*
import ohos.component.Visibility

@Entry
@Component
class EntryView {
    private var color: Array<String> = ["#ffaa66cc", "#ff0099cc", "#ff33b5e5", "#00e0e0", "#ff669900", "#ff99cc00",
        "#f0e000", "#ffffbb33", "#ffff8800", "#ffff4444", "#ffcc0000"]
    private var colorName: Array<String> = ["PURPLE", "BLUE", "LIGHT BLUE", "CYAN", "GREEN", "LIGHT GREEN", "YELLOW",
        "LIGHT ORANGE", "ORANGE", "LIGHT RED", "RED"]
    @State
    var model: OverScrollDecorModel = OverScrollDecorModel()
    @State
    var isVisibility: Visibility = Visibility.None
    @State
    var backOffset: Float64 = 0.0
    @State
    var message: String = "Hello Cangjie"

    protected override func aboutToAppear(): Unit {
        this.model.setUpOverScroll(true).setOrientation(ORIENTATION.VERTICAL).setOverScrollBounceEffect(true).
            setScrollBar(true).setWidth(Length(100)) //100%
                .setHeight(Length(85)) //85%
    }

    func verticallyView(leftColorName: String, rightColorName: String, leftColor: String, rightColor: String) {
        Row(Length(10)) {
            Text('' + leftColorName).height("100%").width("50%").fontSize(30).textAlign(TextAlign.Center).
                backgroundColor(Color(0)) //leftColor
                    .onClick {
                evt =>
            }

            Text('' + rightColorName).height("100%").width("50%").fontSize(30).textAlign(TextAlign.Center).
                backgroundColor(Color(0)) //rightColor
                    .onClick {
                event =>
            }
        }.width("100%").height("25%")
    }

    func SpecificChild() {
        Column(
            10.0,
            {
                =>
                this.verticallyView(this.colorName[0], this.colorName[1], this.color[0], this.color[1])
                this.verticallyView(this.colorName[2], this.colorName[3], this.color[2], this.color[3])
                this.verticallyView(this.colorName[4], this.colorName[5], this.color[4], this.color[5])
                this.verticallyView(this.colorName[6], this.colorName[7], this.color[6], this.color[7])
                this.verticallyView(this.colorName[8], this.colorName[9], this.color[8], this.color[9])
                this.verticallyView(this.colorName[10], "", this.color[10], "")
            }
        ).width('100%')
    }

    func build() {}
}
