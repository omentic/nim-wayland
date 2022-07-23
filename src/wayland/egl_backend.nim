##  Copyright © 2011 Benjamin Franzke
##
##  Permission is hereby granted, free of charge, to any person obtaining a
##  copy of this software and associated documentation files (the "Software"),
##  to deal in the Software without restriction, including without limitation
##  the rights to use, copy, modify, merge, publish, distribute, sublicense,
##  and/or sell copies of the Software, and to permit persons to whom the
##  Software is furnished to do so, subject to the following conditions:
##
##  The above copyright notice and this permission notice (including the next
##  paragraph) shall be included in all copies or substantial portions of the
##  Software.
##
##  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
##  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
##  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
##  NONINFRINGEMENT.  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
##  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
##  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
##  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
##  DEALINGS IN THE SOFTWARE.
##
##  Authors:
##     Benjamin Franzke <benjaminfranzke@googlemail.com>

##  NOTE: This version must be kept in sync with the version field in the
##  wayland-egl-backend pkgconfig file generated in meson.build.
const WL_EGL_WINDOW_VERSION* = 3

# FIXME: shim
type WlSurface = object

type WlEglWindow* {.bycopy.} = object
  version*: int64
  width*: cint
  height*: cint
  dx*: cint
  dy*: cint
  attached_width*: cint
  attached_height*: cint
  driver_private*: pointer
  resize_callback*: proc (a1: ptr WlEglWindow; a2: pointer)
  destroy_window_callback*: proc (a1: pointer)
  surface*: ptr WlSurface
