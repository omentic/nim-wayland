{.push dynlib: "libwayland-server.so" .}

import server_core, util, constants

type WlDisplayInterface* {.bycopy.} = object
  sync*: proc (client: ptr WlClient; resource: ptr WlResource; callback: uint32)
  get_registry*: proc (client: ptr WlClient; resource: ptr WlResource; registry: uint32)

const
  WL_DISPLAY_ERROR_FIXME* = 0
  WL_DISPLAY_DELETE_ID* = 1

type WlRegistryInterface* {.bycopy.} = object
  `bind`*: proc (client: ptr WlClient; resource: ptr WlResource; name: uint32; `interface`: cstring; version: uint32; id: uint32)

proc sendGlobal*(resource: ptr WlResource; name: uint32; `interface`: cstring; version: uint32) {.inline.} =
  postEvent(resource, WL_REGISTRY_GLOBAL, name, `interface`, version)

proc sendGlobalRemove*(resource: ptr WlResource; name: uint32) {.inline.} =
  postEvent(resource, WL_REGISTRY_GLOBAL_REMOVE, name)

proc sendDone*(resource: ptr WlResource; callback_data: uint32) {.inline.} =
  postEvent(resource, WL_CALLBACK_DONE, callback_data)

type WlCompositorInterface* {.bycopy.} = object
  create_surface*: proc (client: ptr WlClient; resource: ptr WlResource; id: uint32)
  create_region*: proc (client: ptr WlClient; resource: ptr WlResource; id: uint32)

type WlShmPoolInterface* {.bycopy.} = object
  create_buffer*: proc (client: ptr WlClient; resource: ptr WlResource; id: uint32; offset: int32; width, height: int32; stride: int32; format: uint32)
  destroy*: proc (client: ptr WlClient; resource: ptr WlResource)
  resize*: proc (client: ptr WlClient; resource: ptr WlResource; size: int32)

type WlShmInterface* {.bycopy.} = object
  create_pool*: proc (client: ptr WlClient; resource: ptr WlResource; id: uint32; fd: int32; size: int32)

const WL_SHM_FORMAT_FIXME* = 0

# fixme
#[proc sendFormat*(resource: ptr WlResource; format: uint32) {.inline.} =
  postEvent(resource, WL_SHM_FORMAT, format)]#

type WlBufferInterface* {.bycopy.} = object
  destroy*: proc (client: ptr WlClient; resource: ptr WlResource)

proc sendRelease*(resource: ptr WlResource) {.inline.} =
  postEvent(resource, WL_BUFFER_RELEASE)

type WlDatatOfferError* {.pure.} = enum
  INVALID_FINISH = 0,
  INVALID_ACTION_MASK = 1,
  INVALID_ACTION = 2,
  INVALID_OFFER = 3

type WlDataOfferInterface* {.bycopy.} = object
  accept*: proc (client: ptr WlClient; resource: ptr WlResource; serial: uint32; mime_type: cstring)
  receive*: proc (client: ptr WlClient; resource: ptr WlResource; mime_type: cstring; fd: int32)
  destroy*: proc (client: ptr WlClient; resource: ptr WlResource)
  finish*: proc (client: ptr WlClient; resource: ptr WlResource)
  set_actions*: proc (client: ptr WlClient; resource: ptr WlResource; dnd_actions: uint32; preferred_action: uint32)

proc sendOffer*(resource: ptr WlResource; mime_type: cstring) {.inline.} =
  postEvent(resource, WL_DATA_OFFER_OFFER, mime_type)

proc sendSourceActions*(resource: ptr WlResource; source_actions: uint32) {.inline.} =
  postEvent(resource, WL_DATA_OFFER_SOURCE_ACTIONS, source_actions)

proc sendActionOffer*(resource: ptr WlResource; dnd_action: uint32) {.inline.} =
  postEvent(resource, WL_DATA_OFFER_ACTION, dnd_action)

type WlDataSourceInterface* {.bycopy.} = object
  offer*: proc (client: ptr WlClient; resource: ptr WlResource; mime_type: cstring)
  destroy*: proc (client: ptr WlClient; resource: ptr WlResource)
  set_actions*: proc (client: ptr WlClient; resource: ptr WlResource; dnd_actions: uint32)

proc sendTarget*(resource: ptr WlResource; mime_type: cstring) {.inline.} =
  postEvent(resource, WL_DATA_SOURCE_TARGET, mime_type)

proc sendSend*(resource: ptr WlResource; mime_type: cstring; fd: int32) {.inline.} =
  postEvent(resource, WL_DATA_SOURCE_SEND, mime_type, fd)

proc sendCancelled*(resource: ptr WlResource) {.inline.} =
  postEvent(resource, WL_DATA_SOURCE_CANCELLED)

