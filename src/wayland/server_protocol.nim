{.push dynlib: "libwayland-server.so" .}

import server_core, util

# FIXME: shim
type
  WlClient = object
  WlResource = object
  WlBuffer = object
  WlCallback = object
  WlCompositor = object
  WlDataDevice = object
  WlDataDeviceManager = object
  WlDataOffer = object
  WlDataSource = object
  WlDisplay = object
  WlKeyboard = object
  WlOutput = object
  WlPointer = object
  WlRegion = object
  WlRegistry = object
  WlSeat = object
  WlShell = object
  WlShellSurface = object
  WlShm = object
  WlShmPool = object
  WlSubcompositor = object
  WlSubsurface = object
  WlSurface = object
  WlTouch = object
  WlInterface = object

type WlDisplayError* {.pure.} = enum
  INVALID_OBJECT = 0,
  INVALID_METHOD = 1,
  NO_MEMORY = 2,
  IMPLEMENTATION = 3

type WlDisplayInterface* {.bycopy.} = object
  sync*: proc (client: ptr WlClient; resource: ptr WlResource; callback: uint32)
  get_registry*: proc (client: ptr WlClient; resource: ptr WlResource; registry: uint32)

const
  WL_DISPLAY_ERROR_FIXME* = 0
  WL_DISPLAY_DELETE_ID* = 1

const
  WL_DISPLAY_ERROR_SINCE_VERSION* = 1
  WL_DISPLAY_DELETE_ID_SINCE_VERSION* = 1
  WL_DISPLAY_SYNC_SINCE_VERSION* = 1
  WL_DISPLAY_GET_REGISTRY_SINCE_VERSION* = 1

type WlRegistryInterface* {.bycopy.} = object
  `bind`*: proc (client: ptr WlClient; resource: ptr WlResource; name: uint32; `interface`: cstring; version: uint32; id: uint32)

const
  WL_REGISTRY_GLOBAL* = 0
  WL_REGISTRY_GLOBAL_REMOVE* = 1
  WL_REGISTRY_GLOBAL_SINCE_VERSION* = 1
  WL_REGISTRY_GLOBAL_REMOVE_SINCE_VERSION* = 1
  WL_REGISTRY_BIND_SINCE_VERSION* = 1

proc sendGlobal*(resource: ptr WlResource; name: uint32; `interface`: cstring; version: uint32) {.inline.} =
  postEvent(resource, WL_REGISTRY_GLOBAL, name, `interface`, version)

proc sendGlobalRemove*(resource: ptr WlResource; name: uint32) {.inline.} =
  postEvent(resource, WL_REGISTRY_GLOBAL_REMOVE, name)

const
  WL_CALLBACK_DONE* = 0
  WL_CALLBACK_DONE_SINCE_VERSION* = 1

proc sendDone*(resource: ptr WlResource; callback_data: uint32) {.inline.} =
  postEvent(resource, WL_CALLBACK_DONE, callback_data)

type WlCompositorInterface* {.bycopy.} = object
  create_surface*: proc (client: ptr WlClient; resource: ptr WlResource; id: uint32)
  create_region*: proc (client: ptr WlClient; resource: ptr WlResource; id: uint32)

const
  WL_COMPOSITOR_CREATE_SURFACE_SINCE_VERSION* = 1
  WL_COMPOSITOR_CREATE_REGION_SINCE_VERSION* = 1

type WlShmPoolInterface* {.bycopy.} = object
  create_buffer*: proc (client: ptr WlClient; resource: ptr WlResource; id: uint32; offset: int32; width, height: int32; stride: int32; format: uint32)
  destroy*: proc (client: ptr WlClient; resource: ptr WlResource)
  resize*: proc (client: ptr WlClient; resource: ptr WlResource; size: int32)

const
  WL_SHM_POOL_CREATE_BUFFER_SINCE_VERSION* = 1
  WL_SHM_POOL_DESTROY_SINCE_VERSION* = 1
  WL_SHM_POOL_RESIZE_SINCE_VERSION* = 1

type WlShmEerror* {.pure.} = enum
  INVALID_FORMAT = 0,
  INVALID_STRIDE = 1,
  INVALID_FD = 2

