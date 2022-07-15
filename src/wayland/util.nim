{.push dynlib: "libwlroots.so" .}

type WlMessage* {.bycopy.} = object
  name*: cstring
  signature*: cstring
  types*: ptr ptr WlInterface

type WlInterface* {.bycopy.} = object
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

template wl_container_of*(`ptr`, sample, member: untyped): untyped =
  (__typeof__(sample))(cast[cstring]((`ptr`)) -
      offsetof(__typeof__(sample[]), member))

type WlArray* {.bycopy.} = object
  size*: csize
  alloc*: csize
  data*: pointer

proc init*(array: ptr WlArray) {.importc: "wl_array_init".}
proc release*(array: ptr WlArray) {.importc: "wl_array_release".}
proc add*(array: ptr WlArray; size: csize): pointer {.importc: "wl_array_add".}
proc copy*(array: ptr WlArray; source: ptr WlArray): cint {.importc: "wl_array_copy".}

type WlFixed* = int32

proc toDouble*(f: WlFixed): cdouble {.inline.} = {.importc: "wl_fixed_to_double".}
  type
    INNER_C_UNION_wayland-util_608 {.bycopy, union.} = object
      d: cdouble
      i: int64_t

  var u: INNER_C_UNION_wayland-util_608
  u.i = ((1023LLi64 + 44LLi64) shl 52) + (1LLi64 shl 51) + f
  return u.d - (3LLi64 shl 43)

proc wl_fixed_from_double*(d: cdouble): WlFixed {.inline.} {.importc: "wl_fixed_from_double".} =
  type
    INNER_C_UNION_wayland-util_628 {.bycopy, union.} = object
      d: cdouble
      i: int64

  var u: INNER_C_UNION_wayland-util_628
  u.d = d + (3LLi64 shl (51 - 8))
  return cast[WlFixed](u.i)

proc toInt*(f: WlFixed): cint {.inline.} = {.importc: "wl_fixed_to_int".}
  return f div 256

proc getWlFixed*(i: cint): WlFixed {.inline.} = {.importc: "wl_fixed_from_int".}
  return i * 256

type
  wl_argument* {.bycopy, union.} = object
    i*: int32
    u*: uint32
    f*: WlFixed
    s*: cstring
    o*: ptr WlObject
    n*: uint32
    a*: ptr WlArray
    h*: int32

type WlDispatcherFunc* = proc (a1: pointer; a2: pointer; a3: uint32; a4: ptr WlMessage; a5: ptr WlArgument): cint

type WlIteratorResult* {.pure.} = enum
  STOP,
  CONTINUE

{.pop.}
