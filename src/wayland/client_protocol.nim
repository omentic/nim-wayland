{.push dynlib: "libwlroots.so" .}

import client_core

# FIXME: shim
type
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
  WlShmPoolInterface*: WlInterface
  WlShmInterface*: WlInterface
  WlBufferInterface*: WlInterface
  WlDataOfferInterface*: WlInterface
  WlDataSourceInterface*: WlInterface
  WlDataDeviceInterface*: WlInterface
  WlDataDeviceManagerInterface*: WlInterface
  WlShellInterface*: WlInterface
  WlShellSurfaceInterface*: WlInterface
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

type WlDisplayListener* {.bycopy.} = object
  error*: proc (data: pointer; wl_display: ptr WlDisplay; object_id: pointer; code: uint32; message: cstring)
  delete_id*: proc (data: pointer; wl_display: ptr WlDisplay; id: uint32)

proc addListener*(wl_display: ptr WlDisplay; listener: ptr WlDisplayListener; data: pointer): cint {.inline, importc: "wl_display_add_listener".} =
  return add_listener(cast[ptr WlProxy](wl_display), cast[proc ()](listener), data)

const
  WL_DISPLAY_SYNC* = 0
  WL_DISPLAY_GET_REGISTRY* = 1

const
  WL_DISPLAY_ERROR_SINCE_VERSION* = 1
  WL_DISPLAY_DELETE_ID_SINCE_VERSION* = 1
  WL_DISPLAY_SYNC_SINCE_VERSION* = 1
  WL_DISPLAY_GET_REGISTRY_SINCE_VERSION* = 1

proc setUserData*(wl_display: ptr WlDisplay; user_data: pointer) {.inline, importc: "wl_display_set_user_data".} =
  set_user_data(cast[ptr WlProxy](wl_display), user_data)

proc getUserData*(wl_display: ptr WlDisplay): pointer {.inline, importc: "wl_display_get_user_data".} =
  return get_user_data(cast[ptr WlProxy](wl_display))

proc getVersion*(wl_display: ptr WlDisplay): uint32 {.inline, importc: "wl_display_get_version".} =
  return get_version(cast[ptr WlProxy](wl_display))

proc sync*(wl_display: ptr WlDisplay): ptr WlCallback {.inline, importc: "wl_display_sync".} =
  var callback: ptr WlProxy
  callback = marshal_flags(cast[ptr WlProxy](wl_display), WL_DISPLAY_SYNC, addr(wl_callback_interface), get_version(cast[ptr WlProxy](wl_display)), 0, nil)
  return cast[ptr WlCallback](callback)

proc getRegistry*(wl_display: ptr WlDisplay): ptr WlRegistry {.inline, importc: "wl_display_get_registry".} =
  var registry: ptr WlProxy
  registry = marshal_flags(cast[ptr WlProxy](wl_display), WL_DISPLAY_GET_REGISTRY, addr(wl_registry_interface), get_version(cast[ptr WlProxy](wl_display)), 0, nil)
  return cast[ptr WlRegistry](registry)

type WlRegistryListener* {.bycopy.} = object
  global*: proc (data: pointer; wl_registry: ptr WlRegistry; name: uint32; `interface`: cstring; version: uint32)
  global_remove*: proc (data: pointer; wl_registry: ptr WlRegistry; name: uint32)

proc addListener*(wl_registry: ptr WlRegistry; listener: ptr WlRegistry_listener; data: pointer): cint {.inline, importc: "wl_registry_add_listener".} =
  return add_listener(cast[ptr WlProxy](wl_registry), cast[proc ()](listener), data)

const
  WL_REGISTRY_BIND* = 0
  WL_REGISTRY_GLOBAL_SINCE_VERSION* = 1
  WL_REGISTRY_GLOBAL_REMOVE_SINCE_VERSION* = 1
  WL_REGISTRY_BIND_SINCE_VERSION* = 1

proc setUserData*(wl_registry: ptr WlRegistry; user_data: pointer) {.inline, importc: "wl_registry_set_user_data".} =
  set_user_data(cast[ptr WlProxy](wl_registry), user_data)

proc getUserData*(wl_registry: ptr WlRegistry): pointer {.inline, importc: "wl_registry_get_user_data".} =
  return get_user_data(cast[ptr WlProxy](wl_registry))

proc getVersion*(wl_registry: ptr WlRegistry): uint32 {.inline, importc: "wl_registry_get_version".} =
  return get_version(cast[ptr WlProxy](wl_registry))

proc destroy*(wl_registry: ptr WlRegistry) {.inline, importc: "wl_registry_destroy".} =
  destroy(cast[ptr WlProxy](wl_registry))

proc bind*(wl_registry: ptr WlRegistry; name: uint32; `interface`: ptr WlInterface; version: uint32): pointer {.inline, importc: "wl_registry_bind".} =
  var id: ptr WlProxy
  id = marshal_flags(cast[ptr WlProxy](wl_registry), WL_REGISTRY_BIND, `interface`, version, 0, name, `interface`.name, version, nil)
  return cast[pointer](id)

type WlCallbackListener* {.bycopy.} = object
  done*: proc (data: pointer; wl_callback: ptr WlCallback; callback_data: uint32)

proc addListener*(wl_callback: ptr WlCallback; listener: ptr WlCallback_listener; data: pointer): cint {.inline, importc: "wl_callback_add_listener".} =
  return add_listener(cast[ptr WlProxy](wl_callback), cast[proc ()](listener), data)

const WL_CALLBACK_DONE_SINCE_VERSION* = 1

proc setUserData*(wl_callback: ptr WlCallback; user_data: pointer) {.inline, importc: "wl_callback_set_user_data".} =
  set_user_data(cast[ptr WlProxy](wl_callback), user_data)

proc getUserData*(wl_callback: ptr WlCallback): pointer {.inline, importc: "wl_callback_get_user_data".} =
  return get_user_data(cast[ptr WlProxy](wl_callback))

proc getVersion*(wl_callback: ptr WlCallback): uint32 {.inline, importc: "wl_callback_get_version".} =
  return get_version(cast[ptr WlProxy](wl_callback))

proc destroy*(wl_callback: ptr WlCallback) {.inline, importc: "wl_callback_destroy".} =
  destroy(cast[ptr WlProxy](wl_callback))

const
  WL_COMPOSITOR_CREATE_SURFACE* = 0
  WL_COMPOSITOR_CREATE_REGION* = 1

const
  WL_COMPOSITOR_CREATE_SURFACE_SINCE_VERSION* = 1
  WL_COMPOSITOR_CREATE_REGION_SINCE_VERSION* = 1

proc setUserData*(wl_compositor: ptr WlCompositor; user_data: pointer) {.inline, importc: "wl_compositor_set_user_data".} =
  set_user_data(cast[ptr WlProxy](wl_compositor), user_data)

proc getUserData*(wl_compositor: ptr WlCompositor): pointer {.inline, importc: "wl_compositor_get_user_data".} =
  return get_user_data(cast[ptr WlProxy](wl_compositor))

proc getVersion*(wl_compositor: ptr WlCompositor): uint32 {.inline, importc: "wl_compositor_get_version".} =
  return get_version(cast[ptr WlProxy](wl_compositor))

proc destroy*(wl_compositor: ptr WlCompositor) {.inline, importc: "wl_compositor_destroy".} =
  destroy(cast[ptr WlProxy](wl_compositor))

proc createSurface*(wl_compositor: ptr WlCompositor): ptr WlSurface {.inline, importc: "wl_compositor_create_surface".} =
  var id: ptr WlProxy
  id = marshal_flags(cast[ptr WlProxy](wl_compositor), WL_COMPOSITOR_CREATE_SURFACE, addr(wl_surface_interface), get_version(cast[ptr WlProxy](wl_compositor)), 0, nil)
  return cast[ptr WlSurface](id)

proc createRegion*(wl_compositor: ptr WlCompositor): ptr WlRegion {.inline, importc: "wl_compositor_create_region".} =
  var id: ptr WlProxy
  id = marshal_flags(cast[ptr WlProxy](wl_compositor), WL_COMPOSITOR_CREATE_REGION, addr(wl_region_interface), get_version(cast[ptr WlProxy](wl_compositor)), 0, nil)
  return cast[ptr WlRegion](id)

