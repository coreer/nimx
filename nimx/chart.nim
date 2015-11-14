import control
import context
import types
import system_logger
import event
import font
import app
import view_event_handling
import composition

type ChartStyle* = enum
    lineChart
    barChart
    radarChart
    polarAreaChart
    pieChart


type Chart* = ref object of Control
    title*: string
    dataItems*: seq[DataItem]
    style*: ChartStyle


proc newChart*(r: Rect): Chart =
    result.new()
    result.init(r)

proc newPieChart*(r: Rect): Chart =
    result = newChart(r)
    result.style = pieChart

method init(b: Button, frame: Rect) =
    procCall b.Control.init(frame)
    b.state = bsUp
    b.backgroundColor = whiteColor()

proc drawTitle(b: Button, xOffset: Coord) =
    if b.title != nil:
        let c = currentContext()
        c.fillColor = if b.state == bsDown and b.style == bsRegular:
                whiteColor()
            else:
                blackColor()

        let font = systemFont()
        var titleRect = b.bounds
        var pt = centerInRect(font.sizeOfString(b.title), titleRect)
        if pt.x < xOffset: pt.x = xOffset
        c.drawText(font, pt, b.title)


