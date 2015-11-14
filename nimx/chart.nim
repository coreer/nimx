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

method init(c: Chart, frame: Rect) =
    procCall c.Control.init(frame)
    c.backgroundColor = whiteColor()

proc drawTitle(c: Chart, xOffset: Coord) =
    if c.title != nil:
        let cxt = currentContext()
        cxt.fillColor = whiteColor()

        let font = systemFont()
        var titleRect = c.bounds
        var pt = centerInRect(font.sizeOfString(c.title), titleRect)
        if pt.x < xOffset: pt.x = xOffset
        cxt.drawText(font, pt, c.title)