const
  WL_SHM_POOL_CREATE_BUFFER* = 0
  WL_SHM_POOL_DESTROY* = 1
  WL_SHM_POOL_RESIZE* = 2

const
  WL_SHM_POOL_CREATE_BUFFER_SINCE_VERSION* = 1
  WL_SHM_POOL_DESTROY_SINCE_VERSION* = 1
  WL_SHM_POOL_RESIZE_SINCE_VERSION* = 1

proc setUserData*(wl_shm_pool: ptr WlShmPool; user_data: pointer) {.inline, importc: "wl_shm_pool_set_user_data".} =
  set_user_data(cast[ptr WlProxy](wl_shm_pool), user_data)

proc getUserData*(wl_shm_pool: ptr WlShmPool): pointer {.inline, importc: "wl_shm_pool_get_user_data".} =
  return get_user_data(cast[ptr WlProxy](wl_shm_pool))

proc getVersion*(wl_shm_pool: ptr WlShmPool): uint32 {.inline, importc: "wl_shm_pool_get_version".} =
  return get_version(cast[ptr WlProxy](wl_shm_pool))

proc createBuffer*(wl_shm_pool: ptr WlShmPool; offset: int32; width, height: int32; stride: int32; format: uint32): ptr WlBuffer {.inline, importc: "wl_shm_pool_create_buffer".} =
  var id: ptr WlProxy
  id = marshal_flags(cast[ptr WlProxy](wl_shm_pool), WL_SHM_POOL_CREATE_BUFFER, addr(wl_buffer_interface), get_version(cast[ptr WlProxy](wl_shm_pool)), 0, nil, offset, width, height, stride, format)
  return cast[ptr WlBuffer](id)

proc destroy*(wl_shm_pool: ptr WlShmPool) {.inline, importc: "wl_shm_pool_destroy".} =
  marshal_flags(cast[ptr WlProxy](wl_shm_pool), WL_SHM_POOL_DESTROY, nil, get_version(cast[ptr WlProxy](wl_shm_pool)), WL_MARSHAL_FLAG_DESTROY)

proc resize*(wl_shm_pool: ptr WlShmPool; size: int32) {.inline, importc: "wl_shm_pool_resize".} =
  marshal_flags(cast[ptr WlProxy](wl_shm_pool), WL_SHM_POOL_RESIZE, nil, get_version(cast[ptr WlProxy](wl_shm_pool)), 0, size)

type WlShmError* = enum
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

type WlShmListener* {.bycopy.} = object
  format*: proc (data: pointer; wl_shm: ptr WlShm; format: uint32)

proc addListener*(wl_shm: ptr WlShm; listener: ptr WlShmListener; data: pointer): cint {.inline, importc: "wl_shm_add_listener".} =
  return add_listener(cast[ptr WlProxy](wl_shm), cast[proc ()](listener), data)

const
  WL_SHM_CREATE_POOL* = 0
  SINCE_VERSION* = 1
  WL_SHM_CREATE_POOL_SINCE_VERSION* = 1

proc setUserData*(wl_shm: ptr WlShm; user_data: pointer) {.inline, importc: "wl_shm_set_user_data".} =
  set_user_data(cast[ptr WlProxy](wl_shm), user_data)

proc getUserData*(wl_shm: ptr WlShm): pointer {.inline, importc: "wl_shm_get_user_data".} =
  return get_user_data(cast[ptr WlProxy](wl_shm))

proc getVersion*(wl_shm: ptr WlShm): uint32 {.inline, importc: "wl_shm_get_version".} =
  return get_version(cast[ptr WlProxy](wl_shm))

proc destroy*(wl_shm: ptr WlShm) {.inline, importc: "wl_shm_destroy".} =
  destroy(cast[ptr WlProxy](wl_shm))

proc createPool*(wl_shm: ptr WlShm; fd: int32; size: int32): ptr WlShmPool {.inline, importc: "wl_shm_create_pool".} =
  var id: ptr WlProxy
  id = marshal_flags(cast[ptr WlProxy](wl_shm), WL_SHM_CREATE_POOL, addr(wl_shm_pool_interface), get_version(cast[ptr WlProxy](wl_shm)), 0, nil, fd, size)
  return cast[ptr WlShmPool](id)

type WlBufferListener* {.bycopy.} = object
  release*: proc (data: pointer; wl_buffer: ptr WlBuffer)

proc addListener*(wl_buffer: ptr WlBuffer; listener: ptr WlBufferListener; data: pointer): cint {.inline, importc: "wl_buffer_add_listener".} =
  return add_listener(cast[ptr WlProxy](wl_buffer), cast[proc ()](listener), data)

const
  WL_BUFFER_DESTROY* = 0
  WL_BUFFER_RELEASE_SINCE_VERSION* = 1
  WL_BUFFER_DESTROY_SINCE_VERSION* = 1

proc setUserData*(wl_buffer: ptr WlBuffer; user_data: pointer) {.inline, importc: "wl_buffer_set_user_data".} =
  set_user_data(cast[ptr WlProxy](wl_buffer), user_data)

proc getUserData*(wl_buffer: ptr WlBuffer): pointer {.inline, importc: "wl_buffer_get_user_data".} =
  return get_user_data(cast[ptr WlProxy](wl_buffer))

proc getVersion*(wl_buffer: ptr WlBuffer): uint32 {.inline, importc: "wl_buffer_get_version".} =
  return get_version(cast[ptr WlProxy](wl_buffer))

proc destroy*(wl_buffer: ptr WlBuffer) {.inline, importc: "wl_buffer_destroy".} =
  marshal_flags(cast[ptr WlProxy](wl_buffer), WL_BUFFER_DESTROY, nil, get_version(cast[ptr WlProxy](wl_buffer)), WL_MARSHAL_FLAG_DESTROY)

type WlDataOfferError* = enum
  WL_DATA_OFFER_ERROR_INVALID_FINISH = 0,
  WL_DATA_OFFER_ERROR_INVALID_ACTION_MASK = 1,
  WL_DATA_OFFER_ERROR_INVALID_ACTION = 2,
  WL_DATA_OFFER_ERROR_INVALID_OFFER = 3

type WlDataOfferListener* {.bycopy.} = object
  offer*: proc (data: pointer; wl_data_offer: ptr WlDataOffer; mime_type: cstring)
  source_actions*: proc (data: pointer; wl_data_offer: ptr WlDataOffer; source_actions: uint32)
  action*: proc (data: pointer; wl_data_offer: ptr WlDataOffer; dnd_action: uint32)

proc addListener*(wl_data_offer: ptr WlDataOffer; listener: ptr WlDataOffer_listener; data: pointer): cint {.inline, importc: "wl_data_offer_add_listener".} =
  return add_listener(cast[ptr WlProxy](wl_data_offer), cast[proc ()](listener), data)

const
  WL_DATA_OFFER_ACCEPT* = 0
  WL_DATA_OFFER_RECEIVE* = 1
  WL_DATA_OFFER_DESTROY* = 2
  WL_DATA_OFFER_FINISH* = 3
  WL_DATA_OFFER_SET_ACTIONS* = 4

const
  WL_DATA_OFFER_OFFER_SINCE_VERSION* = 1
  WL_DATA_OFFER_SOURCE_ACTIONS_SINCE_VERSION* = 3
  WL_DATA_OFFER_ACTION_SINCE_VERSION* = 3
  WL_DATA_OFFER_ACCEPT_SINCE_VERSION* = 1
  WL_DATA_OFFER_RECEIVE_SINCE_VERSION* = 1
  WL_DATA_OFFER_DESTROY_SINCE_VERSION* = 1
  WL_DATA_OFFER_FINISH_SINCE_VERSION* = 3
  WL_DATA_OFFER_SET_ACTIONS_SINCE_VERSION* = 3

proc setUserData*(wl_data_offer: ptr WlDataOffer; user_data: pointer) {.inline, importc: "wl_data_offer_set_user_data".} =
  set_user_data(cast[ptr WlProxy](wl_data_offer), user_data)

