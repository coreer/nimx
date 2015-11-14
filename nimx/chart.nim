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
    caption*: string
    dataItems*: seq[DataItem]
    style*: ChartStyle


proc newChart*(r: Rect): Chart =
    result.new()
    result.init(r)

proc newPieChart*(r: Rect): Chart =
    result = newChart(r)
    result.style = pieChart

