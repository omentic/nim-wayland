# import server

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

var
  WlDisplayInterface*: WlInterface
  WlRegistryInterface*: WlInterface
  WlCallbackInterface*: WlInterface
  WlCompositorInterface*: WlInterface
  WlShm_poolInterface*: WlInterface
  WlShmInterface*: WlInterface
  WlBufferInterface*: WlInterface
  WlDataOfferInterface*: WlInterface
  WlDataSourceInterface*: WlInterface
  WlDataDeviceInterface*: WlInterface
  WlDataDeviceManagerInterface*: WlInterface
  WlShellInterface*: WlInterface
  WlShell_surfaceInterface*: WlInterface
  WlSurfaceInterface*: WlInterface
  WlSeatInterface*: WlInterface
  WlPointerInterface*: WlInterface
  WlKeyboardInterface*: WlInterface
  WlTouchInterface*: WlInterface
  WlOutputInterface*: WlInterface
  WlRegionInterface*: WlInterface
  WlSubcompositorInterface*: WlInterface
  WlSubsurfaceInterface*: WlInterface

type WlDisplayError* = enum
  WL_DISPLAY_ERROR_INVALID_OBJECT = 0,
  WL_DISPLAY_ERROR_INVALID_METHOD = 1,
  WL_DISPLAY_ERROR_NO_MEMORY = 2,
  WL_DISPLAY_ERROR_IMPLEMENTATION = 3

type WlDisplayInterface* {.bycopy.} = object
  sync*: proc (client: ptr WlClient; resource: ptr WlResource; callback: uint32)
  get_registry*: proc (client: ptr WlClient; resource: ptr WlResource; registry: uint32)

const
  WL_DISPLAY_ERROR* = 0
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

proc wl_registry_send_global*(resource: ptr WlResource; name: uint32; `interface`: cstring; version: uint32) {.inline, importc: "wl_registry_send_global".} =
  postEvent(resource, WL_REGISTRY_GLOBAL, name, `interface`, version)

proc wl_registry_send_global_remove*(resource_: ptr WlResource; name: uint32) {.inline, importc: "wl_registry_send_global_remove".} =
  postEvent(resource_, WL_REGISTRY_GLOBAL_REMOVE, name)

const
  WL_CALLBACK_DONE* = 0
  WL_CALLBACK_DONE_SINCE_VERSION* = 1

proc wl_callback_send_done*(resource_: ptr WlResource; callback_data: uint32) {.inline, importc: "wl_callback_send_done".} =
  postEvent(resource_, WL_CALLBACK_DONE, callback_data)

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

type WlShmEerror* = enum
  WL_SHM_ERROR_INVALID_FORMAT = 0,
  WL_SHM_ERROR_INVALID_STRIDE = 1,
  WL_SHM_ERROR_INVALID_FD = 2