proc getUserData*(wl_data_offer: ptr WlDataOffer): pointer {.inline, importc: "wl_data_offer_get_user_data".} =
  return get_user_data(cast[ptr WlProxy](wl_data_offer))

proc getVersion*(wl_data_offer: ptr WlDataOffer): uint32 {.inline, importc: "wl_data_offer_get_version".} =
  return get_version(cast[ptr WlProxy](wl_data_offer))

proc accept*(wl_data_offer: ptr WlDataOffer; serial: uint32; mime_type: cstring) {.inline, importc: "wl_data_offer_accept".} =
  marshal_flags(cast[ptr WlProxy](wl_data_offer), WL_DATA_OFFER_ACCEPT, nil, get_version(
      cast[ptr WlProxy](wl_data_offer)), 0, serial, mime_type)

proc receive*(wl_data_offer: ptr WlDataOffer; mime_type: cstring; fd: int32) {.inline, importc: "wl_data_offer_receive".} =
  marshal_flags(cast[ptr WlProxy](wl_data_offer), WL_DATA_OFFER_RECEIVE, nil, get_version(
      cast[ptr WlProxy](wl_data_offer)), 0, mime_type, fd)

proc destroy*(wl_data_offer: ptr WlDataOffer) {.inline, importc: "wl_data_offer_destroy".} =
  marshal_flags(cast[ptr WlProxy](wl_data_offer), WL_DATA_OFFER_DESTROY, nil, get_version(
      cast[ptr WlProxy](wl_data_offer)), WL_MARSHAL_FLAG_DESTROY)

proc finish*(wl_data_offer: ptr WlDataOffer) {.inline, importc: "wl_data_offer_finish".} =
  marshal_flags(cast[ptr WlProxy](wl_data_offer), WL_DATA_OFFER_FINISH, nil, get_version(
      cast[ptr WlProxy](wl_data_offer)), 0)

proc setActions*(wl_data_offer: ptr WlDataOffer; dnd_actions: uint32; preferred_action: uint32) {.inline, importc: "wl_data_offer_set_actions".} =
  marshal_flags(cast[ptr WlProxy](wl_data_offer), WL_DATA_OFFER_SET_ACTIONS, nil, get_version(
      cast[ptr WlProxy](wl_data_offer)), 0, dnd_actions, preferred_action)

type WlDataSourceError* = enum
  WL_DATA_SOURCE_ERROR_INVALID_ACTION_MASK = 0,
  WL_DATA_SOURCE_ERROR_INVALID_SOURCE = 1

type WlDataSourceListener* {.bycopy.} = object
  target*: proc (data: pointer; wl_data_source: ptr WlDataSource; mime_type: cstring)
  send*: proc (data: pointer; wl_data_source: ptr WlDataSource; mime_type: cstring; fd: int32)
  cancelled*: proc (data: pointer; wl_data_source: ptr WlDataSource)
  dnd_drop_performed*: proc (data: pointer; wl_data_source: ptr WlDataSource)
  dnd_finished*: proc (data: pointer; wl_data_source: ptr WlDataSource)
  action*: proc (data: pointer; wl_data_source: ptr WlDataSource; dnd_action: uint32)

proc addListener*(wl_data_source: ptr WlDataSource; listener: ptr WlDataSourceListener; data: pointer): cint {.inline, importc: "wl_data_source_add_listener".} =
  return add_listener(cast[ptr WlProxy](wl_data_source), cast[proc ()](listener), data)

const
  WL_DATA_SOURCE_OFFER* = 0
  WL_DATA_SOURCE_DESTROY* = 1
  WL_DATA_SOURCE_SET_ACTIONS* = 2

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

proc setUserData*(wl_data_source: ptr WlDataSource; user_data: pointer) {.inline, importc: "wl_data_source_set_user_data".} =
  set_user_data(cast[ptr WlProxy](wl_data_source), user_data)

proc getUserData*(wl_data_source: ptr WlDataSource): pointer {.inline, importc: "wl_data_source_get_user_data".} =
  return get_user_data(cast[ptr WlProxy](wl_data_source))

proc getVersion*(wl_data_source: ptr WlDataSource): uint32 {.inline, importc: "wl_data_source_get_version".} =
  return get_version(cast[ptr WlProxy](wl_data_source))

proc offer*(wl_data_source: ptr WlDataSource; mime_type: cstring) {.inline, importc: "wl_data_source_offer".} =
  marshal_flags(cast[ptr WlProxy](wl_data_source), WL_DATA_SOURCE_OFFER, nil, get_version(cast[ptr WlProxy](wl_data_source)), 0, mime_type)

proc destroy*(wl_data_source: ptr WlDataSource) {.inline, importc: "wl_data_source_destroy".} =
  marshal_flags(cast[ptr WlProxy](wl_data_source), WL_DATA_SOURCE_DESTROY, nil, get_version(cast[ptr WlProxy](wl_data_source)), WL_MARSHAL_FLAG_DESTROY)

proc setActions*(wl_data_source: ptr WlDataSource; dnd_actions: uint32) {.inline, importc: "wl_data_source_set_actions".} =
  marshal_flags(cast[ptr WlProxy](wl_data_source), WL_DATA_SOURCE_SET_ACTIONS, nil, get_version(cast[ptr WlProxy](wl_data_source)), 0, dnd_actions)

type WlDataDeviceError* = enum
  WL_DATA_DEVICE_ERROR_ROLE = 0

type WlDataDeviceListener* {.bycopy.} = object
  data_offer*: proc (data: pointer; wl_data_device: ptr WlDataDevice; id: ptr WlDataOffer)
  enter*: proc (data: pointer; wl_data_device: ptr WlDataDevice; serial: uint32; surface: ptr WlSurface; x, y: WlFixed; id: ptr WlDataOffer)
  leave*: proc (data: pointer; wl_data_device: ptr WlDataDevice)
  motion*: proc (data: pointer; wl_data_device: ptr WlDataDevice; time: uint32; x, y: WlFixed)
  drop*: proc (data: pointer; wl_data_device: ptr WlDataDevice)
  selection*: proc (data: pointer; wl_data_device: ptr WlDataDevice; id: ptr WlDataOffer)

proc addListener*(wl_data_device: ptr WlDataDevice; listener: ptr WlDataDeviceListener; data: pointer): cint {.inline, importc: "wl_data_device_add_listener".} =
  return add_listener(cast[ptr WlProxy](wl_data_device), cast[proc ()](listener), data)

const
  WL_DATA_DEVICE_START_DRAG* = 0
  WL_DATA_DEVICE_SET_SELECTION* = 1
  WL_DATA_DEVICE_RELEASE* = 2

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

proc setUserData*(wl_data_device: ptr WlDataDevice; user_data: pointer) {.inline, importc: "wl_data_device_set_user_data".} =
  set_user_data(cast[ptr WlProxy](wl_data_device), user_data)

proc getUserData*(wl_data_device: ptr WlDataDevice): pointer {.inline, importc: "wl_data_device_get_user_data".} =
  return get_user_data(cast[ptr WlProxy](wl_data_device))

proc getVersion*(wl_data_device: ptr WlDataDevice): uint32 {.inline, importc: "wl_data_device_get_version".} =
  return get_version(cast[ptr WlProxy](wl_data_device))

proc destroy*(wl_data_device: ptr WlDataDevice) {.inline, importc: "wl_data_device_destroy".} =
  destroy(cast[ptr WlProxy](wl_data_device))

proc startDrag*(wl_data_device: ptr WlDataDevice; source: ptr WlDataSource; origin: ptr WlSurface; icon: ptr WlSurface; serial: uint32) {.inline, importc: "wl_data_device_start_drag".} =
  marshal_flags(cast[ptr WlProxy](wl_data_device), WL_DATA_DEVICE_START_DRAG, nil, get_version(cast[ptr WlProxy](wl_data_device)), 0, source, origin, icon, serial)

proc setSelection*(wl_data_device: ptr WlDataDevice; source: ptr WlDataSource; serial: uint32) {.inline, importc: "wl_data_device_set_selection".} =
  marshal_flags(cast[ptr WlProxy](wl_data_device), WL_DATA_DEVICE_SET_SELECTION, nil, get_version(cast[ptr WlProxy](wl_data_device)), 0, source, serial)