type WlShmFormat* {.pure.} = enum
  ARGB8888 = 0,
  XRGB8888 = 1,
  C8 = 0x20203843,
  R8 = 0x20203852,
  R16 = 0x20363152,
  P010 = 0x30313050,
  P210 = 0x30313250,
  Y210 = 0x30313259,
  Q410 = 0x30313451,
  Y410 = 0x30313459,
  AXBXGXRX106106106106 = 0x30314241,
  YUV420_10BIT = 0x30315559,
  BGRA1010102 = 0x30334142,
  RGBA1010102 = 0x30334152,
  ABGR2101010 = 0x30334241,
  XBGR2101010 = 0x30334258,
  ARGB2101010 = 0x30335241,
  XRGB2101010 = 0x30335258,
  VUY101010 = 0x30335556,
  XVYU2101010 = 0x30335658,
  BGRX1010102 = 0x30335842,
  RGBX1010102 = 0x30335852,
  X0L0 = 0x304c3058,
  Y0L0 = 0x304c3059,
  Q401 = 0x31303451,
  YUV411 = 0x31315559,
  YVU411 = 0x31315659,
  NV21 = 0x3132564e,
  NV61 = 0x3136564e,
  P012 = 0x32313050,
  Y212 = 0x32313259,
  Y412 = 0x32313459,
  BGRA4444 = 0x32314142,
  RGBA4444 = 0x32314152,
  ABGR4444 = 0x32314241,
  XBGR4444 = 0x32314258,
  ARGB4444 = 0x32315241,
  XRGB4444 = 0x32315258,
  YUV420 = 0x32315559,
  NV12 = 0x3231564e,
  YVU420 = 0x32315659,
  BGRX4444 = 0x32315842,
  RGBX4444 = 0x32315852,
  RG1616 = 0x32334752,
  GR1616 = 0x32335247,
  NV42 = 0x3234564e,
  X0L2 = 0x324c3058,
  Y0L2 = 0x324c3059,
  BGRA8888 = 0x34324142,
  RGBA8888 = 0x34324152,
  ABGR8888 = 0x34324241,
  XBGR8888 = 0x34324258,
  BGR888 = 0x34324742,
  RGB888 = 0x34324752,
  VUY888 = 0x34325556,
  YUV444 = 0x34325559,
  NV24 = 0x3432564e,
  YVU444 = 0x34325659,
  BGRX8888 = 0x34325842,
  RGBX8888 = 0x34325852,
  BGRA5551 = 0x35314142,
  RGBA5551 = 0x35314152,
  ABGR1555 = 0x35314241,
  XBGR1555 = 0x35314258,
  ARGB1555 = 0x35315241,
  XRGB1555 = 0x35315258,
  NV15 = 0x3531564e,
  BGRX5551 = 0x35315842,
  RGBX5551 = 0x35315852,
  P016 = 0x36313050,
  Y216 = 0x36313259,
  Y416 = 0x36313459,
  BGR565 = 0x36314742,
  RGB565 = 0x36314752,
  YUV422 = 0x36315559,
  NV16 = 0x3631564e,
  YVU422 = 0x36315659,
  XVYU12_16161616 = 0x36335658,
  YUV420_8BIT = 0x38305559,
  ABGR16161616 = 0x38344241,
  XBGR16161616 = 0x38344258,
  ARGB16161616 = 0x38345241,
  XRGB16161616 = 0x38345258,
  XVYU16161616 = 0x38345658,
  RG88 = 0x38384752,
  GR88 = 0x38385247,
  BGR565_A8 = 0x38413542,
  RGB565_A8 = 0x38413552,
  BGR888_A8 = 0x38413842,
  RGB888_A8 = 0x38413852,
  XBGR8888_A8 = 0x38414258,
  XRGB8888_A8 = 0x38415258,
  BGRX8888_A8 = 0x38415842,
  RGBX8888_A8 = 0x38415852,
  RGB332 = 0x38424752,
  BGR233 = 0x38524742,
  YVU410 = 0x39555659,
  YUV410 = 0x39565559,
  ABGR16161616F = 0x48344241,
  XBGR16161616F = 0x48344258,
  ARGB16161616F = 0x48345241,
  XRGB16161616F = 0x48345258,
  YVYU = 0x55595659,
  AYUV = 0x56555941,
  XYUV8888 = 0x56555958,
  YUYV = 0x56595559,
  VYUY = 0x59555956,
  UYVY = 0x59565955

