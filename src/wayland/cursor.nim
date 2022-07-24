##  Copyright © 2012 Intel Corporation
##
##  Permission is hereby granted, free of charge, to any person obtaining
##  a copy of this software and associated documentation files (the
##  "Software"), to deal in the Software without restriction, including
##  without limitation the rights to use, copy, modify, merge, publish,
##  distribute, sublicense, and/or sell copies of the Software, and to
##  permit persons to whom the Software is furnished to do so, subject to
##  the following conditions:
##
##  The above copyright notice and this permission notice (including the
##  next paragraph) shall be included in all copies or substantial
##  portions of the Software.
##
##  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
##  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
##  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
##  NONINFRINGEMENT.  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
##  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
##  ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
##  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
##  SOFTWARE.

{.push dynlib: "libwayland-cursor.so" .}

# FIXME: shim
type
  WlCursorTheme = object
  WlBuffer = object
  WlShm = object

## A still image part of a cursor
##
## Use `get_buffer()` to get the corresponding `struct
## wl_buffer` to attach to your `struct wl_surface`.
type WlCursorImage* {.bycopy.} = object
  width*: uint32      ## * Actual width
  height*: uint32     ## * Actual height
  hotspot_x*: uint32  ## * Hot spot x (must be inside image)
  hotspot_y*: uint32  ## * Hot spot y (must be inside image)
  delay*: uint32      ## * Animation delay to next frame (ms)


## A cursor, as returned by `getCursor()`
type WlCursor* {.bycopy.} = object
  image_count*: cuint             ## How many images there are in this cursor’s animation
  images*: ptr ptr WlCursorImage  ## The array of still images composing this animation
  name*: cstring                  ## The name of this cursor

proc loadWlCursorTheme*(name: cstring; size: cint; shm: ptr WlShm): ptr WlCursorTheme {.importc: "wl_cursor_theme_load".}
proc destroy*(theme: ptr WlCursorTheme) {.importc: "wl_cursor_theme_destroy".}
proc getCursor*(theme: ptr WlCursorTheme; name: cstring): ptr WlCursor {.importc: "wl_cursor_theme_get_cursor".}
proc getBuffer*(image: ptr WlCursorImage): ptr WlBuffer {.importc: "wl_cursor_image_get_buffer".}
proc frame*(cursor: ptr WlCursor; time: uint32): cint {.importc: "wl_cursor_frame".}
proc frameAndDuration*(cursor: ptr WlCursor; time: uint32; duration: ptr uint32): cint {.importc: "wl_cursor_frame_and_duration".}

{.pop.}