proc sendDndDropPerformed*(resource: ptr WlResource) {.inline.} =
  postEvent(resource, WL_DATA_SOURCE_DND_DROP_PERFORMED)

proc sendDndFinished*(resource: ptr WlResource) {.inline.} =
  postEvent(resource, WL_DATA_SOURCE_DND_FINISHED)

proc sendActionSource*(resource: ptr WlResource; dnd_action: uint32) {.inline.} =
  postEvent(resource, WL_DATA_SOURCE_ACTION, dnd_action)

type WlDataDeviceInterface* {.bycopy.} = object
  start_drag*: proc (client: ptr WlClient; resource: ptr WlResource; source: ptr WlResource; origin: ptr WlResource; icon: ptr WlResource; serial: uint32)
  set_selection*: proc (client: ptr WlClient; resource: ptr WlResource; source: ptr WlResource; serial: uint32)
  release*: proc (client: ptr WlClient; resource: ptr WlResource)

proc sendDataOffer*(resource: ptr WlResource; id: ptr WlResource) {.inline.} =
  postEvent(resource, WL_DATA_DEVICE_DATA_OFFER, id)

proc sendEnter*(resource: ptr WlResource; serial: uint32; surface: ptr WlResource; x, y: WlFixed; id: ptr WlResource) {.inline.} =
  postEvent(resource, WL_DATA_DEVICE_ENTER, serial, surface, x, y, id)

proc sendLeave*(resource: ptr WlResource) {.inline.} =
  postEvent(resource, WL_DATA_DEVICE_LEAVE)

proc sendMotion*(resource: ptr WlResource; time: uint32; x, y: WlFixed) {.inline.} =
  postEvent(resource, WL_DATA_DEVICE_MOTION, time, x, y)

proc sendDrop*(resource: ptr WlResource) {.inline.} =
  postEvent(resource, WL_DATA_DEVICE_DROP)

proc sendSelection*(resource: ptr WlResource; id: ptr WlResource) {.inline.} =
  postEvent(resource, WL_DATA_DEVICE_SELECTION, id)

type WlDataDeviceManagerInterface* {.bycopy.} = object
  create_data_source*: proc (client: ptr WlClient; resource: ptr WlResource; id: uint32)
  get_data_device*: proc (client: ptr WlClient; resource: ptr WlResource; id: uint32; seat: ptr WlResource)

type WlShellInterface* {.bycopy.} = object
  get_shell_surface*: proc (client: ptr WlClient; resource: ptr WlResource; id: uint32; surface: ptr WlResource)

type WlShellSurfaceInterface* {.bycopy.} = object
  pong*: proc (client: ptr WlClient; resource: ptr WlResource; serial: uint32)
  move*: proc (client: ptr WlClient; resource: ptr WlResource; seat: ptr WlResource; serial: uint32)
  resize*: proc (client: ptr WlClient; resource: ptr WlResource; seat: ptr WlResource; serial: uint32; edges: uint32)
  set_toplevel*: proc (client: ptr WlClient; resource: ptr WlResource)
  set_transient*: proc (client: ptr WlClient; resource: ptr WlResource; parent: ptr WlResource; x, y: int32; flags: uint32)
  set_fullscreen*: proc (client: ptr WlClient; resource: ptr WlResource; `method`: uint32; framerate: uint32; output: ptr WlResource)
  set_popup*: proc (client: ptr WlClient; resource: ptr WlResource; seat: ptr WlResource; serial: uint32; parent: ptr WlResource; x, y: int32; flags: uint32)
  set_maximized*: proc (client: ptr WlClient; resource: ptr WlResource; output: ptr WlResource)
  set_title*: proc (client: ptr WlClient; resource: ptr WlResource; title: cstring)
  set_class*: proc (client: ptr WlClient; resource: ptr WlResource; class: cstring)

proc sendPing*(resource: ptr WlResource; serial: uint32) {.inline.} =
  postEvent(resource, WL_SHELL_SURFACE_PING, serial)

proc sendConfigure*(resource: ptr WlResource; edges: uint32; width, height: int32) {.inline.} =
  postEvent(resource, WL_SHELL_SURFACE_CONFIGURE, edges, width, height)

proc sendPopupDone*(resource: ptr WlResource) {.inline.} =
  postEvent(resource, WL_SHELL_SURFACE_POPUP_DONE)