type WlShmInterface* {.bycopy.} = object
  create_pool*: proc (client: ptr WlClient; resource: ptr WlResource; id: uint32; fd: int32; size: int32)

const WL_SHM_FORMAT_FIXME* = 0

const
  WL_SHM_FORMAT_SINCE_VERSION* = 1
  WL_SHM_CREATE_POOL_SINCE_VERSION* = 1

# fixme
#[proc sendFormat*(resource: ptr WlResource; format: uint32) {.inline.} =
  postEvent(resource, WL_SHM_FORMAT, format)]#

type WlBufferInterface* {.bycopy.} = object
  destroy*: proc (client: ptr WlClient; resource: ptr WlResource)

const
  WL_BUFFER_RELEASE* = 0
  WL_BUFFER_RELEASE_SINCE_VERSION* = 1
  WL_BUFFER_DESTROY_SINCE_VERSION* = 1

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

const
  WL_DATA_OFFER_OFFER* = 0
  WL_DATA_OFFER_SOURCE_ACTIONS* = 1
  WL_DATA_OFFER_ACTION* = 2

const
  WL_DATA_OFFER_OFFER_SINCE_VERSION* = 1
  WL_DATA_OFFER_SOURCE_ACTIONS_SINCE_VERSION* = 3
  WL_DATA_OFFER_ACTION_SINCE_VERSION* = 3
  WL_DATA_OFFER_ACCEPT_SINCE_VERSION* = 1
  WL_DATA_OFFER_RECEIVE_SINCE_VERSION* = 1
  WL_DATA_OFFER_DESTROY_SINCE_VERSION* = 1
  WL_DATA_OFFER_FINISH_SINCE_VERSION* = 3
  WL_DATA_OFFER_SET_ACTIONS_SINCE_VERSION* = 3

proc sendOffer*(resource: ptr WlResource; mime_type: cstring) {.inline.} =
  postEvent(resource, WL_DATA_OFFER_OFFER, mime_type)

proc sendSourceActions*(resource: ptr WlResource; source_actions: uint32) {.inline.} =
  postEvent(resource, WL_DATA_OFFER_SOURCE_ACTIONS, source_actions)

proc sendActionOffer*(resource: ptr WlResource; dnd_action: uint32) {.inline.} =
  postEvent(resource, WL_DATA_OFFER_ACTION, dnd_action)

type WlDataSourceError* {.pure.} = enum
  INVALID_ACTION_MASK = 0,
  INVALID_SOURCE = 1

type WlDataSourceInterface* {.bycopy.} = object
  offer*: proc (client: ptr WlClient; resource: ptr WlResource; mime_type: cstring)
  destroy*: proc (client: ptr WlClient; resource: ptr WlResource)
  set_actions*: proc (client: ptr WlClient; resource: ptr WlResource; dnd_actions: uint32)

const
  WL_DATA_SOURCE_TARGET* = 0
  WL_DATA_SOURCE_SEND* = 1
  WL_DATA_SOURCE_CANCELLED* = 2
  WL_DATA_SOURCE_DND_DROP_PERFORMED* = 3
  WL_DATA_SOURCE_DND_FINISHED* = 4
  WL_DATA_SOURCE_ACTION* = 5

const
  WL_DATA_SOURCE_TARGET_SINCE_VERSION* = 1
  WL_DATA_SOURCE_SEND_SINCE_VERSION* = 1
  WL_DATA_SOURCE_CANCELLED_SINCE_VERSION* = 1
  WL_DATA_SOURCE_DND_DROP_PERFORMED_SINCE_VERSION* = 3
  WL_DATA_SOURCE_DND_FINISHED_SINCE_VERSION* = 3
  WL_DATA_SOURCE_ACTION_SINCE_VERSION* = 3
  WL_DATA_SOURCE_OFFER_SINCE_VERSION* = 1
  WL_DATA_SOURCE_DESTROY_SINCE_VERSION* = 1
  WL_DATA_SOURCE_SET_ACTIONS_SINCE_VERSION* = 3

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

type WlDataDeviceError* {.pure.} = enum
  ROLE = 0