proc release*(wl_data_device: ptr WlDataDevice) {.inline, importc: "wl_data_device_release".} =
  marshal_flags(cast[ptr WlProxy](wl_data_device), WL_DATA_DEVICE_RELEASE, nil, get_version(cast[ptr WlProxy](wl_data_device)), WL_MARSHAL_FLAG_DESTROY)

type WlDataDeviceManagerDndAction* = enum
  WL_DATA_DEVICE_MANAGER_DND_ACTION_NONE = 0,
  WL_DATA_DEVICE_MANAGER_DND_ACTION_COPY = 1,
  WL_DATA_DEVICE_MANAGER_DND_ACTION_MOVE = 2,
  WL_DATA_DEVICE_MANAGER_DND_ACTION_ASK = 4

const
  WL_DATA_DEVICE_MANAGER_CREATE_DATA_SOURCE* = 0
  WL_DATA_DEVICE_MANAGER_GET_DATA_DEVICE* = 1
  WL_DATA_DEVICE_MANAGER_CREATE_DATA_SOURCE_SINCE_VERSION* = 1
  WL_DATA_DEVICE_MANAGER_GET_DATA_DEVICE_SINCE_VERSION* = 1

proc setUserData*(wl_data_device_manager: ptr WlDataDeviceManager; user_data: pointer) {.inline, importc: "wl_data_device_manager_set_user_data".} =
  set_user_data(cast[ptr WlProxy](wl_data_device_manager), user_data)

proc getUserData*(wl_data_device_manager: ptr WlDataDeviceManager): pointer {.inline, importc: "wl_data_device_manager_get_user_data".} =
  return get_user_data(cast[ptr WlProxy](wl_data_device_manager))

proc getVersion*(wl_data_device_manager: ptr WlDataDeviceManager): uint32 {.inline, importc: "wl_data_device_manager_get_version".} =
  return get_version(cast[ptr WlProxy](wl_data_device_manager))

proc destroy*(wl_data_device_manager: ptr WlDataDeviceManager) {.inline, importc: "wl_data_device_manager_destroy".} =
  destroy(cast[ptr WlProxy](wl_data_device_manager))

proc createDataSource*(wl_data_device_manager: ptr WlDataDeviceManager): ptr WlDataSource {.inline, importc: "wl_data_device_manager_create_data_source".} =
  var id: ptr WlProxy
  id = marshal_flags(cast[ptr WlProxy](wl_data_device_manager), WL_DATA_DEVICE_MANAGER_CREATE_DATA_SOURCE, addr(wl_data_source_interface), get_version(cast[ptr WlProxy](wl_data_device_manager)), 0, nil)
  return cast[ptr WlDataSource](id)

proc getDataDevice*(wl_data_device_manager: ptr WlDataDeviceManager; seat: ptr WlSeat): ptr WlDataDevice {.inline, importc: "wl_data_device_manager_get_data_device".} =
  var id: ptr WlProxy
  id = marshal_flags(cast[ptr WlProxy](wl_data_device_manager), WL_DATA_DEVICE_MANAGER_GET_DATA_DEVICE, addr(wl_data_device_interface), get_version(cast[ptr WlProxy](wl_data_device_manager)), 0, nil, seat)
  return cast[ptr WlDataDevice](id)

type WlShellError* = enum
  WL_SHELL_ERROR_ROLE = 0

const
  WL_SHELL_GET_SHELL_SURFACE* = 0
  WL_SHELL_GET_SHELL_SURFACE_SINCE_VERSION* = 1

proc setUserData*(wl_shell: ptr WlShell; user_data: pointer) {.inline, importc: "wl_shell_set_user_data".} =
  set_user_data(cast[ptr WlProxy](wl_shell), user_data)

proc getUserData*(wl_shell: ptr WlShell): pointer {.inline, importc: "wl_shell_get_user_data".} =
  return get_user_data(cast[ptr WlProxy](wl_shell))

proc getVersion*(wl_shell: ptr WlShell): uint32 {.inline, importc: "wl_shell_get_version".} =
  return get_version(cast[ptr WlProxy](wl_shell))

proc destroy*(wl_shell: ptr WlShell) {.inline, importc: "wl_shell_destroy".} =
  destroy(cast[ptr WlProxy](wl_shell))

proc getShellSurface*(wl_shell: ptr WlShell; surface: ptr WlSurface): ptr WlShellSurface {.inline, importc: "wl_shell_get_shell_surface".} =
  var id: ptr WlProxy
  id = marshal_flags(cast[ptr WlProxy](wl_shell), WL_SHELL_GET_SHELL_SURFACE, addr(wl_shell_surface_interface), get_version(cast[ptr WlProxy](wl_shell)), 0, nil, surface)
  return cast[ptr WlShellSurface](id)

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

type WlShellSurfaceListener* {.bycopy.} = object
  ping*: proc (data: pointer; wl_shell_surface: ptr WlShellSurface; serial: uint32)
  configure*: proc (data: pointer; wl_shell_surface: ptr WlShellSurface; edges: uint32; width, height: int32)
  popup_done*: proc (data: pointer; wl_shell_surface: ptr WlShellSurface)

proc addListener*(wl_shell_surface: ptr WlShellSurface; listener: ptr WlShellSurface_listener; data: pointer): cint {.inline, importc: "wl_shell_surface_add_listener".} =
  return add_listener(cast[ptr WlProxy](wl_shell_surface), cast[proc ()](listener), data)

const
  WL_SHELL_SURFACE_PONG* = 0
  WL_SHELL_SURFACE_MOVE* = 1
  WL_SHELL_SURFACE_RESIZE* = 2
  WL_SHELL_SURFACE_SET_TOPLEVEL* = 3
  WL_SHELL_SURFACE_SET_TRANSIENT* = 4
  WL_SHELL_SURFACE_SET_FULLSCREEN* = 5
  WL_SHELL_SURFACE_SET_POPUP* = 6
  WL_SHELL_SURFACE_SET_MAXIMIZED* = 7
  WL_SHELL_SURFACE_SET_TITLE* = 8
  WL_SHELL_SURFACE_SET_CLASS* = 9

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

proc setUserData*(wl_shell_surface: ptr WlShellSurface; user_data: pointer) {.inline, importc: "wl_shell_surface_set_user_data".} =
  set_user_data(cast[ptr WlProxy](wl_shell_surface), user_data)

proc getUserData*(wl_shell_surface: ptr WlShellSurface): pointer {.inline, importc: "wl_shell_surface_get_user_data".} =
  return get_user_data(cast[ptr WlProxy](wl_shell_surface))

proc getVersion*(wl_shell_surface: ptr WlShellSurface): uint32 {.inline, importc: "wl_shell_surface_get_version".} =
  return get_version(cast[ptr WlProxy](wl_shell_surface))

proc destroy*(wl_shell_surface: ptr WlShellSurface) {.inline, importc: "wl_shell_surface_destroy".} =
  destroy(cast[ptr WlProxy](wl_shell_surface))

proc pong*(wl_shell_surface: ptr WlShellSurface; serial: uint32) {.inline, importc: "wl_shell_surface_pong".} =
  marshal_flags(cast[ptr WlProxy](wl_shell_surface), WL_SHELL_SURFACE_PONG, nil, get_version(cast[ptr WlProxy](wl_shell_surface)), 0, serial)

proc move*(wl_shell_surface: ptr WlShellSurface; seat: ptr WlSeat; serial: uint32) {.inline, importc: "wl_shell_surface_move".} =
  marshal_flags(cast[ptr WlProxy](wl_shell_surface), WL_SHELL_SURFACE_MOVE, nil, get_version(cast[ptr WlProxy](wl_shell_surface)), 0, seat, serial)

proc resize*(wl_shell_surface: ptr WlShellSurface; seat: ptr WlSeat; serial: uint32; edges: uint32) {.inline, importc: "wl_shell_surface_resize".} =
  marshal_flags(cast[ptr WlProxy](wl_shell_surface), WL_SHELL_SURFACE_RESIZE, nil, get_version(cast[ptr WlProxy](wl_shell_surface)), 0, seat, serial, edges)

