{.push dynlib: "libwayland-client.so" .}

type WlObject = object

type
  WlMessage* {.bycopy.} = object
    name*: cstring
    signature*: cstring
    types*: ptr ptr WlInterface

  WlInterface* {.bycopy.} = object
    name*: cstring
    version*: cint
    method_count*: cint
    methods*: ptr WlMessage
    event_count*: cint
    events*: ptr WlMessage

type WlList* {.bycopy.} = object
  prev*: ptr WlList
  next*: ptr WlList

proc init*(list: ptr WlList) {.importc: "wl_list_init".}
proc insert*(list: ptr WlList; elm: ptr WlList) {.importc: "wl_list_insert".}
proc remove*(elm: ptr WlList) {.importc: "wl_list_remove".}
proc length*(list: ptr WlList): cint {.importc: "wl_list_length".}
proc empty*(list: ptr WlList): cint {.importc: "wl_list_empty".}
proc insertList*(list: ptr WlList; other: ptr WlList) {.importc: "wl_list_insert_list".}

type WlArray* {.bycopy.} = object
  size*: csize_t
  alloc*: csize_t
  data*: pointer

proc init*(array: ptr WlArray) {.importc: "wl_array_init".}
proc release*(array: ptr WlArray) {.importc: "wl_array_release".}
proc add*(array: ptr WlArray; size: csize_t): pointer {.importc: "wl_array_add".}
proc copy*(array: ptr WlArray; source: ptr WlArray): cint {.importc: "wl_array_copy".}

type WlFixed* = int32

proc toDouble*(f: WlFixed): cdouble {.inline.} =
  type
    INNER_C_UNION_wayland {.bycopy, union.} = object
      d: cdouble
      i: int64

  var u: INNER_C_UNION_wayland
  u.i = ((1023'i64 + 44'i64) shl 52) + (1'i64 shl 51) + f
  return u.d - (3'i64 shl 43)

proc getWlFixed*(d: cdouble): WlFixed {.inline.} =
  type
    INNER_C_UNION_wayland {.bycopy, union.} = object
      d: cdouble
      i: int64

  var u: INNER_C_UNION_wayland
  u.d = d + (3'i64 shl (51 - 8))
  return cast[WlFixed](u.i)

proc toInt*(f: WlFixed): cint {.inline.} =
  return f div 256

proc getWlFixed*(i: cint): WlFixed {.inline.} =
  return i * 256

type
  WlArgument* {.bycopy, union.} = object
    i*: int32
    u*: uint32
    f*: WlFixed
    s*: cstring
    o*: ptr WlObject
    n*: uint32
    a*: ptr WlArray
    h*: int32

type WlDispatcherFunc* = proc (a1: pointer; a2: pointer; a3: uint32; a4: ptr WlMessage; a5: ptr WlArgument): cint

type va_list* {.importc: "va_list", header: "<stdarg.h>".} = object

type WlLogFunc* = proc (a1: cstring; a2: va_list)

type WlIteratorResult* {.pure.} = enum
  STOP,
  CONTINUE

{.pop.}