type WlDataDeviceInterface* {.bycopy.} = object
  start_drag*: proc (client: ptr WlClient; resource: ptr WlResource; source: ptr WlResource; origin: ptr WlResource; icon: ptr WlResource; serial: uint32)
  set_selection*: proc (client: ptr WlClient; resource: ptr WlResource; source: ptr WlResource; serial: uint32)
  release*: proc (client: ptr WlClient; resource: ptr WlResource)

const
  WL_DATA_DEVICE_DATA_OFFER* = 0
  WL_DATA_DEVICE_ENTER* = 1
  WL_DATA_DEVICE_LEAVE* = 2
  WL_DATA_DEVICE_MOTION* = 3
  WL_DATA_DEVICE_DROP* = 4
  WL_DATA_DEVICE_SELECTION* = 5

const
  WL_DATA_DEVICE_DATA_OFFER_SINCE_VERSION* = 1
  WL_DATA_DEVICE_ENTER_SINCE_VERSION* = 1
  WL_DATA_DEVICE_LEAVE_SINCE_VERSION* = 1
  WL_DATA_DEVICE_MOTION_SINCE_VERSION* = 1
  WL_DATA_DEVICE_DROP_SINCE_VERSION* = 1
  WL_DATA_DEVICE_SELECTION_SINCE_VERSION* = 1
  WL_DATA_DEVICE_START_DRAG_SINCE_VERSION* = 1
  WL_DATA_DEVICE_SET_SELECTION_SINCE_VERSION* = 1
  WL_DATA_DEVICE_RELEASE_SINCE_VERSION* = 2

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

type WlDataDeviceManagerDndAction* {.pure.} = enum
  NONE = 0,
  COPY = 1,
  MOVE = 2,
  ASK = 4

type WlDataDeviceManagerInterface* {.bycopy.} = object
  create_data_source*: proc (client: ptr WlClient; resource: ptr WlResource; id: uint32)
  get_data_device*: proc (client: ptr WlClient; resource: ptr WlResource; id: uint32; seat: ptr WlResource)

const
  WL_DATA_DEVICE_MANAGER_CREATE_DATA_SOURCE_SINCE_VERSION* = 1

const
  WL_DATA_DEVICE_MANAGER_GET_DATA_DEVICE_SINCE_VERSION* = 1

type WlShellError* {.pure.} = enum
  ROLE = 0

type WlShellInterface* {.bycopy.} = object
  get_shell_surface*: proc (client: ptr WlClient; resource: ptr WlResource; id: uint32; surface: ptr WlResource)

const WL_SHELL_GET_SHELL_SURFACE_SINCE_VERSION* = 1

type WlShellSurfaceResize* {.pure.} = enum
  NONE = 0,
  TOP = 1,
  BOTTOM = 2,
  LEFT = 4,
  TOP_LEFT = 5,
  BOTTOM_LEFT = 6,
  RIGHT = 8,
  TOP_RIGHT = 9,
  BOTTOM_RIGHT = 10

type WlShellSurfaceTransient* {.pure.} = enum
  INACTIVE = 0x1

type WlShellSurfaceFullscreenMethod* {.pure.} = enum
  DEFAULT = 0,
  SCALE = 1,
  DRIVER = 2,
  FILL = 3

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

const
  WL_SHELL_SURFACE_PING* = 0
  WL_SHELL_SURFACE_CONFIGURE* = 1
  WL_SHELL_SURFACE_POPUP_DONE* = 2

const
  WL_SHELL_SURFACE_PING_SINCE_VERSION* = 1
  WL_SHELL_SURFACE_CONFIGURE_SINCE_VERSION* = 1
  WL_SHELL_SURFACE_POPUP_DONE_SINCE_VERSION* = 1
  WL_SHELL_SURFACE_PONG_SINCE_VERSION* = 1
  WL_SHELL_SURFACE_MOVE_SINCE_VERSION* = 1
  WL_SHELL_SURFACE_RESIZE_SINCE_VERSION* = 1
  WL_SHELL_SURFACE_SET_TOPLEVEL_SINCE_VERSION* = 1
  WL_SHELL_SURFACE_SET_TRANSIENT_SINCE_VERSION* = 1
  WL_SHELL_SURFACE_SET_FULLSCREEN_SINCE_VERSION* = 1
  WL_SHELL_SURFACE_SET_POPUP_SINCE_VERSION* = 1
  WL_SHELL_SURFACE_SET_MAXIMIZED_SINCE_VERSION* = 1
  WL_SHELL_SURFACE_SET_TITLE_SINCE_VERSION* = 1
  WL_SHELL_SURFACE_SET_CLASS_SINCE_VERSION* = 1