type WlSurfaceInterface* {.bycopy.} = object
  destroy*: proc (client: ptr WlClient; resource: ptr WlResource)
  attach*: proc (client: ptr WlClient; resource: ptr WlResource; buffer: ptr WlResource; x, y: int32)
  damage*: proc (client: ptr WlClient; resource: ptr WlResource; x, y: int32; width, height: int32)
  frame*: proc (client: ptr WlClient; resource: ptr WlResource; callback: uint32)
  set_opaque_region*: proc (client: ptr WlClient; resource: ptr WlResource; region: ptr WlResource)
  set_input_region*: proc (client: ptr WlClient; resource: ptr WlResource;region: ptr WlResource)
  commit*: proc (client: ptr WlClient; resource: ptr WlResource)
  set_buffer_transform*: proc (client: ptr WlClient; resource: ptr WlResource; transform: int32)
  set_buffer_scale*: proc (client: ptr WlClient; resource: ptr WlResource; scale: int32)
  damage_buffer*: proc (client: ptr WlClient; resource: ptr WlResource; x, y: int32; width, height: int32)
  offset*: proc (client: ptr WlClient; resource: ptr WlResource; x, y: int32)

proc sendEnter*(resource: ptr WlResource; output: ptr WlResource) {.inline.} =
  postEvent(resource, WL_SURFACE_ENTER, output)

proc sendLeave*(resource: ptr WlResource; output: ptr WlResource) {.inline.} =
  postEvent(resource, WL_SURFACE_LEAVE, output)

type WlSeatInterface* {.bycopy.} = object
  get_pointer*: proc (client: ptr WlClient; resource: ptr WlResource; id: uint32)
  get_keyboard*: proc (client: ptr WlClient; resource: ptr WlResource; id: uint32)
  get_touch*: proc (client: ptr WlClient; resource: ptr WlResource; id: uint32)
  release*: proc (client: ptr WlClient; resource: ptr WlResource)

# fixme
#[proc sendCapabilities*(resource: ptr WlSeat; capabilities: uint32) {.inline.} =
  postEvent(resource, WL_SEAT_CAPABILITIES, capabilities)]#

#[proc sendName*(resource: ptr WlSeat; name: cstring) {.inline.} =
  postEvent(resource, WL_SEAT_NAME, name)]#

type WlPointerInterface* {.bycopy.} = object
  set_cursor*: proc (client: ptr WlClient; resource: ptr WlResource; serial: uint32; surface: ptr WlResource; hotspot_x, hotspot_y: int32)
  release*: proc (client: ptr WlClient; resource: ptr WlResource)

proc sendEnter*(resource: ptr WlResource; serial: uint32; surface: ptr WlResource; surface_x, surface_y: WlFixed) {.inline.} =
  postEvent(resource, WL_POINTER_ENTER, serial, surface, surface_x, surface_y)

proc sendLeaveWlPointer*(resource: ptr WlResource; serial: uint32; surface: ptr WlResource) {.inline.} =
  postEvent(resource, WL_POINTER_LEAVE, serial, surface)

proc sendMotion*(resource: ptr WlResource; time: uint32; surface_x, surface_y: WlFixed) {.inline.} =
  postEvent(resource, WL_POINTER_MOTION, time, surface_x, surface_y)

proc sendButton*(resource: ptr WlResource; serial: uint32; time: uint32; button: uint32; state: uint32) {.inline.} =
  postEvent(resource, WL_POINTER_BUTTON, serial, time, button, state)

# fixme
#[proc sendAxis*(resource: ptr WlResource; time: uint32; axis: uint32; value: WlFixed) {.inline.} =
  postEvent(resource, WL_POINTER_AXIS, time, axis, value)]#

proc sendFrameWlPointer*(resource: ptr WlResource) {.inline.} =
  postEvent(resource, WL_POINTER_FRAME)

# fixme
#[proc sendAxisSource*(resource: ptr WlResource; axis_source: uint32) {.inline.} =
  postEvent(resource, WL_POINTER_AXIS_SOURCE, axis_source)]#

proc sendAxisStop*(resource: ptr WlResource; time: uint32; axis: uint32) {.inline.} =
  postEvent(resource, WL_POINTER_AXIS_STOP, time, axis)

proc sendAxisDiscrete*(resource: ptr WlResource; axis: uint32; discrete: int32) {.inline.} =
  postEvent(resource, WL_POINTER_AXIS_DISCRETE, axis, discrete)

type WlKeyboardInterface* {.bycopy.} = object
  release*: proc (client: ptr WlClient; resource: ptr WlResource)

proc sendKeymap*(resource: ptr WlResource; format: uint32; fd: int32; size: uint32) {.inline.} =
  postEvent(resource, WL_KEYBOARD_KEYMAP, format, fd, size)

proc sendEnter*(resource: ptr WlResource; serial: uint32; surface: ptr WlResource; keys: ptr WlArray) {.inline.} =
  postEvent(resource, WL_KEYBOARD_ENTER, serial, surface, keys)

proc sendLeaveWlKeyboard*(resource: ptr WlResource; serial: uint32; surface: ptr WlResource) {.inline.} =
  postEvent(resource, WL_KEYBOARD_LEAVE, serial, surface)

