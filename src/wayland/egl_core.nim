##  Copyright © 2011 Kristian Høgsberg
##  Copyright © 2011 Benjamin Franzke
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

{.push dynlib: "libwayland-egl.so" .}

const WL_EGL_PLATFORM* = 1

# FIXME: shim
type
  WlEglWindow = object
  WlSurface = object

proc createWlEglWindow*(surface: ptr WlSurface; width: cint; height: cint): ptr WlEglWindow {.importc: "wl_egl_window_create".}
proc destroy*(egl_window: ptr WlEglWindow) {.importc: "wl_egl_window_destroy".}
proc resize*(egl_window: ptr WlEglWindow; width: cint; height: cint; dx: cint; dy: cint) {.importc: "wl_egl_window_resize".}
proc getAttachedSize*(egl_window: ptr WlEglWindow; width: ptr cint; height: ptr cint) {.importc: "wl_egl_window_get_attached_size".}

{.pop.}