proc setToplevel*(wl_shell_surface: ptr WlShellSurface) {.inline, importc: "wl_shell_surface_set_toplevel".} =
  marshal_flags(cast[ptr WlProxy](wl_shell_surface), WL_SHELL_SURFACE_SET_TOPLEVEL, nil, get_version(cast[ptr WlProxy](wl_shell_surface)), 0)

proc setTransient*(wl_shell_surface: ptr WlShellSurface; parent: ptr WlSurface; x, y: int32; flags: uint32) {.inline, importc: "wl_shell_surface_set_transient".} =
  marshal_flags(cast[ptr WlProxy](wl_shell_surface), WL_SHELL_SURFACE_SET_TRANSIENT, nil, get_version(cast[ptr WlProxy](wl_shell_surface)), 0, parent, x, y, flags)

proc setFullscreen*(wl_shell_surface: ptr WlShellSurface; `method`: uint32; framerate: uint32; output: ptr WlOutput) {.inline, importc: "wl_shell_surface_set_fullscreen".} =
  marshal_flags(cast[ptr WlProxy](wl_shell_surface), WL_SHELL_SURFACE_SET_FULLSCREEN, nil, get_version(cast[ptr WlProxy](wl_shell_surface)), 0, `method`, framerate, output)

proc setPopup*(wl_shell_surface: ptr WlShellSurface; seat: ptr WlSeat; serial: uint32; parent: ptr WlSurface; x, y: int32; flags: uint32) {.inline, importc: "wl_shell_surface_set_popup".} =
  marshal_flags(cast[ptr WlProxy](wl_shell_surface), WL_SHELL_SURFACE_SET_POPUP, nil, get_version(cast[ptr WlProxy](wl_shell_surface)), 0, seat, serial, parent, x, y, flags)

proc setMaximized*(wl_shell_surface: ptr WlShellSurface; output: ptr WlOutput) {.inline, importc: "wl_shell_surface_set_maximized".} =
  marshal_flags(cast[ptr WlProxy](wl_shell_surface), WL_SHELL_SURFACE_SET_MAXIMIZED, nil, get_version(cast[ptr WlProxy](wl_shell_surface)), 0, output)

proc setTitle*(wl_shell_surface: ptr WlShellSurface; title: cstring) {.inline, importc: "wl_shell_surface_set_title".} =
  marshal_flags(cast[ptr WlProxy](wl_shell_surface), WL_SHELL_SURFACE_SET_TITLE, nil, get_version(cast[ptr WlProxy](wl_shell_surface)), 0, title)

proc setClass*(wl_shell_surface: ptr WlShellSurface; class_: cstring) {.inline, importc: "wl_shell_surface_set_class".} =
  marshal_flags(cast[ptr WlProxy](wl_shell_surface), WL_SHELL_SURFACE_SET_CLASS, nil, get_version(cast[ptr WlProxy](wl_shell_surface)), 0, class_)

type WlSurfaceError* = enum
  WL_SURFACE_ERROR_INVALID_SCALE = 0,
  WL_SURFACE_ERROR_INVALID_TRANSFORM = 1,
  WL_SURFACE_ERROR_INVALID_SIZE = 2,
  WL_SURFACE_ERROR_INVALID_OFFSET = 3

type WlSurfaceListener* {.bycopy.} = object
  enter*: proc (data: pointer; wl_surface: ptr WlSurface; output: ptr WlOutput)
  leave*: proc (data: pointer; wl_surface: ptr WlSurface; output: ptr WlOutput)

proc addListener*(wl_surface: ptr WlSurface; listener: ptr WlSurfaceListener; data: pointer): cint {.inline, importc: "wl_surface_add_listener".} =
  return add_listener(cast[ptr WlProxy](wl_surface), cast[proc ()](listener), data)

const
  WL_SURFACE_DESTROY* = 0
  WL_SURFACE_ATTACH* = 1
  WL_SURFACE_DAMAGE* = 2
  WL_SURFACE_FRAME* = 3
  WL_SURFACE_SET_OPAQUE_REGION* = 4
  WL_SURFACE_SET_INPUT_REGION* = 5
  WL_SURFACE_COMMIT* = 6
  WL_SURFACE_SET_BUFFER_TRANSFORM* = 7
  WL_SURFACE_SET_BUFFER_SCALE* = 8
  WL_SURFACE_DAMAGE_BUFFER* = 9
  WL_SURFACE_OFFSET* = 10

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

proc setUserData*(wl_surface: ptr WlSurface; user_data: pointer) {.inline, importc: "wl_surface_set_user_data".} =
  set_user_data(cast[ptr WlProxy](wl_surface), user_data)

proc getUserData*(wl_surface: ptr WlSurface): pointer {.inline, importc: "wl_surface_get_user_data".} =
  return get_user_data(cast[ptr WlProxy](wl_surface))

proc getVersion*(wl_surface: ptr WlSurface): uint32 {.inline, importc: "wl_surface_get_version".} =
  return get_version(cast[ptr WlProxy](wl_surface))

proc destroy*(wl_surface: ptr WlSurface) {.inline, importc: "wl_surface_destroy".} =
  marshal_flags(cast[ptr WlProxy](wl_surface), WL_SURFACE_DESTROY, nil, get_version(cast[ptr WlProxy](wl_surface)), WL_MARSHAL_FLAG_DESTROY)

proc attach*(wl_surface: ptr WlSurface; buffer: ptr WlBuffer; x, y: int32) {.inline, importc: "wl_surface_attach".} =
  marshal_flags(cast[ptr WlProxy](wl_surface), WL_SURFACE_ATTACH, nil, get_version(cast[ptr WlProxy](wl_surface)), 0, buffer, x, y)

proc damage*(wl_surface: ptr WlSurface; x, y: int32; width, height: int32) {.inline, importc: "wl_surface_damage".} =
  marshal_flags(cast[ptr WlProxy](wl_surface), WL_SURFACE_DAMAGE, nil, get_version(cast[ptr WlProxy](wl_surface)), 0, x, y, width, height)

proc frame*(wl_surface: ptr WlSurface): ptr WlCallback {.inline, importc: "wl_surface_frame".} =
  var callback: ptr WlProxy
  callback = marshal_flags(cast[ptr WlProxy](wl_surface), WL_SURFACE_FRAME, addr(wl_callback_interface), get_version(cast[ptr WlProxy](wl_surface)), 0, nil)
  return cast[ptr WlCallback](callback)

proc setOpaqueRegion*(wl_surface: ptr WlSurface; region: ptr WlRegion) {.inline, importc: "wl_surface_set_opaque_region".} =
  marshal_flags(cast[ptr WlProxy](wl_surface), WL_SURFACE_SET_OPAQUE_REGION, nil, get_version(cast[ptr WlProxy](wl_surface)), 0, region)

proc setInputRegion*(wl_surface: ptr WlSurface; region: ptr WlRegion) {.inline, importc: "wl_surface_set_input_region".} =
  marshal_flags(cast[ptr WlProxy](wl_surface), WL_SURFACE_SET_INPUT_REGION, nil, get_version(cast[ptr WlProxy](wl_surface)), 0, region)

proc commit*(wl_surface: ptr WlSurface) {.inline, importc: "wl_surface_commit".} =
  marshal_flags(cast[ptr WlProxy](wl_surface), WL_SURFACE_COMMIT, nil, get_version(cast[ptr WlProxy](wl_surface)), 0)

proc setBufferTransform*(wl_surface: ptr WlSurface; transform: int32) {.inline, importc: "wl_surface_set_buffer_transform".} =
  marshal_flags(cast[ptr WlProxy](wl_surface), WL_SURFACE_SET_BUFFER_TRANSFORM, nil, get_version(cast[ptr WlProxy](wl_surface)), 0, transform)

proc setBufferScale*(wl_surface: ptr WlSurface; scale: int32) {.inline, importc: "wl_surface_set_buffer_scale".} =
  marshal_flags(cast[ptr WlProxy](wl_surface), WL_SURFACE_SET_BUFFER_SCALE, nil, get_version(cast[ptr WlProxy](wl_surface)), 0, scale)