proc sendPing*(resource: ptr WlResource; serial: uint32) {.inline.} =
  postEvent(resource, WL_SHELL_SURFACE_PING, serial)

proc sendConfigure*(resource: ptr WlResource; edges: uint32; width, height: int32) {.inline.} =
  postEvent(resource, WL_SHELL_SURFACE_CONFIGURE, edges, width, height)

proc sendPopupDone*(resource: ptr WlResource) {.inline.} =
  postEvent(resource, WL_SHELL_SURFACE_POPUP_DONE)

type WlSurfaceError* {.pure.} = enum
  INVALID_SCALE = 0,
  INVALID_TRANSFORM = 1,
  INVALID_SIZE = 2,
  INVALID_OFFSET = 3

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

const
  WL_SURFACE_ENTER* = 0
  WL_SURFACE_LEAVE* = 1

const
  WL_SURFACE_ENTER_SINCE_VERSION* = 1
  WL_SURFACE_LEAVE_SINCE_VERSION* = 1
  WL_SURFACE_DESTROY_SINCE_VERSION* = 1
  WL_SURFACE_ATTACH_SINCE_VERSION* = 1
  WL_SURFACE_DAMAGE_SINCE_VERSION* = 1
  WL_SURFACE_FRAME_SINCE_VERSION* = 1
  WL_SURFACE_SET_OPAQUE_REGION_SINCE_VERSION* = 1
  WL_SURFACE_SET_INPUT_REGION_SINCE_VERSION* = 1
  WL_SURFACE_COMMIT_SINCE_VERSION* = 1
  WL_SURFACE_SET_BUFFER_TRANSFORM_SINCE_VERSION* = 2
  WL_SURFACE_SET_BUFFER_SCALE_SINCE_VERSION* = 3
  WL_SURFACE_DAMAGE_BUFFER_SINCE_VERSION* = 4
  WL_SURFACE_OFFSET_SINCE_VERSION* = 5

proc sendEnter*(resource: ptr WlResource; output: ptr WlResource) {.inline.} =
  postEvent(resource, WL_SURFACE_ENTER, output)

proc sendLeave*(resource: ptr WlResource; output: ptr WlResource) {.inline.} =
  postEvent(resource, WL_SURFACE_LEAVE, output)

type WlSeatCapability* {.pure.} = enum
  POINTER = 1,
  KEYBOARD = 2,
  TOUCH = 4

type WlSeatError* {.pure.} = enum
  MISSING_CAPABILITY = 0

type WlSeatInterface* {.bycopy.} = object
  get_pointer*: proc (client: ptr WlClient; resource: ptr WlResource; id: uint32)
  get_keyboard*: proc (client: ptr WlClient; resource: ptr WlResource; id: uint32)
  get_touch*: proc (client: ptr WlClient; resource: ptr WlResource; id: uint32)
  release*: proc (client: ptr WlClient; resource: ptr WlResource)

const
  WL_SEAT_CAPABILITIES* = 0
  WL_SEAT_NAME* = 1

const
  WL_SEAT_CAPABILITIES_SINCE_VERSION* = 1
  WL_SEAT_NAME_SINCE_VERSION* = 2
  WL_SEAT_GET_POINTER_SINCE_VERSION* = 1
  WL_SEAT_GET_KEYBOARD_SINCE_VERSION* = 1
  WL_SEAT_GET_TOUCH_SINCE_VERSION* = 1
  WL_SEAT_RELEASE_SINCE_VERSION* = 5

# fixme
#[proc sendCapabilities*(resource: ptr WlSeat; capabilities: uint32) {.inline.} =
  postEvent(resource, WL_SEAT_CAPABILITIES, capabilities)]#

#[proc sendName*(resource: ptr WlSeat; name: cstring) {.inline.} =
  postEvent(resource, WL_SEAT_NAME, name)]#

