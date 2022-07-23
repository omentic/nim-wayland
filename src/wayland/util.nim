{.push dynlib: "libwlroots.so" .}

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

proc toDouble*(f: WlFixed): cdouble {.importc: "wl_fixed_to_double".}
proc getWlFixed*(d: cdouble): WlFixed {.importc: "wl_fixed_from_double".}
proc toInt*(f: WlFixed): cint {.importc: "wl_fixed_to_int".}
proc getWlFixed*(i: cint): WlFixed {.importc: "wl_fixed_from_int".}

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
