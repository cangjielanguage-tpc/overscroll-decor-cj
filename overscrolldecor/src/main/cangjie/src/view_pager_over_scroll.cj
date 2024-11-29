/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package overscrolldecor

internal import ohos.base.nativeLog
internal import cj_res_overscrolldecor.app
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

@Observed
public class ViewPagerOverScrollModel {
    var mHeight: Option<Length> = px2vp(Length(2340))
    var mWidth: Option<Length> = px2vp(lpx2px(Length(720)).getOrThrow())

    public func getHeight(): Option<Length> {
        return this.mHeight
    }

    public func setHeight(height: Option<Length>): ViewPagerOverScrollModel {
        this.mHeight = height
        return this
    }

    public func getWidth(): Option<Length> {
        return this.mWidth
    }

    public func setWidth(width: Option<Length>): ViewPagerOverScrollModel {
        this.mWidth = width
        return this
    }
}
