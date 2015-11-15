import types
import unicode
import window

type EventType* = enum
    etUnknown
    etMouse
    etTouch
    etScroll
    etKeyboard
    etWindowResized
    etTextInput
    etTextEditing
    etAppWillEnterBackground
    etAppWillEnterForeground

type ButtonState* = enum
    bsUnknown
    bsUp
    bsDown

type ChartState* = enum
    csUnknown
    csUp
    csDown

type KeyCode* = enum
    kcUnknown
    kcMouseButtonPrimary
    kcMouseButtonSecondary
    kcMouseButtonMiddle

type Touch* = object
    position*: Point
    id*: int

type Event* = object
    kind*: EventType
    position*: Point
    localPosition*: Point
    offset*: Point
    fButton: cint # SDL Keycode for keyboard events and KeyCode for mouse events
    buttonState*: ButtonState
    rune*: Rune
    repeat*: bool
    window*: Window
    text*: string

proc button*(e: Event): KeyCode = cast[KeyCode](e.fButton)
proc `button=`*(e: var Event, b: KeyCode) = e.fButton = cast[cint](b)

proc keyCode*(e: Event): cint = e.fButton
proc `keyCode=`*(e: var Event, c: cint) = e.fButton = c

proc newEvent*(kind: EventType, position: Point = zeroPoint, button: KeyCode = kcUnknown, buttonState: ButtonState = bsUnknown): Event =
    result.kind = kind
    result.position = position
    result.localPosition = position
    result.button = button
    result.buttonState = buttonState

proc newUnknownEvent*(): Event = newEvent(etUnknown)

proc newMouseMoveEvent*(position: Point): Event =
    newEvent(etMouse, position, kcUnknown, bsUnknown)

proc newMouseButtonEvent*(position: Point, button: KeyCode, state: ButtonState): Event =
    newEvent(etMouse, position, button, state)

proc newTouchEvent*(position: Point, state: ButtonState): Event =
    newEvent(etTouch, position, kcUnknown, state)

proc newFingerDownEvent*(position: Point): Event =
    newTouchEvent(position, bsDown)

proc newFingerUpEvent*(position: Point): Event =
    newTouchEvent(position, bsUp)

proc newMouseDownEvent*(position: Point, button: KeyCode): Event =
    newMouseButtonEvent(position, button, bsDown)

proc newMouseUpEvent*(position: Point, button: KeyCode): Event =
    newMouseButtonEvent(position, button, bsUp)

proc newKeyboardEvent*(keyCode: cint, buttonState: ButtonState, repeat: bool = false): Event =
    result = newEvent(etKeyboard, zeroPoint, kcUnknown, buttonState)
    result.keyCode = keyCode
    result.repeat = repeat

proc isButtonDownEvent*(e: Event): bool = e.buttonState == bsDown
proc isButtonUpEvent*(e: Event): bool = e.buttonState == bsUp

proc isMouseMoveEvent*(e: Event): bool = e.buttonState == bsUnknown and e.kind == etMouse