type WlShmFormat* = enum
  WL_SHM_FORMAT_ARGB8888 = 0,
  WL_SHM_FORMAT_XRGB8888 = 1,
  WL_SHM_FORMAT_C8 = 0x20203843,
  WL_SHM_FORMAT_R8 = 0x20203852,
  WL_SHM_FORMAT_R16 = 0x20363152,
  WL_SHM_FORMAT_P010 = 0x30313050,
  WL_SHM_FORMAT_P210 = 0x30313250,
  WL_SHM_FORMAT_Y210 = 0x30313259,
  WL_SHM_FORMAT_Q410 = 0x30313451,
  WL_SHM_FORMAT_Y410 = 0x30313459,
  WL_SHM_FORMAT_AXBXGXRX106106106106 = 0x30314241,
  WL_SHM_FORMAT_YUV420_10BIT = 0x30315559,
  WL_SHM_FORMAT_BGRA1010102 = 0x30334142,
  WL_SHM_FORMAT_RGBA1010102 = 0x30334152,
  WL_SHM_FORMAT_ABGR2101010 = 0x30334241,
  WL_SHM_FORMAT_XBGR2101010 = 0x30334258,
  WL_SHM_FORMAT_ARGB2101010 = 0x30335241,
  WL_SHM_FORMAT_XRGB2101010 = 0x30335258,
  WL_SHM_FORMAT_VUY101010 = 0x30335556,
  WL_SHM_FORMAT_XVYU2101010 = 0x30335658,
  WL_SHM_FORMAT_BGRX1010102 = 0x30335842,
  WL_SHM_FORMAT_RGBX1010102 = 0x30335852,
  WL_SHM_FORMAT_X0L0 = 0x304c3058,
  WL_SHM_FORMAT_Y0L0 = 0x304c3059,
  WL_SHM_FORMAT_Q401 = 0x31303451,
  WL_SHM_FORMAT_YUV411 = 0x31315559,
  WL_SHM_FORMAT_YVU411 = 0x31315659,
  WL_SHM_FORMAT_NV21 = 0x3132564e,
  WL_SHM_FORMAT_NV61 = 0x3136564e,
  WL_SHM_FORMAT_P012 = 0x32313050,
  WL_SHM_FORMAT_Y212 = 0x32313259,
  WL_SHM_FORMAT_Y412 = 0x32313459,
  WL_SHM_FORMAT_BGRA4444 = 0x32314142,
  WL_SHM_FORMAT_RGBA4444 = 0x32314152,
  WL_SHM_FORMAT_ABGR4444 = 0x32314241,
  WL_SHM_FORMAT_XBGR4444 = 0x32314258,
  WL_SHM_FORMAT_ARGB4444 = 0x32315241,
  WL_SHM_FORMAT_XRGB4444 = 0x32315258,
  WL_SHM_FORMAT_YUV420 = 0x32315559,
  WL_SHM_FORMAT_NV12 = 0x3231564e,
  WL_SHM_FORMAT_YVU420 = 0x32315659,
  WL_SHM_FORMAT_BGRX4444 = 0x32315842,
  WL_SHM_FORMAT_RGBX4444 = 0x32315852,
  WL_SHM_FORMAT_RG1616 = 0x32334752,
  WL_SHM_FORMAT_GR1616 = 0x32335247,
  WL_SHM_FORMAT_NV42 = 0x3234564e,
  WL_SHM_FORMAT_X0L2 = 0x324c3058,
  WL_SHM_FORMAT_Y0L2 = 0x324c3059,
  WL_SHM_FORMAT_BGRA8888 = 0x34324142,
  WL_SHM_FORMAT_RGBA8888 = 0x34324152,
  WL_SHM_FORMAT_ABGR8888 = 0x34324241,
  WL_SHM_FORMAT_XBGR8888 = 0x34324258,
  WL_SHM_FORMAT_BGR888 = 0x34324742,
  WL_SHM_FORMAT_RGB888 = 0x34324752,
  WL_SHM_FORMAT_VUY888 = 0x34325556,
  WL_SHM_FORMAT_YUV444 = 0x34325559,
  WL_SHM_FORMAT_NV24 = 0x3432564e,
  WL_SHM_FORMAT_YVU444 = 0x34325659,
  WL_SHM_FORMAT_BGRX8888 = 0x34325842,
  WL_SHM_FORMAT_RGBX8888 = 0x34325852,
  WL_SHM_FORMAT_BGRA5551 = 0x35314142,
  WL_SHM_FORMAT_RGBA5551 = 0x35314152,
  WL_SHM_FORMAT_ABGR1555 = 0x35314241,
  WL_SHM_FORMAT_XBGR1555 = 0x35314258,
  WL_SHM_FORMAT_ARGB1555 = 0x35315241,
  WL_SHM_FORMAT_XRGB1555 = 0x35315258,
  WL_SHM_FORMAT_NV15 = 0x3531564e,
  WL_SHM_FORMAT_BGRX5551 = 0x35315842,
  WL_SHM_FORMAT_RGBX5551 = 0x35315852,
  WL_SHM_FORMAT_P016 = 0x36313050,
  WL_SHM_FORMAT_Y216 = 0x36313259,
  WL_SHM_FORMAT_Y416 = 0x36313459,
  WL_SHM_FORMAT_BGR565 = 0x36314742,
  WL_SHM_FORMAT_RGB565 = 0x36314752,
  WL_SHM_FORMAT_YUV422 = 0x36315559,
  WL_SHM_FORMAT_NV16 = 0x3631564e,
  WL_SHM_FORMAT_YVU422 = 0x36315659,
  WL_SHM_FORMAT_XVYU12_16161616 = 0x36335658,
  WL_SHM_FORMAT_YUV420_8BIT = 0x38305559,
  WL_SHM_FORMAT_ABGR16161616 = 0x38344241,
  WL_SHM_FORMAT_XBGR16161616 = 0x38344258,
  WL_SHM_FORMAT_ARGB16161616 = 0x38345241,
  WL_SHM_FORMAT_XRGB16161616 = 0x38345258,
  WL_SHM_FORMAT_XVYU16161616 = 0x38345658,
  WL_SHM_FORMAT_RG88 = 0x38384752,
  WL_SHM_FORMAT_GR88 = 0x38385247,
  WL_SHM_FORMAT_BGR565_A8 = 0x38413542,
  WL_SHM_FORMAT_RGB565_A8 = 0x38413552,
  WL_SHM_FORMAT_BGR888_A8 = 0x38413842,
  WL_SHM_FORMAT_RGB888_A8 = 0x38413852,
  WL_SHM_FORMAT_XBGR8888_A8 = 0x38414258,
  WL_SHM_FORMAT_XRGB8888_A8 = 0x38415258,
  WL_SHM_FORMAT_BGRX8888_A8 = 0x38415842,
  WL_SHM_FORMAT_RGBX8888_A8 = 0x38415852,
  WL_SHM_FORMAT_RGB332 = 0x38424752,
  WL_SHM_FORMAT_BGR233 = 0x38524742,
  WL_SHM_FORMAT_YVU410 = 0x39555659,
  WL_SHM_FORMAT_YUV410 = 0x39565559,
  WL_SHM_FORMAT_ABGR16161616F = 0x48344241,
  WL_SHM_FORMAT_XBGR16161616F = 0x48344258,
  WL_SHM_FORMAT_ARGB16161616F = 0x48345241,
  WL_SHM_FORMAT_XRGB16161616F = 0x48345258,
  WL_SHM_FORMAT_YVYU = 0x55595659,
  WL_SHM_FORMAT_AYUV = 0x56555941,
  WL_SHM_FORMAT_XYUV8888 = 0x56555958,
  WL_SHM_FORMAT_YUYV = 0x56595559,
  WL_SHM_FORMAT_VYUY = 0x59555956,
  WL_SHM_FORMAT_UYVY = 0x59565955