proc sendKey*(resource: ptr WlResource; serial: uint32; time: uint32; key: uint32; state: uint32) {.inline.} =
  postEvent(resource, WL_KEYBOARD_KEY, serial, time, key, state)

proc sendModifiers*(resource: ptr WlResource; serial: uint32; mods_depressed: uint32; mods_latched: uint32; mods_locked: uint32; group: uint32) {.inline.} =
  postEvent(resource, WL_KEYBOARD_MODIFIERS, serial, mods_depressed, mods_latched, mods_locked, group)

proc sendRepeatInfo*(resource: ptr WlResource; rate: int32; delay: int32) {.inline.} =
  postEvent(resource, WL_KEYBOARD_REPEAT_INFO, rate, delay)
type WlTouchInterface* {.bycopy.} = object
  release*: proc (client: ptr WlClient; resource: ptr WlResource)

proc sendDown*(resource: ptr WlResource; serial: uint32; time: uint32; surface: ptr WlResource; id: int32; x, y: WlFixed) {.inline.} =
  postEvent(resource, WL_TOUCH_DOWN, serial, time, surface, id, x, y)

proc sendUp*(resource: ptr WlResource; serial: uint32; time: uint32; id: int32) {.inline.} =
  postEvent(resource, WL_TOUCH_UP, serial, time, id)

proc sendMotion*(resource: ptr WlResource; time: uint32; id: int32; x, y: WlFixed) {.inline.} =
  postEvent(resource, WL_TOUCH_MOTION, time, id, x, y)

proc sendFrameWlTouch*(resource: ptr WlResource) {.inline.} =
  postEvent(resource, WL_TOUCH_FRAME)

proc sendCancel*(resource: ptr WlResource) {.inline.} =
  postEvent(resource, WL_TOUCH_CANCEL)

proc sendShape*(resource: ptr WlResource; id: int32; major: WlFixed; minor: WlFixed) {.inline.} =
  postEvent(resource, WL_TOUCH_SHAPE, id, major, minor)

proc sendOrientation*(resource: ptr WlResource; id: int32; orientation: WlFixed) {.inline.} =
  postEvent(resource, WL_TOUCH_ORIENTATION, id, orientation)

type WlOutputInterface* {.bycopy.} = object
  release*: proc (client: ptr WlClient; resource: ptr WlResource)

proc sendGeometry*(resource: ptr WlResource; x, y: int32; physical_width, physical_height: int32; subpixel: int32; make: cstring; model: cstring; transform: int32) {.inline.} =
  postEvent(resource, WL_OUTPUT_GEOMETRY, x, y, physical_width, physical_height, subpixel, make, model, transform)

# fixme
#[proc sendMode*(resource: ptr WlResource; flags: uint32; width, height: int32; refresh: int32) {.inline.} =
  postEvent(resource, WL_OUTPUT_MODE, flags, width, height, refresh)]#

proc sendDone*(resource: ptr WlResource) {.inline.} =
  postEvent(resource, WL_OUTPUT_DONE)

proc sendScale*(resource: ptr WlResource; factor: int32) {.inline.} =
  postEvent(resource, WL_OUTPUT_SCALE, factor)

proc sendName*(resource: ptr WlResource; name: cstring) {.inline.} =
  postEvent(resource, WL_OUTPUT_NAME, name)

proc sendDescription*(resource: ptr WlResource; description: cstring) {.inline.} =
  postEvent(resource, WL_OUTPUT_DESCRIPTION, description)

type WlRegionInterface* {.bycopy.} = object
  destroy*: proc (client: ptr WlClient; resource: ptr WlResource)
  add*: proc (client: ptr WlClient; resource: ptr WlResource; x, y: int32; width, height: int32)
  subtract*: proc (client: ptr WlClient; resource: ptr WlResource; x, y: int32; width, height: int32)

type WlSubcompositorInterface* {.bycopy.} = object
  destroy*: proc (client: ptr WlClient; resource: ptr WlResource)
  get_subsurface*: proc (client: ptr WlClient; resource: ptr WlResource; id: uint32; surface: ptr WlResource; parent: ptr WlResource)

type WlSubsurfaceInterface* {.bycopy.} = object
  destroy*: proc (client: ptr WlClient; resource: ptr WlResource)
  set_position*: proc (client: ptr WlClient; resource: ptr WlResource; x, y: int32)
  place_above*: proc (client: ptr WlClient; resource: ptr WlResource; sibling: ptr WlResource)
  place_below*: proc (client: ptr WlClient; resource: ptr WlResource; sibling: ptr WlResource)
  set_sync*: proc (client: ptr WlClient; resource: ptr WlResource)
  set_desync*: proc (client: ptr WlClient; resource: ptr WlResource)

{.pop.}
