package overscrolldecor

internal import ohos.base.*
internal import ohos.component.*
internal import ohos.state_manage.*
import ohos.state_macro_manage.*

@Component
public class ViewPagerOverScroll {
    @Link
    var model: ViewPagerOverScrollModel
    @BuilderParam
    let child: () -> Unit

    func build() {
        Flex(FlexParams(alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center)) {
            this.child()
        }.height(this.model.mHeight).width(this.model.mWidth)
    }
}

public class ViewPagerOverScrollModel {
    var mHeight: Length = 2340.vp
    var mWidth: Length = 720.vp

    public func getHeight(): Length {
        return this.mHeight
    }

    public func setHeight(height: Length): ViewPagerOverScrollModel {
        this.mHeight = height
        return this
    }

    public func getWidth(): Length {
        return this.mWidth
    }

    public func setWidth(width: Length): ViewPagerOverScrollModel {
        this.mWidth = width
        return this
    }
}