type WlShmInterface* {.bycopy.} = object
  create_pool*: proc (client: ptr WlClient; resource: ptr WlResource; id: uint32; fd: int32; size: int32)

const
  WL_SHM_FORMAT* = 0

const
  WL_SHM_FORMAT_SINCE_VERSION* = 1
  WL_SHM_CREATE_POOL_SINCE_VERSION* = 1

proc wl_shm_send_format*(resource_: ptr WlResource; format: uint32) {.inline, importc: "wl_shm_send_format".} =
  postEvent(resource_, WL_SHM_FORMAT, format)

type WlBufferInterface* {.bycopy.} = object
  destroy*: proc (client: ptr WlClient; resource: ptr WlResource)

const
  WL_BUFFER_RELEASE* = 0
  WL_BUFFER_RELEASE_SINCE_VERSION* = 1
  WL_BUFFER_DESTROY_SINCE_VERSION* = 1

proc wl_buffer_send_release*(resource_: ptr WlResource) {.inline, importc: "wl_buffer_send_release".} =
  postEvent(resource_, WL_BUFFER_RELEASE)

type WlDatatOfferError* = enum
  WL_DATA_OFFER_ERROR_INVALID_FINISH = 0,
  WL_DATA_OFFER_ERROR_INVALID_ACTION_MASK = 1,
  WL_DATA_OFFER_ERROR_INVALID_ACTION = 2,
  WL_DATA_OFFER_ERROR_INVALID_OFFER = 3

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

proc wl_data_offer_send_offer*(resource_: ptr WlResource; mime_type: cstring) {.inline, importc: "wl_data_offer_send_offer".} =
  postEvent(resource_, WL_DATA_OFFER_OFFER, mime_type)