proc damageBuffer*(wl_surface: ptr WlSurface; x, y: int32; width, height: int32) {.inline, importc: "wl_surface_damage_buffer".} =
  marshal_flags(cast[ptr WlProxy](wl_surface), WL_SURFACE_DAMAGE_BUFFER, nil, get_version(cast[ptr WlProxy](wl_surface)), 0, x, y, width, height)

proc offset*(wl_surface: ptr WlSurface; x, y: int32) {.inline, importc: "wl_surface_offset".} =
  marshal_flags(cast[ptr WlProxy](wl_surface), WL_SURFACE_OFFSET, nil, get_version(cast[ptr WlProxy](wl_surface)), 0, x, y)

type WlSeatCapability* = enum
  WL_SEAT_CAPABILITY_POINTER = 1,
  WL_SEAT_CAPABILITY_KEYBOARD = 2,
  WL_SEAT_CAPABILITY_TOUCH = 4

type WlSeatError* = enum
  WL_SEAT_ERROR_MISSING_CAPABILITY = 0

type WlSeatListener* {.bycopy.} = object
  capabilities*: proc (data: pointer; wl_seat: ptr WlSeat; capabilities: uint32)
  name*: proc (data: pointer; wl_seat: ptr WlSeat; name: cstring)

proc addListener*(wl_seat: ptr WlSeat; listener: ptr WlSeatListener; data: pointer): cint {.inline, importc: "wl_seat_add_listener".} =
  return add_listener(cast[ptr WlProxy](wl_seat), cast[proc ()](listener), data)

const
  WL_SEAT_GET_POINTER* = 0
  WL_SEAT_GET_KEYBOARD* = 1
  WL_SEAT_GET_TOUCH* = 2
  WL_SEAT_RELEASE* = 3

const
  WL_SEAT_CAPABILITIES_SINCE_VERSION* = 1
  WL_SEAT_NAME_SINCE_VERSION* = 2
  WL_SEAT_GET_POINTER_SINCE_VERSION* = 1
  WL_SEAT_GET_KEYBOARD_SINCE_VERSION* = 1
  WL_SEAT_GET_TOUCH_SINCE_VERSION* = 1
  WL_SEAT_RELEASE_SINCE_VERSION* = 5

proc setUserData*(wl_seat: ptr WlSeat; user_data: pointer) {.inline, importc: "wl_seat_set_user_data".} =
  set_user_data(cast[ptr WlProxy](wl_seat), user_data)

proc getUserData*(wl_seat: ptr WlSeat): pointer {.inline, importc: "wl_seat_get_user_data".} =
  return get_user_data(cast[ptr WlProxy](wl_seat))

proc getVersion*(wl_seat: ptr WlSeat): uint32 {.inline, importc: "wl_seat_get_version".} =
  return get_version(cast[ptr WlProxy](wl_seat))

proc destroy*(wl_seat: ptr WlSeat) {.inline, importc: "wl_seat_destroy".} =
  destroy(cast[ptr WlProxy](wl_seat))

proc getPointer*(wl_seat: ptr WlSeat): ptr WlPointer {.inline, importc: "wl_seat_get_pointer".} =
  var id: ptr WlProxy
  id = marshal_flags(cast[ptr WlProxy](wl_seat), WL_SEAT_GET_POINTER, addr(wl_pointer_interface), get_version(cast[ptr WlProxy](wl_seat)), 0, nil)
  return cast[ptr WlPointer](id)

proc getKeyboard*(wl_seat: ptr WlSeat): ptr WlKeyboard {.inline, importc: "wl_seat_get_keyboard".} =
  var id: ptr WlProxy
  id = marshal_flags(cast[ptr WlProxy](wl_seat), WL_SEAT_GET_KEYBOARD, addr(wl_keyboard_interface), get_version(cast[ptr WlProxy](wl_seat)), 0, nil)
  return cast[ptr WlKeyboard](id)

proc getTouch*(wl_seat: ptr WlSeat): ptr WlTouch {.inline, importc: "wl_seat_get_touch".} =
  var id: ptr WlProxy
  id = marshal_flags(cast[ptr WlProxy](wl_seat), WL_SEAT_GET_TOUCH, addr(wl_touch_interface), get_version(cast[ptr WlProxy](wl_seat)), 0, nil)
  return cast[ptr WlTouch](id)

proc release*(wl_seat: ptr WlSeat) {.inline, importc: "wl_seat_release".} =
  marshal_flags(cast[ptr WlProxy](wl_seat), WL_SEAT_RELEASE, nil, get_version(cast[ptr WlProxy](wl_seat)), WL_MARSHAL_FLAG_DESTROY)

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

type WlPointerListener* {.bycopy.} = object
  enter*: proc (data: pointer; wl_pointer: ptr WlPointer; serial: uint32; surface: ptr WlSurface; surface_x, surface_y: WlFixed)
  leave*: proc (data: pointer; wl_pointer: ptr WlPointer; serial: uint32; surface: ptr WlSurface)
  motion*: proc (data: pointer; wl_pointer: ptr WlPointer; time: uint32; surface_x, surface_y: WlFixed)
  button*: proc (data: pointer; wl_pointer: ptr WlPointer; serial: uint32; time: uint32; button: uint32; state: uint32)
  axis*: proc (data: pointer; wl_pointer: ptr WlPointer; time: uint32; axis: uint32; value: WlFixed)
  frame*: proc (data: pointer; wl_pointer: ptr WlPointer)
  axis_source*: proc (data: pointer; wl_pointer: ptr WlPointer; axis_source: uint32)
  axis_stop*: proc (data: pointer; wl_pointer: ptr WlPointer; time: uint32; axis: uint32)
  axis_discrete*: proc (data: pointer; wl_pointer: ptr WlPointer; axis: uint32; discrete: int32)

proc addListener*(wl_pointer: ptr WlPointer; listener: ptr WlPointerListener; data: pointer): cint {.inline, importc: "wl_pointer_add_listener".} =
  return add_listener(cast[ptr WlProxy](wl_pointer), cast[proc ()](listener), data)

const
  WL_POINTER_SET_CURSOR* = 0
  WL_POINTER_RELEASE* = 1

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

proc setUserData*(wl_pointer: ptr WlPointer; user_data: pointer) {.inline, importc: "wl_pointer_set_user_data".} =
  set_user_data(cast[ptr WlProxy](wl_pointer), user_data)

proc getUserData*(wl_pointer: ptr WlPointer): pointer {.inline, importc: "wl_pointer_get_user_data".} =
  return get_user_data(cast[ptr WlProxy](wl_pointer))

proc getVersion*(wl_pointer: ptr WlPointer): uint32 {.inline, importc: "wl_pointer_get_version".} =
  return get_version(cast[ptr WlProxy](wl_pointer))

proc destroy*(wl_pointer: ptr WlPointer) {.inline, importc: "wl_pointer_destroy".} =
  destroy(cast[ptr WlProxy](wl_pointer))

proc setCursor*(wl_pointer: ptr WlPointer; serial: uint32; surface: ptr WlSurface; hotspot_x, hotspot_y: int32) {.inline, importc: "wl_pointer_set_cursor".} =
  marshal_flags(cast[ptr WlProxy](wl_pointer), WL_POINTER_SET_CURSOR, nil, get_version(cast[ptr WlProxy](wl_pointer)), 0, serial, surface, hotspot_x, hotspot_y)

proc release*(wl_pointer: ptr WlPointer) {.inline, importc: "wl_pointer_release".} =
  marshal_flags(cast[ptr WlProxy](wl_pointer), WL_POINTER_RELEASE, nil, get_version(cast[ptr WlProxy](wl_pointer)), WL_MARSHAL_FLAG_DESTROY)

type WlKeyboardKeymapFormat* = enum
  WL_KEYBOARD_KEYMAP_FORMAT_NO_KEYMAP = 0,
  WL_KEYBOARD_KEYMAP_FORMAT_XKB_V1 = 1

type WlKeyboardKeyState* = enum
  WL_KEYBOARD_KEY_STATE_RELEASED = 0,
  WL_KEYBOARD_KEY_STATE_PRESSED = 1