type WlPointerError* {.pure.} = enum
  ROLE = 0

type WlPointerButtonState* {.pure.} = enum
  RELEASED = 0,
  PRESSED = 1

type WlPointerAxis* {.pure.} = enum
  VERTICAL_SCROLL = 0,
  HORIZONTAL_SCROLL = 1

type WlPointerAxisSource* {.pure.} = enum
  WHEEL = 0,
  FINGER = 1,
  CONTINUOUS = 2,
  WHEEL_TILT = 3

const WL_POINTER_AXIS_SOURCE_WHEEL_TILT_SINCE_VERSION* = 6

type WlPointerInterface* {.bycopy.} = object
  set_cursor*: proc (client: ptr WlClient; resource: ptr WlResource; serial: uint32; surface: ptr WlResource; hotspot_x, hotspot_y: int32)
  release*: proc (client: ptr WlClient; resource: ptr WlResource)

const
  WL_POINTER_ENTER* = 0
  WL_POINTER_LEAVE* = 1
  WL_POINTER_MOTION* = 2
  WL_POINTER_BUTTON* = 3
  WL_POINTER_AXIS_FIXME* = 4
  WL_POINTER_FRAME* = 5
  WL_POINTER_AXIS_SOURCE_FIXME* = 6
  WL_POINTER_AXIS_STOP* = 7
  WL_POINTER_AXIS_DISCRETE* = 8

const
  WL_POINTER_ENTER_SINCE_VERSION* = 1
  WL_POINTER_LEAVE_SINCE_VERSION* = 1
  WL_POINTER_MOTION_SINCE_VERSION* = 1
  WL_POINTER_BUTTON_SINCE_VERSION* = 1
  WL_POINTER_AXIS_SINCE_VERSION* = 1
  WL_POINTER_FRAME_SINCE_VERSION* = 5
  WL_POINTER_AXIS_SOURCE_SINCE_VERSION* = 5
  WL_POINTER_AXIS_STOP_SINCE_VERSION* = 5
  WL_POINTER_AXIS_DISCRETE_SINCE_VERSION* = 5
  WL_POINTER_SET_CURSOR_SINCE_VERSION* = 1
  WL_POINTER_RELEASE_SINCE_VERSION* = 3

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

type WlKeyboardKeymapFormat* {.pure.} = enum
  NO_KEYMAP = 0,
  XKB_V1 = 1

type WlKeyboardKeyState* {.pure.} = enum
  RELEASED = 0,
  PRESSED = 1

type WlKeyboardInterface* {.bycopy.} = object
  release*: proc (client: ptr WlClient; resource: ptr WlResource)

const
  WL_KEYBOARD_KEYMAP* = 0
  WL_KEYBOARD_ENTER* = 1
  WL_KEYBOARD_LEAVE* = 2
  WL_KEYBOARD_KEY* = 3
  WL_KEYBOARD_MODIFIERS* = 4
  WL_KEYBOARD_REPEAT_INFO* = 5

const
  WL_KEYBOARD_KEYMAP_SINCE_VERSION* = 1
  WL_KEYBOARD_ENTER_SINCE_VERSION* = 1
  WL_KEYBOARD_LEAVE_SINCE_VERSION* = 1
  WL_KEYBOARD_KEY_SINCE_VERSION* = 1
  WL_KEYBOARD_MODIFIERS_SINCE_VERSION* = 1
  WL_KEYBOARD_REPEAT_INFO_SINCE_VERSION* = 4
  WL_KEYBOARD_RELEASE_SINCE_VERSION* = 3

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

const
  WL_TOUCH_DOWN* = 0
  WL_TOUCH_UP* = 1
  WL_TOUCH_MOTION* = 2
  WL_TOUCH_FRAME* = 3
  WL_TOUCH_CANCEL* = 4
  WL_TOUCH_SHAPE* = 5
  WL_TOUCH_ORIENTATION* = 6