proc wl_data_offer_send_source_actions*(resource_: ptr WlResource; source_actions: uint32) {.inline, importc: "wl_data_offer_send_source_actions".} =
  postEvent(resource_, WL_DATA_OFFER_SOURCE_ACTIONS, source_actions)

proc wl_data_offer_send_action*(resource_: ptr WlResource; dnd_action: uint32) {.inline, importc: "wl_data_offer_send_action".} =
  postEvent(resource_, WL_DATA_OFFER_ACTION, dnd_action)

type WlDataSourceError* = enum
  WL_DATA_SOURCE_ERROR_INVALID_ACTION_MASK = 0,
  WL_DATA_SOURCE_ERROR_INVALID_SOURCE = 1

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

proc wl_data_source_send_target*(resource_: ptr WlResource; mime_type: cstring) {.inline, importc: "wl_data_source_send_target".} =
  postEvent(resource_, WL_DATA_SOURCE_TARGET, mime_type)

proc wl_data_source_send_send*(resource_: ptr WlResource; mime_type: cstring; fd: int32) {.inline, importc: "wl_data_source_send_send".} =
  postEvent(resource_, WL_DATA_SOURCE_SEND, mime_type, fd)

proc wl_data_source_send_cancelled*(resource_: ptr WlResource) {.inline, importc: "wl_data_source_send_cancelled".} =
  postEvent(resource_, WL_DATA_SOURCE_CANCELLED)

proc wl_data_source_send_dnd_drop_performed*(resource_: ptr WlResource) {.inline, importc: "wl_data_source_send_dnd_drop_performed".} =
  postEvent(resource_, WL_DATA_SOURCE_DND_DROP_PERFORMED)

proc wl_data_source_send_dnd_finished*(resource_: ptr WlResource) {.inline, importc: "wl_data_source_send_dnd_finished".} =
  postEvent(resource_, WL_DATA_SOURCE_DND_FINISHED)

proc wl_data_source_send_action*(resource_: ptr WlResource; dnd_action: uint32) {.inline, importc: "wl_data_source_send_action".} =
  postEvent(resource_, WL_DATA_SOURCE_ACTION, dnd_action)

type WlDataDeviceError* = enum
  WL_DATA_DEVICE_ERROR_ROLE = 0

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

proc wl_data_device_send_data_offer*(resource_: ptr WlResource; id: ptr WlResource) {.inline, importc: "wl_data_device_send_data_offer".} =
  postEvent(resource_, WL_DATA_DEVICE_DATA_OFFER, id)

proc wl_data_device_send_enter*(resource_: ptr WlResource; serial: uint32; surface: ptr WlResource; x, y: WlFixed; id: ptr WlResource) {.inline, importc: "wl_data_device_send_enter".} =
  postEvent(resource_, WL_DATA_DEVICE_ENTER, serial, surface, x, y, id)

proc wl_data_device_send_leave*(resource_: ptr WlResource) {.inline, importc: "wl_data_device_send_leave".} =
  postEvent(resource_, WL_DATA_DEVICE_LEAVE)

proc wl_data_device_send_motion*(resource_: ptr WlResource; time: uint32; x, y: WlFixed) {.inline, importc: "wl_data_device_send_motion".} =
  postEvent(resource_, WL_DATA_DEVICE_MOTION, time, x, y)

proc wl_data_device_send_drop*(resource_: ptr WlResource) {.inline, importc: "wl_data_device_send_drop".} =
  postEvent(resource_, WL_DATA_DEVICE_DROP)

proc wl_data_device_send_selection*(resource_: ptr WlResource; id: ptr WlResource) {.inline, importc: "wl_data_device_send_selection".} =
  postEvent(resource_, WL_DATA_DEVICE_SELECTION, id)

type WlDataDeviceManagerDndAction* = enum
  WL_DATA_DEVICE_MANAGER_DND_ACTION_NONE = 0,
  WL_DATA_DEVICE_MANAGER_DND_ACTION_COPY = 1,
  WL_DATA_DEVICE_MANAGER_DND_ACTION_MOVE = 2,
  WL_DATA_DEVICE_MANAGER_DND_ACTION_ASK = 4