type WlKeyboardListener* {.bycopy.} = object
  keymap*: proc (data: pointer; wl_keyboard: ptr WlKeyboard; format: uint32; fd: int32; size: uint32)
  enter*: proc (data: pointer; wl_keyboard: ptr WlKeyboard; serial: uint32; surface: ptr WlSurface; keys: ptr WlArray)
  leave*: proc (data: pointer; wl_keyboard: ptr WlKeyboard; serial: uint32; surface: ptr WlSurface)
  key*: proc (data: pointer; wl_keyboard: ptr WlKeyboard; serial: uint32; time: uint32; key: uint32; state: uint32)
  modifiers*: proc (data: pointer; wl_keyboard: ptr WlKeyboard; serial: uint32; mods_depressed: uint32; mods_latched: uint32; mods_locked: uint32; group: uint32)
  repeat_info*: proc (data: pointer; wl_keyboard: ptr WlKeyboard; rate: int32; delay: int32)

proc addListener*(wl_keyboard: ptr WlKeyboard; listener: ptr WlKeyboardListener; data: pointer): cint {.inline, importc: "wl_keyboard_add_listener".} =
  return add_listener(cast[ptr WlProxy](wl_keyboard), cast[proc ()](listener), data)

const
  WL_KEYBOARD_RELEASE* = 0
  WL_KEYBOARD_KEYMAP_SINCE_VERSION* = 1
  WL_KEYBOARD_ENTER_SINCE_VERSION* = 1
  WL_KEYBOARD_LEAVE_SINCE_VERSION* = 1
  WL_KEYBOARD_KEY_SINCE_VERSION* = 1
  WL_KEYBOARD_MODIFIERS_SINCE_VERSION* = 1
  WL_KEYBOARD_REPEAT_INFO_SINCE_VERSION* = 4
  WL_KEYBOARD_RELEASE_SINCE_VERSION* = 3

proc setUserData*(wl_keyboard: ptr WlKeyboard; user_data: pointer) {.inline, importc: "wl_keyboard_set_user_data".} =
  set_user_data(cast[ptr WlProxy](wl_keyboard), user_data)

proc getUserData*(wl_keyboard: ptr WlKeyboard): pointer {.inline, importc: "wl_keyboard_get_user_data".} =
  return get_user_data(cast[ptr WlProxy](wl_keyboard))

proc getVersion*(wl_keyboard: ptr WlKeyboard): uint32 {.inline, importc: "wl_keyboard_get_version".} =
  return get_version(cast[ptr WlProxy](wl_keyboard))

proc destroy*(wl_keyboard: ptr WlKeyboard) {.inline, importc: "wl_keyboard_destroy".} =
  destroy(cast[ptr WlProxy](wl_keyboard))

proc release*(wl_keyboard: ptr WlKeyboard) {.inline, importc: "wl_keyboard_release".} =
  marshal_flags(cast[ptr WlProxy](wl_keyboard), WL_KEYBOARD_RELEASE, nil, get_version(cast[ptr WlProxy](wl_keyboard)), WL_MARSHAL_FLAG_DESTROY)

type WlTouchListener* {.bycopy.} = object
  down*: proc (data: pointer; wl_touch: ptr WlTouch; serial: uint32; time: uint32; surface: ptr WlSurface; id: int32; x, y: WlFixed)
  up*: proc (data: pointer; wl_touch: ptr WlTouch; serial: uint32; time: uint32; id: int32)
  motion*: proc (data: pointer; wl_touch: ptr WlTouch; time: uint32; id: int32; x, y: WlFixed)
  frame*: proc (data: pointer; wl_touch: ptr WlTouch)
  cancel*: proc (data: pointer; wl_touch: ptr WlTouch)
  shape*: proc (data: pointer; wl_touch: ptr WlTouch; id: int32; major, minor: WlFixed)
  orientation*: proc (data: pointer; wl_touch: ptr WlTouch; id: int32; orientation: WlFixed)

proc addListener*(wl_touch: ptr WlTouch; listener: ptr WlTouchListener; data: pointer): cint {.inline, importc: "wl_touch_add_listener".} =
  return add_listener(cast[ptr WlProxy](wl_touch), cast[proc ()](listener), data)

const
  WL_TOUCH_RELEASE* = 0
  WL_TOUCH_DOWN_SINCE_VERSION* = 1
  WL_TOUCH_UP_SINCE_VERSION* = 1
  WL_TOUCH_MOTION_SINCE_VERSION* = 1
  WL_TOUCH_FRAME_SINCE_VERSION* = 1
  WL_TOUCH_CANCEL_SINCE_VERSION* = 1
  WL_TOUCH_SHAPE_SINCE_VERSION* = 6
  WL_TOUCH_ORIENTATION_SINCE_VERSION* = 6
  WL_TOUCH_RELEASE_SINCE_VERSION* = 3

proc setUserData*(wl_touch: ptr WlTouch; user_data: pointer) {.inline, importc: "wl_touch_set_user_data".} =
  set_user_data(cast[ptr WlProxy](wl_touch), user_data)

proc getUserData*(wl_touch: ptr WlTouch): pointer {.inline, importc: "wl_touch_get_user_data".} =
  return get_user_data(cast[ptr WlProxy](wl_touch))

proc getVersion*(wl_touch: ptr WlTouch): uint32 {.inline, importc: "wl_touch_get_version".} =
  return get_version(cast[ptr WlProxy](wl_touch))

proc destroy*(wl_touch: ptr WlTouch) {.inline, importc: "wl_touch_destroy".} =
  destroy(cast[ptr WlProxy](wl_touch))

proc release*(wl_touch: ptr WlTouch) {.inline, importc: "wl_touch_release".} =
  marshal_flags(cast[ptr WlProxy](wl_touch), WL_TOUCH_RELEASE, nil, get_version(cast[ptr WlProxy](wl_touch)), WL_MARSHAL_FLAG_DESTROY)

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

type WlOutputListener* {.bycopy.} = object
  geometry*: proc (data: pointer; wl_output: ptr WlOutput; x, y: int32; physical_width, physical_height: int32; subpixel: int32; make: cstring; model: cstring; transform: int32)
  mode*: proc (data: pointer; wl_output: ptr WlOutput; flags: uint32; width, height: int32; refresh: int32)
  done*: proc (data: pointer; wl_output: ptr WlOutput)
  scale*: proc (data: pointer; wl_output: ptr WlOutput; factor: int32)
  name*: proc (data: pointer; wl_output: ptr WlOutput; name: cstring)
  description*: proc (data: pointer; wl_output: ptr WlOutput; description: cstring)

proc addListener*(wl_output: ptr WlOutput; listener: ptr WlOutput_listener; data: pointer): cint {.inline, importc: "wl_output_add_listener".} =
  return add_listener(cast[ptr WlProxy](wl_output), cast[proc ()](listener), data)

const
  WL_OUTPUT_RELEASE* = 0
  WL_OUTPUT_GEOMETRY_SINCE_VERSION* = 1
  WL_OUTPUT_MODE_SINCE_VERSION* = 1
  WL_OUTPUT_DONE_SINCE_VERSION* = 2
  WL_OUTPUT_SCALE_SINCE_VERSION* = 2
  WL_OUTPUT_NAME_SINCE_VERSION* = 4
  WL_OUTPUT_DESCRIPTION_SINCE_VERSION* = 4
  WL_OUTPUT_RELEASE_SINCE_VERSION* = 3

proc setUserData*(wl_output: ptr WlOutput; user_data: pointer) {.inline, importc: "wl_output_set_user_data".} =
  set_user_data(cast[ptr WlProxy](wl_output), user_data)

proc getUserData*(wl_output: ptr WlOutput): pointer {.inline, importc: "wl_output_get_user_data".} =
  return get_user_data(cast[ptr WlProxy](wl_output))

proc getVersion*(wl_output: ptr WlOutput): uint32 {.inline, importc: "wl_output_get_version".} =
  return get_version(cast[ptr WlProxy](wl_output))

proc destroy*(wl_output: ptr WlOutput) {.inline, importc: "wl_output_destroy".} =
  destroy(cast[ptr WlProxy](wl_output))

