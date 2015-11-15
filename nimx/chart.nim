import control
import context
import types
import system_logger
import event
import font
import app
import view_event_handling
import composition
import chart_data_item

export control

const selectionColor = newColor(0.40, 0.59, 0.95)

type ChartStyle* = enum
    csLineChart
    csBarChart
    csRadarChart
    csPolarAreaChart
    csPieChart

type Chart* = ref object of Control
    title*: string
    dataItems*: seq[ChartDataItem]
    style*: ChartStyle
    nameX*: string
    nameY*: string

proc newChart*(r: Rect): Chart =
    result.new()
    result.init(r)

proc newBarChart*(r: Rect): Chart =
    result = newChart(r)
    result.style = csBarChart

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

var barChartComposition = newComposition """
uniform vec4 uStrokeColor;
uniform vec4 uFillColorStart;
uniform vec4 uFillColorEnd;
uniform sampler2D tex;
float radius = 0.0;

void compose() {
    vec4 fc = gradient(smoothstep(bounds.y, bounds.y + bounds.w, vPos.y),
        uFillColorStart,
        uFillColorEnd);

    drawShape(sdRoundedRect(bounds, radius), uStrokeColor);
    drawShape(sdRegularPolygon(vec2(55.0, 15.0), 40.0, 20, PI*1.5), vec4(8.0));
}
"""

proc drawBarChartStyle(c: Chart, r: Rect) =
    barChartComposition.draw r:
            setUniform("uStrokeColor", newGrayColor(0.78))
            setUniform("uFillColorStart", c.backgroundColor)
            setUniform("uFillColorEnd", c.backgroundColor)
    c.drawTitle(0)


method draw(c: Chart, r: Rect) =
    if c.style == csBarChart:
      c.drawBarChartStyle(r)