type WlDataDeviceManagerInterface* {.bycopy.} = object
  create_data_source*: proc (client: ptr WlClient; resource: ptr WlResource; id: uint32)
  get_data_device*: proc (client: ptr WlClient; resource: ptr WlResource; id: uint32; seat: ptr WlResource)

const
  WL_DATA_DEVICE_MANAGER_CREATE_DATA_SOURCE_SINCE_VERSION* = 1

const
  WL_DATA_DEVICE_MANAGER_GET_DATA_DEVICE_SINCE_VERSION* = 1

type WlShellError* = enum
  WL_SHELL_ERROR_ROLE = 0

type WlShellInterface* {.bycopy.} = object
  get_shell_surface*: proc (client: ptr WlClient; resource: ptr WlResource; id: uint32; surface: ptr WlResource)

const WL_SHELL_GET_SHELL_SURFACE_SINCE_VERSION* = 1

type WlShellSurfaceResize* = enum
  WL_SHELL_SURFACE_RESIZE_NONE = 0,
  WL_SHELL_SURFACE_RESIZE_TOP = 1,
  WL_SHELL_SURFACE_RESIZE_BOTTOM = 2,
  WL_SHELL_SURFACE_RESIZE_LEFT = 4,
  WL_SHELL_SURFACE_RESIZE_TOP_LEFT = 5,
  WL_SHELL_SURFACE_RESIZE_BOTTOM_LEFT = 6,
  WL_SHELL_SURFACE_RESIZE_RIGHT = 8,
  WL_SHELL_SURFACE_RESIZE_TOP_RIGHT = 9,
  WL_SHELL_SURFACE_RESIZE_BOTTOM_RIGHT = 10

type WlShellSurfaceTransient* = enum
  WL_SHELL_SURFACE_TRANSIENT_INACTIVE = 0x1

type WlShellSurfaceFullscreenMethod* = enum
  WL_SHELL_SURFACE_FULLSCREEN_METHOD_DEFAULT = 0,
  WL_SHELL_SURFACE_FULLSCREEN_METHOD_SCALE = 1,
  WL_SHELL_SURFACE_FULLSCREEN_METHOD_DRIVER = 2,
  WL_SHELL_SURFACE_FULLSCREEN_METHOD_FILL = 3

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
  set_class*: proc (client: ptr WlClient; resource: ptr WlResource; class_: cstring)

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

proc wl_shell_surface_send_ping*(resource_: ptr WlResource; serial: uint32) {.inline, importc: "wl_shell_surface_send_ping".} =
  postEvent(resource_, WL_SHELL_SURFACE_PING, serial)

proc wl_shell_surface_send_configure*(resource_: ptr WlResource; edges: uint32; width, height: int32) {.inline, importc: "wl_shell_surface_send_configure".} =
  postEvent(resource_, WL_SHELL_SURFACE_CONFIGURE, edges, width, height)

proc wl_shell_surface_send_popup_done*(resource_: ptr WlResource) {.inline, importc: "wl_shell_surface_send_popup_done".} =
  postEvent(resource_, WL_SHELL_SURFACE_POPUP_DONE)

type WlSurfaceError* = enum
  WL_SURFACE_ERROR_INVALID_SCALE = 0,
  WL_SURFACE_ERROR_INVALID_TRANSFORM = 1,
  WL_SURFACE_ERROR_INVALID_SIZE = 2,
  WL_SURFACE_ERROR_INVALID_OFFSET = 3

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

proc wl_surface_send_enter*(resource_: ptr WlResource; output: ptr WlResource) {.inline, importc: "wl_surface_send_enter".} =
  postEvent(resource_, WL_SURFACE_ENTER, output)

proc wl_surface_send_leave*(resource_: ptr WlResource; output: ptr WlResource) {.inline, importc: "wl_surface_send_leave".} =
  postEvent(resource_, WL_SURFACE_LEAVE, output)

type WlSeatCapability* = enum
  WL_SEAT_CAPABILITY_POINTER = 1,
  WL_SEAT_CAPABILITY_KEYBOARD = 2,
  WL_SEAT_CAPABILITY_TOUCH = 4

type WlSeatError* = enum
  WL_SEAT_ERROR_MISSING_CAPABILITY = 0

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