proc release*(wl_output: ptr WlOutput) {.inline, importc: "wl_output_release".} =
  marshal_flags(cast[ptr WlProxy](wl_output), WL_OUTPUT_RELEASE, nil, get_version(cast[ptr WlProxy](wl_output)), WL_MARSHAL_FLAG_DESTROY)

const
  WL_REGION_DESTROY* = 0
  WL_REGION_ADD* = 1
  WL_REGION_SUBTRACT* = 2

const
  WL_REGION_DESTROY_SINCE_VERSION* = 1
  WL_REGION_ADD_SINCE_VERSION* = 1
  WL_REGION_SUBTRACT_SINCE_VERSION* = 1

proc setUserData*(wl_region: ptr WlRegion; user_data: pointer) {.inline, importc: "wl_region_set_user_data".} =
  set_user_data(cast[ptr WlProxy](wl_region), user_data)

proc getUserData*(wl_region: ptr WlRegion): pointer {.inline, importc: "wl_region_get_user_data".} =
  return get_user_data(cast[ptr WlProxy](wl_region))

proc getVersion*(wl_region: ptr WlRegion): uint32 {.inline, importc: "wl_region_get_version".} =
  return get_version(cast[ptr WlProxy](wl_region))

proc destroy*(wl_region: ptr WlRegion) {.inline, importc: "wl_region_destroy".} =
  marshal_flags(cast[ptr WlProxy](wl_region), WL_REGION_DESTROY, nil, get_version(cast[ptr WlProxy](wl_region)), WL_MARSHAL_FLAG_DESTROY)

proc add*(wl_region: ptr WlRegion; x, y: int32; width, height: int32) {.inline, importc: "wl_region_add".} =
  marshal_flags(cast[ptr WlProxy](wl_region), WL_REGION_ADD, nil, get_version(cast[ptr WlProxy](wl_region)), 0, x, y, width, height)

proc subtract*(wl_region: ptr WlRegion; x, y: int32; width, height: int32) {.inline, importc: "wl_region_subtract".} =
  marshal_flags(cast[ptr WlProxy](wl_region), WL_REGION_SUBTRACT, nil, get_version(cast[ptr WlProxy](wl_region)), 0, x, y, width, height)

type WlSubcompositorError* = enum
  WL_SUBCOMPOSITOR_ERROR_BAD_SURFACE = 0

const
  WL_SUBCOMPOSITOR_DESTROY* = 0
  WL_SUBCOMPOSITOR_GET_SUBSURFACE* = 1
  WL_SUBCOMPOSITOR_DESTROY_SINCE_VERSION* = 1
  WL_SUBCOMPOSITOR_GET_SUBSURFACE_SINCE_VERSION* = 1

proc setUserData*(wl_subcompositor: ptr WlSubcompositor; user_data: pointer) {.inline, importc: "wl_subcompositor_set_user_data".} =
  set_user_data(cast[ptr WlProxy](wl_subcompositor), user_data)

proc getUserData*(wl_subcompositor: ptr WlSubcompositor): pointer {.inline, importc: "wl_subcompositor_get_user_data".} =
  return get_user_data(cast[ptr WlProxy](wl_subcompositor))

proc getVersion*(wl_subcompositor: ptr WlSubcompositor): uint32 {.inline, importc: "wl_subcompositor_get_version".} =
  return get_version(cast[ptr WlProxy](wl_subcompositor))

proc destroy*(wl_subcompositor: ptr WlSubcompositor) {.inline, importc: "wl_subcompositor_destroy".} =
  marshal_flags(cast[ptr WlProxy](wl_subcompositor), WL_SUBCOMPOSITOR_DESTROY, nil, get_version(cast[ptr WlProxy](wl_subcompositor)), WL_MARSHAL_FLAG_DESTROY)

proc getSubsurface*(wl_subcompositor: ptr WlSubcompositor; surface: ptr WlSurface; parent: ptr WlSurface): ptr WlSubsurface {.inline, importc: "wl_subcompositor_get_subsurface".} =
  var id: ptr WlProxy
  id = marshal_flags(cast[ptr WlProxy](wl_subcompositor), WL_SUBCOMPOSITOR_GET_SUBSURFACE, addr(wl_subsurface_interface), get_version(cast[ptr WlProxy](wl_subcompositor)), 0, nil, surface, parent)
  return cast[ptr WlSubsurface](id)

type WlSubsurfaceError* = enum
  WL_SUBSURFACE_ERROR_BAD_SURFACE = 0

const
  WL_SUBSURFACE_DESTROY* = 0
  WL_SUBSURFACE_SET_POSITION* = 1
  WL_SUBSURFACE_PLACE_ABOVE* = 2
  WL_SUBSURFACE_PLACE_BELOW* = 3
  WL_SUBSURFACE_SET_SYNC* = 4
  WL_SUBSURFACE_SET_DESYNC* = 5

const
  WL_SUBSURFACE_DESTROY_SINCE_VERSION* = 1
  WL_SUBSURFACE_SET_POSITION_SINCE_VERSION* = 1
  WL_SUBSURFACE_PLACE_ABOVE_SINCE_VERSION* = 1
  WL_SUBSURFACE_PLACE_BELOW_SINCE_VERSION* = 1
  WL_SUBSURFACE_SET_SYNC_SINCE_VERSION* = 1
  WL_SUBSURFACE_SET_DESYNC_SINCE_VERSION* = 1

proc setUserData*(wl_subsurface: ptr WlSubsurface; user_data: pointer) {.inline, importc: "wl_subsurface_set_user_data".} =
  set_user_data(cast[ptr WlProxy](wl_subsurface), user_data)

proc getUserData*(wl_subsurface: ptr WlSubsurface): pointer {.inline, importc: "wl_subsurface_get_user_data".} =
  return get_user_data(cast[ptr WlProxy](wl_subsurface))

proc getVersion*(wl_subsurface: ptr WlSubsurface): uint32 {.inline, importc: "wl_subsurface_get_version".} =
  return get_version(cast[ptr WlProxy](wl_subsurface))

proc destroy*(wl_subsurface: ptr WlSubsurface) {.inline, importc: "wl_subsurface_destroy".} =
  marshal_flags(cast[ptr WlProxy](wl_subsurface), WL_SUBSURFACE_DESTROY, nil, get_version(cast[ptr WlProxy](wl_subsurface)), WL_MARSHAL_FLAG_DESTROY)

proc setPosition*(wl_subsurface: ptr WlSubsurface; x, y: int32) {.inline, importc: "wl_subsurface_set_position".} =
  marshal_flags(cast[ptr WlProxy](wl_subsurface), WL_SUBSURFACE_SET_POSITION, nil, get_version(cast[ptr WlProxy](wl_subsurface)), 0, x, y)

proc placeAbove*(wl_subsurface: ptr WlSubsurface; sibling: ptr WlSurface) {.inline, importc: "wl_subsurface_place_above".} =
  marshal_flags(cast[ptr WlProxy](wl_subsurface), WL_SUBSURFACE_PLACE_ABOVE, nil, get_version(cast[ptr WlProxy](wl_subsurface)), 0, sibling)

proc placeBelow*(wl_subsurface: ptr WlSubsurface; sibling: ptr WlSurface) {.inline, importc: "wl_subsurface_place_below".} =
  marshal_flags(cast[ptr WlProxy](wl_subsurface), WL_SUBSURFACE_PLACE_BELOW, nil, get_version(cast[ptr WlProxy](wl_subsurface)), 0, sibling)

proc setSync*(wl_subsurface: ptr WlSubsurface) {.inline, importc: "wl_subsurface_set_sync".} =
  marshal_flags(cast[ptr WlProxy](wl_subsurface), WL_SUBSURFACE_SET_SYNC, nil, get_version(cast[ptr WlProxy](wl_subsurface)), 0)

proc setDesync*(wl_subsurface: ptr WlSubsurface) {.inline, importc: "wl_subsurface_set_desync".} =
  marshal_flags(cast[ptr WlProxy](wl_subsurface), WL_SUBSURFACE_SET_DESYNC, nil, get_version(cast[ptr WlProxy](wl_subsurface)), 0)

{.pop.}
