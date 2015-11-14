# File: main.nim
import nimx.sdl_window
import nimx.text_field

# First create a window. Window is the root of view hierarchy.
# Currently there are two types of windows. SdlWindow should be used
# with native targets, JSCanvasWindow should be used for WebGL target
var wnd : SdlWindow
wnd.new()
wnd.init(newRect(40, 40, 800, 600))

# Create a static text field and add it to view hierarchy
let pieChart = newPieChart(newRect(20, 20, 200, 200))
pieChart.caption = "Market balances"

let googleSegment = newDataItem(name: "Google", partInPercents: 35);
let appleSegment = newDataItem(name: "Apple", partInPercents: 30);
let microsoftSegment = newDataItem(name: "Microsoft", partInPercents: 5);

pieChart.addDataItems(@[googleSegment, appleSegment, microsoftSegment]);

wnd.addSubview(pieChart)

# Run the main loop
runUntilQuit()