proc wl_seat_send_capabilities*(resource_: ptr WlResource; capabilities: uint32) {.inline, importc: "wl_seat_send_capabilities".} =
  postEvent(resource_, WL_SEAT_CAPABILITIES, capabilities)

proc wl_seat_send_name*(resource_: ptr WlResource; name: cstring) {.inline, importc: "wl_seat_send_name".} =
  postEvent(resource_, WL_SEAT_NAME, name)

type WlPointerError* = enum
  WL_POINTER_ERROR_ROLE = 0

type WlPointerButtonState* = enum
  WL_POINTER_BUTTON_STATE_RELEASED = 0,
  WL_POINTER_BUTTON_STATE_PRESSED = 1

type WlPointerAxis* = enum
  WL_POINTER_AXIS_VERTICAL_SCROLL = 0,
  WL_POINTER_AXIS_HORIZONTAL_SCROLL = 1

type WlPointerAxisSource* = enum
  WL_POINTER_AXIS_SOURCE_WHEEL = 0,
  WL_POINTER_AXIS_SOURCE_FINGER = 1,
  WL_POINTER_AXIS_SOURCE_CONTINUOUS = 2,
  WL_POINTER_AXIS_SOURCE_WHEEL_TILT = 3

const WL_POINTER_AXIS_SOURCE_WHEEL_TILT_SINCE_VERSION* = 6

type WlPointerInterface* {.bycopy.} = object
  set_cursor*: proc (client: ptr WlClient; resource: ptr WlResource; serial: uint32; surface: ptr WlResource; hotspot_x, hotspot_y: int32)
  release*: proc (client: ptr WlClient; resource: ptr WlResource)

const
  WL_POINTER_ENTER* = 0
  WL_POINTER_LEAVE* = 1
  WL_POINTER_MOTION* = 2
  WL_POINTER_BUTTON* = 3
  WL_POINTER_AXIS* = 4
  WL_POINTER_FRAME* = 5
  WL_POINTER_AXIS_SOURCE* = 6
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

proc wl_pointer_send_enter*(resource_: ptr WlResource; serial: uint32; surface: ptr WlResource; surface_x, surface_y: WlFixed) {.inline, importc: "wl_pointer_send_enter".} =
  postEvent(resource_, WL_POINTER_ENTER, serial, surface, surface_x, surface_y)

proc wl_pointer_send_leave*(resource_: ptr WlResource; serial: uint32; surface: ptr WlResource) {.inline, importc: "wl_pointer_send_leave".} =
  postEvent(resource_, WL_POINTER_LEAVE, serial, surface)

proc wl_pointer_send_motion*(resource_: ptr WlResource; time: uint32; surface_x, surface_y: WlFixed) {.inline, importc: "wl_pointer_send_motion".} =
  postEvent(resource_, WL_POINTER_MOTION, time, surface_x, surface_y)

proc wl_pointer_send_button*(resource_: ptr WlResource; serial: uint32; time: uint32; button: uint32; state: uint32) {.inline, importc: "wl_pointer_send_button".} =
  postEvent(resource_, WL_POINTER_BUTTON, serial, time, button, state)

proc wl_pointer_send_axis*(resource_: ptr WlResource; time: uint32; axis: uint32; value: WlFixed) {.inline, importc: "wl_pointer_send_axis".} =
  postEvent(resource_, WL_POINTER_AXIS, time, axis, value)

proc wl_pointer_send_frame*(resource_: ptr WlResource) {.inline, importc: "wl_pointer_send_frame".} =
  postEvent(resource_, WL_POINTER_FRAME)

proc wl_pointer_send_axis_source*(resource_: ptr WlResource; axis_source: uint32) {.inline, importc: "wl_pointer_send_axis_source".} =
  postEvent(resource_, WL_POINTER_AXIS_SOURCE, axis_source)

proc wl_pointer_send_axis_stop*(resource_: ptr WlResource; time: uint32; axis: uint32) {.inline, importc: "wl_pointer_send_axis_stop".} =
  postEvent(resource_, WL_POINTER_AXIS_STOP, time, axis)

proc wl_pointer_send_axis_discrete*(resource_: ptr WlResource; axis: uint32; discrete: int32) {.inline, importc: "wl_pointer_send_axis_discrete".} =
  postEvent(resource_, WL_POINTER_AXIS_DISCRETE, axis, discrete)

