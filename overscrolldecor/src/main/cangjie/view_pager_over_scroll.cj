/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2024-2025. All rights reserved.
 */

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

    /*
     * 获取边框高度。
     *
     * 返回值 Length - 边框高度
     */
    public func getHeight(): Length {
        return this.mHeight
    }

    /*
     * 设置边框高度
     *
     * 参数 height - 高度
     * 返回值 ViewPagerOverScrollModel - 滚动容器数据实例
     */
    public func setHeight(height: Length): ViewPagerOverScrollModel {
        this.mHeight = height
        return this
    }

    /*
     * 获取边框宽度。
     *
     * 返回值 Length - 边框宽度
     */
    public func getWidth(): Length {
        return this.mWidth
    }

    /*
     * 设置边框宽度。
     *
     * 参数 width - 宽度大小
     * 返回值 ViewPagerOverScrollModel - 滚动容器数据实例
     */
    public func setWidth(width: Length): ViewPagerOverScrollModel {
        this.mWidth = width
        return this
    }
}
