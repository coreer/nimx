type ChartDataItem* = ref object of RootObj
    name*: string
    value*: seq[array[2, float]]