type WlKeyboardKeymapFormat* = enum
  WL_KEYBOARD_KEYMAP_FORMAT_NO_KEYMAP = 0,
  WL_KEYBOARD_KEYMAP_FORMAT_XKB_V1 = 1

type WlKeyboardKeyState* = enum
  WL_KEYBOARD_KEY_STATE_RELEASED = 0,
  WL_KEYBOARD_KEY_STATE_PRESSED = 1

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

proc wl_keyboard_send_keymap*(resource_: ptr WlResource; format: uint32; fd: int32; size: uint32) {.inline, importc: "wl_keyboard_send_keymap".} =
  postEvent(resource_, WL_KEYBOARD_KEYMAP, format, fd, size)

proc wl_keyboard_send_enter*(resource_: ptr WlResource; serial: uint32; surface: ptr WlResource; keys: ptr wl_array) {.inline, importc: "wl_keyboard_send_enter".} =
  postEvent(resource_, WL_KEYBOARD_ENTER, serial, surface, keys)

proc wl_keyboard_send_leave*(resource_: ptr WlResource; serial: uint32; surface: ptr WlResource) {.inline, importc: "wl_keyboard_send_leave".} =
  postEvent(resource_, WL_KEYBOARD_LEAVE, serial, surface)

proc wl_keyboard_send_key*(resource_: ptr WlResource; serial: uint32; time: uint32; key: uint32; state: uint32) {.inline, importc: "wl_keyboard_send_key".} =
  postEvent(resource_, WL_KEYBOARD_KEY, serial, time, key, state)

proc wl_keyboard_send_modifiers*(resource_: ptr WlResource; serial: uint32; mods_depressed: uint32; mods_latched: uint32; mods_locked: uint32; group: uint32) {.inline, importc: "wl_keyboard_send_modifiers".} =
  postEvent(resource_, WL_KEYBOARD_MODIFIERS, serial, mods_depressed, mods_latched, mods_locked, group)

proc wl_keyboard_send_repeat_info*(resource_: ptr WlResource; rate: int32; delay: int32) {.inline, importc: "wl_keyboard_send_repeat_info".} =
  postEvent(resource_, WL_KEYBOARD_REPEAT_INFO, rate, delay)

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

proc wl_touch_send_down*(resource_: ptr WlResource; serial: uint32; time: uint32; surface: ptr WlResource; id: int32; x, y: WlFixed) {.inline, importc: "wl_touch_send_down".} =
  postEvent(resource_, WL_TOUCH_DOWN, serial, time, surface, id, x, y)

proc wl_touch_send_up*(resource_: ptr WlResource; serial: uint32; time: uint32; id: int32) {.inline, importc: "wl_touch_send_up".} =
  postEvent(resource_, WL_TOUCH_UP, serial, time, id)

proc wl_touch_send_motion*(resource_: ptr WlResource; time: uint32; id: int32; x, y: WlFixed) {.inline, importc: "wl_touch_send_motion".} =
  postEvent(resource_, WL_TOUCH_MOTION, time, id, x, y)

proc wl_touch_send_frame*(resource_: ptr WlResource) {.inline, importc: "wl_touch_send_frame".} =
  postEvent(resource_, WL_TOUCH_FRAME)

proc wl_touch_send_cancel*(resource_: ptr WlResource) {.inline, importc: "wl_touch_send_cancel".} =
  postEvent(resource_, WL_TOUCH_CANCEL)

proc wl_touch_send_shape*(resource_: ptr WlResource; id: int32; major: WlFixed; minor: WlFixed) {.inline, importc: "wl_touch_send_shape".} =
  postEvent(resource_, WL_TOUCH_SHAPE, id, major, minor)

proc wl_touch_send_orientation*(resource_: ptr WlResource; id: int32; orientation: WlFixed) {.inline, importc: "wl_touch_send_orientation".} =
  postEvent(resource_, WL_TOUCH_ORIENTATION, id, orientation)