const
  WL_TOUCH_DOWN_SINCE_VERSION* = 1
  WL_TOUCH_UP_SINCE_VERSION* = 1
  WL_TOUCH_MOTION_SINCE_VERSION* = 1
  WL_TOUCH_FRAME_SINCE_VERSION* = 1
  WL_TOUCH_CANCEL_SINCE_VERSION* = 1
  WL_TOUCH_SHAPE_SINCE_VERSION* = 6
  WL_TOUCH_ORIENTATION_SINCE_VERSION* = 6
  WL_TOUCH_RELEASE_SINCE_VERSION* = 3

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

type WlOutputSubpixel {.pure.} = enum
  UNKNOWN = 0,
  NONE = 1,
  HORIZONTAL_RGB = 2,
  HORIZONTAL_BGR = 3,
  VERTICAL_RGB = 4,
  VERTICAL_BGR = 5

type WlOutputTransform {.pure.} = enum
  TRANSFORM_NORMAL = 0,
  TRANSFORM_90 = 1,
  TRANSFORM_180 = 2,
  TRANSFORM_270 = 3,
  TRANSFORM_FLIPPED = 4,
  TRANSFORM_FLIPPED_90 = 5,
  TRANSFORM_FLIPPED_180 = 6,
  TRANSFORM_FLIPPED_270 = 7

type WlOutputMode* {.pure.} = enum
  CURRENT = 0x1,
  PREFERRED = 0x2

type WlOutputInterface* {.bycopy.} = object
  release*: proc (client: ptr WlClient; resource: ptr WlResource)

const
  WL_OUTPUT_GEOMETRY* = 0
  WL_OUTPUT_MODE_FIXME* = 1
  WL_OUTPUT_DONE* = 2
  WL_OUTPUT_SCALE* = 3
  WL_OUTPUT_NAME* = 4
  WL_OUTPUT_DESCRIPTION* = 5

const
  WL_OUTPUT_GEOMETRY_SINCE_VERSION* = 1
  WL_OUTPUT_MODE_SINCE_VERSION* = 1
  WL_OUTPUT_DONE_SINCE_VERSION* = 2
  WL_OUTPUT_SCALE_SINCE_VERSION* = 2
  WL_OUTPUT_NAME_SINCE_VERSION* = 4
  WL_OUTPUT_DESCRIPTION_SINCE_VERSION* = 4
  WL_OUTPUT_RELEASE_SINCE_VERSION* = 3

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

const
  WL_REGION_DESTROY_SINCE_VERSION* = 1
  WL_REGION_ADD_SINCE_VERSION* = 1
  WL_REGION_SUBTRACT_SINCE_VERSION* = 1

type WlSubcompositorError* {.pure.} = enum
  BAD_SURFACE = 0

type WlSubcompositorInterface* {.bycopy.} = object
  destroy*: proc (client: ptr WlClient; resource: ptr WlResource)
  get_subsurface*: proc (client: ptr WlClient; resource: ptr WlResource; id: uint32; surface: ptr WlResource; parent: ptr WlResource)

const
  WL_SUBCOMPOSITOR_DESTROY_SINCE_VERSION* = 1
  WL_SUBCOMPOSITOR_GET_SUBSURFACE_SINCE_VERSION* = 1

type WlSubsurfaceError* {.pure.} = enum
  BAD_SURFACE = 0

type WlSubsurfaceInterface* {.bycopy.} = object
  destroy*: proc (client: ptr WlClient; resource: ptr WlResource)
  set_position*: proc (client: ptr WlClient; resource: ptr WlResource; x, y: int32)
  place_above*: proc (client: ptr WlClient; resource: ptr WlResource; sibling: ptr WlResource)
  place_below*: proc (client: ptr WlClient; resource: ptr WlResource; sibling: ptr WlResource)
  set_sync*: proc (client: ptr WlClient; resource: ptr WlResource)
  set_desync*: proc (client: ptr WlClient; resource: ptr WlResource)

const
  WL_SUBSURFACE_DESTROY_SINCE_VERSION* = 1
  WL_SUBSURFACE_SET_POSITION_SINCE_VERSION* = 1
  WL_SUBSURFACE_PLACE_ABOVE_SINCE_VERSION* = 1
  WL_SUBSURFACE_PLACE_BELOW_SINCE_VERSION* = 1
  WL_SUBSURFACE_SET_SYNC_SINCE_VERSION* = 1
  WL_SUBSURFACE_SET_DESYNC_SINCE_VERSION* = 1

{.pop.}
