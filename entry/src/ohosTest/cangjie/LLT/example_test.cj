package ohos_app_cangjie_entry_test.LLT

import std.unittest.*
import std.unittest.common.*
import std.unittest.testmacro.*
import ohos.ui_test.*
import overscrolldecor.*

@Test
class TestExample {
    @TestCase
    func testLevel0(): Unit {
        let driver = Driver.create()

        driver.findComponent(On().id("ViewPagerDemo")).click()
        driver.delayMs(800)

        driver.findComponent(On().id("test")).click()
        driver.delayMs(800)

        driver.drag(200, 600, 1000, 600, speed: 1000)
        driver.delayMs(800)

        driver.click(600, 600)
        driver.delayMs(800)

        driver.pressBack()
        driver.delayMs(1000)


        driver.findComponent(On().id("GridViewDemo")).click()
        driver.delayMs(800)

        driver.click(600, 600)
        driver.delayMs(800)

        driver.pressBack()
        driver.delayMs(1000)


        driver.findComponent(On().id("ListViewDemo")).click()
        driver.delayMs(800)

        driver.findComponent(On().id("test")).click()
        driver.delayMs(800)

        driver.drag(500, 1000, 500, 1600, speed: 1000)
        driver.delayMs(800)

        driver.drag(500, 1500, 500, 500, speed: 1000)
        driver.delayMs(800)

        driver.drag(500, 1500, 500, 500, speed: 1000)
        driver.delayMs(800)

        driver.drag(500, 1500, 500, 500, speed: 1000)
        driver.delayMs(800)

        driver.pressBack()
        driver.delayMs(1000)


        driver.findComponent(On().id("MiscViewsDemo")).click()
        driver.delayMs(800)
        driver.pressBack()
        driver.delayMs(1000)


        driver.findComponent(On().id("NestedScrollViewDemo")).click()
        driver.delayMs(800)
        driver.pressBack()
        driver.delayMs(1000)


        driver.findComponent(On().id("RecyclerViewAttachDemo")).click()
        driver.delayMs(800)
        driver.pressBack()
        driver.delayMs(1000)


        driver.findComponent(On().id("RecyclerViewDetachDemo")).click()
        driver.delayMs(800)
        driver.pressBack()
        driver.delayMs(1000)


        driver.findComponent(On().id("RecyclerViewStaggeredGridDemo")).click()
        driver.delayMs(800)
        driver.pressBack()
        driver.delayMs(1000)


        driver.findComponent(On().id("ScrollViewDemo")).click()
        driver.delayMs(800)
        driver.pressBack()
        driver.delayMs(1000)


        driver.findComponent(On().id("Case19")).click()
        driver.delayMs(800)

        driver.click(200, 1500)
        driver.delayMs(800)

        driver.drag(200, 1500, 1000, 1500, speed: 1000)
        driver.delayMs(800)

        driver.drag(200, 1500, 1000, 1500, speed: 1000)
        driver.delayMs(800)

        driver.drag(200, 1500, 1000, 1500, speed: 1000)
        driver.delayMs(800)

        driver.pressBack()
        driver.delayMs(1000)

        driver.findComponent(On().id("Case21")).click()
        driver.delayMs(800)
        driver.pressBack()
        driver.delayMs(1000)
    }
}