type WlOutputSubpixel* = enum
  WL_OUTPUT_SUBPIXEL_UNKNOWN = 0,
  WL_OUTPUT_SUBPIXEL_NONE = 1,
  WL_OUTPUT_SUBPIXEL_HORIZONTAL_RGB = 2,
  WL_OUTPUT_SUBPIXEL_HORIZONTAL_BGR = 3,
  WL_OUTPUT_SUBPIXEL_VERTICAL_RGB = 4,
  WL_OUTPUT_SUBPIXEL_VERTICAL_BGR = 5

type WlOutputTransform* = enum
  WL_OUTPUT_TRANSFORM_NORMAL = 0,
  WL_OUTPUT_TRANSFORM_90 = 1,
  WL_OUTPUT_TRANSFORM_180 = 2,
  WL_OUTPUT_TRANSFORM_270 = 3,
  WL_OUTPUT_TRANSFORM_FLIPPED = 4,
  WL_OUTPUT_TRANSFORM_FLIPPED_90 = 5,
  WL_OUTPUT_TRANSFORM_FLIPPED_180 = 6,
  WL_OUTPUT_TRANSFORM_FLIPPED_270 = 7

type WlOutputMode* = enum
  WL_OUTPUT_MODE_CURRENT = 0x1,
  WL_OUTPUT_MODE_PREFERRED = 0x2

type WlOutputInterface* {.bycopy.} = object
  release*: proc (client: ptr WlClient; resource: ptr WlResource)

const
  WL_OUTPUT_GEOMETRY* = 0
  WL_OUTPUT_MODE* = 1
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

proc wl_output_send_geometry*(resource_: ptr WlResource; x, y: int32; physical_width, physical_height: int32; subpixel: int32; make: cstring; model: cstring; transform: int32) {.inline, importc: "wl_output_send_geometry".} =
  postEvent(resource_, WL_OUTPUT_GEOMETRY, x, y, physical_width, physical_height, subpixel, make, model, transform)

proc wl_output_send_mode*(resource_: ptr WlResource; flags: uint32; width, height: int32; refresh: int32) {.inline, importc: "wl_output_send_mode".} =
  postEvent(resource_, WL_OUTPUT_MODE, flags, width, height, refresh)

proc wl_output_send_done*(resource_: ptr WlResource) {.inline, importc: "wl_output_send_done".} =
  postEvent(resource_, WL_OUTPUT_DONE)

proc wl_output_send_scale*(resource_: ptr WlResource; factor: int32) {.inline, importc: "wl_output_send_scale".} =
  postEvent(resource_, WL_OUTPUT_SCALE, factor)

proc wl_output_send_name*(resource_: ptr WlResource; name: cstring) {.inline, importc: "wl_output_send_name".} =
  postEvent(resource_, WL_OUTPUT_NAME, name)

proc wl_output_send_description*(resource_: ptr WlResource; description: cstring) {.inline, importc: "wl_output_send_description".} =
  postEvent(resource_, WL_OUTPUT_DESCRIPTION, description)

type WlRegionInterface* {.bycopy.} = object
  destroy*: proc (client: ptr WlClient; resource: ptr WlResource)
  add*: proc (client: ptr WlClient; resource: ptr WlResource; x, y: int32; width, height: int32)
  subtract*: proc (client: ptr WlClient; resource: ptr WlResource; x, y: int32; width, height: int32)

const
  WL_REGION_DESTROY_SINCE_VERSION* = 1
  WL_REGION_ADD_SINCE_VERSION* = 1
  WL_REGION_SUBTRACT_SINCE_VERSION* = 1

type WlSubcompositorError* = enum
  WL_SUBCOMPOSITOR_ERROR_BAD_SURFACE = 0

type WlSubcompositorInterface* {.bycopy.} = object
  destroy*: proc (client: ptr WlClient; resource: ptr WlResource)
  get_subsurface*: proc (client: ptr WlClient; resource: ptr WlResource; id: uint32; surface: ptr WlResource; parent: ptr WlResource)

const
  WL_SUBCOMPOSITOR_DESTROY_SINCE_VERSION* = 1
  WL_SUBCOMPOSITOR_GET_SUBSURFACE_SINCE_VERSION* = 1

type WlSubsurfaceError* = enum
  WL_SUBSURFACE_ERROR_BAD_SURFACE = 0

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
