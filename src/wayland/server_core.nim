{.push dynlib: "libwlroots.so" .}

import util, version

const
  WL_EVENT_READABLE* = 0x01
  WL_EVENT_WRITABLE* = 0x02
  WL_EVENT_HANGUP* = 0x04
  WL_EVENT_ERROR* = 0x08

type
  WlEventLoopFdFunc* = proc (fd: cint; mask: uint32; data: pointer): cint
  WlEventLoopTimerFunc* = proc (data: pointer): cint
  WlEventLoopSignalFunc* = proc (signal_number: cint; data: pointer): cint
  WlEventLoopIdleFunc* = proc (data: pointer)

proc createWlEventLoop*(): ptr WlEventLoop {.importc: "wl_event_loop_create".}
proc destroy*(loop: ptr WlEventLoop) {.importc: "wl_event_loop_destroy".}
proc addFd*(loop: ptr WlEventLoop; fd: cint; mask: uint32; `func`: WlEventLoopFdFunc; data: pointer): ptr WlEventSource {.importc: "wl_event_loop_add_fd".}
proc fdUpdate*(source: ptr WlEventSource; mask: uint32): cint {.importc: "wl_event_source_fd_update".}
proc addTimer*(loop: ptr WlEventLoop; `func`: WlEventLoopTimerFunc; data: pointer): ptr WlEventSource {.importc: "wl_event_loop_add_timer".}
proc addSignal*(loop: ptr WlEventLoop; signal_number: cint; `func`: WlEventLoopSignalFunc; data: pointer): ptr WlEventSource {.importc: "wl_event_loop_add_signal".}
proc timerUpdate*(source: ptr WlEventSource; ms_delay: cint): cint {.importc: "wl_event_source_timer_update".}
proc remove*(source: ptr WlEventSource): cint {.importc: "wl_event_source_remove".}
proc check*(source: ptr WlEventSource) {.importc: "wl_event_source_check".}
proc dispatch*(loop: ptr WlEventLoop; timeout: cint): cint {.importc: "wl_event_loop_dispatch".}
proc dispatchIdle*(loop: ptr WlEventLoop) {.importc: "wl_event_loop_dispatch_idle".}
proc addIdle*(loop: ptr WlEventLoop; `func`: WlEventLoopIdleFunc; data: pointer): ptr WlEventSource {.importc: "wl_event_loop_add_idle".}
proc getFd*(loop: ptr WlEventLoop): cint {.importc: "wl_event_loop_get_fd".}

type
  WlNotifyFunc* = proc (listener: ptr WlListener; data: pointer)

proc addDestroyListener*(loop: ptr WlEventLoop; listener: ptr WlListener) {.importc: "wl_event_loop_add_destroy_listener".}
proc getDestroyListener*(loop: ptr WlEventLoop; notify: WlNotifyFunc): ptr WlListener {.importc: "wl_event_loop_get_destroy_listener".}

proc createWlDisplay*(): ptr WlDisplay {.importc: "wl_display_create".}
proc destroy*(display: ptr WlDisplay) {.importc: "wl_display_destroy".}
proc getEventLoop*(display: ptr WlDisplay): ptr WlEventLoop {.importc: "wl_display_get_event_loop".}
proc addSocket*(display: ptr WlDisplay; name: cstring): cint {.importc: "wl_display_add_socket".}
proc addSocketAuto*(display: ptr WlDisplay): cstring {.importc: "wl_display_add_socket_auto".}
proc addSocketFd*(display: ptr WlDisplay; sock_fd: cint): cint {.importc: "wl_display_add_socket_fd".}
proc terminate*(display: ptr WlDisplay) {.importc: "wl_display_terminate".}
proc run*(display: ptr WlDisplay) {.importc: "wl_display_run".}
proc flushClients*(display: ptr WlDisplay) {.importc: "wl_display_flush_clients".}
proc destroyClients*(display: ptr WlDisplay) {.importc: "wl_display_destroy_clients".}

type
  WlGlobalBindFunc* = proc (client: ptr WlClient; data: pointer; version: uint32; id: uint32)

proc getSerial*(display: ptr WlDisplay): uint32 {.importc: "wl_display_get_serial".}
proc nextSerial*(display: ptr WlDisplay): uint32 {.importc: "wl_display_next_serial".}
proc addDestroyListener*(display: ptr WlDisplay; listener: ptr WlListener) {.importc: "wl_display_add_destroy_listener".}
proc addClientCreatedListener*(display: ptr WlDisplay; listener: ptr WlListener) {.importc: "wl_display_add_client_created_listener".}
proc getDestroyListener*(display: ptr WlDisplay; notify: WlNotifyFunc): ptr WlListener {.importc: "wl_display_get_destroy_listener".}

proc createWlGlobal*(display: ptr WlDisplay; `interface`: ptr WlInterface; version: cint; data: pointer; `bind`: WlGlobalBindFunc): ptr WlGlobal {.importc: "wl_global_create".}
proc remove*(global: ptr WlGlobal) {.importc: "wl_global_remove".}
proc destroy*(global: ptr WlGlobal) {.importc: "wl_global_destroy".}

type
  WlDisplayGlobalFilterFunc* = proc (client: ptr WlClient; global: ptr WlGlobal; data: pointer): bool

proc setGlobalFilter*(display: ptr WlDisplay; filter: WlDisplayGlobalFilterFunc; data: pointer) {.importc: "wl_display_set_global_filter".}
proc getInterface*(global: ptr WlGlobal): ptr WlInterface {.importc: "wl_global_get_interface".}
proc getDisplay*(global: ptr WlGlobal): ptr WlDisplay {.importc: "wl_global_get_display".}
proc getUserData*(global: ptr WlGlobal): pointer {.importc: "wl_global_get_user_data".}
proc setUserData*(global: ptr WlGlobal; data: pointer) {.importc: "wl_global_set_user_data".}
proc createWlClient*(display: ptr WlDisplay; fd: cint): ptr WlClient {.importc: "wl_client_create".}
proc getClientList*(display: ptr WlDisplay): ptr WlList {.importc: "wl_display_get_client_list".}
proc getLink*(client: ptr WlClient): ptr WlList {.importc: "wl_client_get_link".}
proc wl_client_from_link*(link: ptr WlList): ptr WlClient {.importc: "wl_client_from_link".}

proc destroy*(client: ptr WlClient) {.importc: "wl_client_destroy".}
proc flush*(client: ptr WlClient) {.importc: "wl_client_flush".}
proc getCredentials*(client: ptr WlClient; pid: ptr pid_t; uid: ptr uid_t; gid: ptr gid_t){.importc: "wl_client_get_credentials".}
proc getFd*(client: ptr WlClient): cint {.importc: "wl_client_get_fd".}
proc addDestroyListener*(client: ptr WlClient; listener: ptr WlListener) {.importc: "wl_client_add_destroy_listener".}
proc getDestroyListener*(client: ptr WlClient; notify: WlNotifyFunc): ptr WlListener {.importc: "wl_client_get_destroy_listener".}
proc get_object*(client: ptr WlClient; id: uint32): ptr WlResource {.importc: "wl_client_get_object".}
proc postNoMemory*(client: ptr WlClient) {.importc: "wl_client_post_no_memory".}
proc postImplementationError*(client: ptr WlClient; msg: cstring) {.varargs.} {.importc: "wl_client_post_implementation_error".}
proc addResourceCreatedListener*(client: ptr WlClient; listener: ptr WlListener) {.importc: "wl_client_add_resource_created_listener".}
type WlClientForEachResourceIteratorFunc* = proc (resource: ptr WlResource; user_data: pointer): WlIteratorResult
proc forEachResource*(client: ptr WlClient; `iterator`: WlClientForEachResourceIteratorFunc; user_data: pointer) {.importc: "wl_client_for_each_resource".}

type
  WlListener* {.bycopy.} = object
    link*: WlList
    notify*: WlNotifyFunc

type
  WlSignal* {.bycopy.} = object
    listener_list*: WlList

proc init*(signal: ptr WlSignal) {.inline.} {.importc: "wl_signal_init".} =
  init(addr(signal.listener_list))
proc add*(signal: ptr WlSignal; listener: ptr WlListener) {.inline.} {.importc: "wl_signal_add".} =
  insert(signal.listener_list.prev, addr(listener.link))
proc get*(signal: ptr WlSignal; notify: WlNotifyFunc_t): ptr WlListener {.inline.} {.importc: "wl_signal_get".} =
  var l: ptr WlListener
  return nil

proc emit*(signal: ptr WlSignal; data: pointer) {.inline.} = {.importc: "wl_signal_emit".}
  var
    l: ptr WlListener
    next: ptr WlListener

type WlResourceDestroyFunc* = proc (resource: ptr WlResource)
proc postEvent*(resource: ptr WlResource; opcode: uint32) {.varargs.} {.importc: "wl_resource_post_event".}
proc postEventArray*(resource: ptr WlResource; opcode: uint32; args: ptr WlArgument) {.importc: "wl_resource_post_event_array".}
proc queueEvent*(resource: ptr WlResource; opcode: uint32) {.varargs.} {.importc: "wl_resource_queue_event".}
proc queueEventArray*(resource: ptr WlResource; opcode: uint32; args: ptr WlArgument) {.importc: "wl_resource_queue_event_array".}

proc postError*(resource: ptr WlResource; code: uint32; msg: cstring) {.varargs.} {.importc: "wl_resource_post_error".}
proc postNoMemory*(resource: ptr WlResource) {.importc: "wl_resource_post_no_memory".}
proc getDisplay*(client: ptr WlClient): ptr WlDisplay {.importc: "wl_client_get_display".}
proc createWlResource*(client: ptr WlClient; `interface`: ptr WlInterface; version: cint; id: uint32): ptr WlResource {.importc: "wl_resource_create".}
proc setImplementation*(resource: ptr WlResource; implementation: pointer; data: pointer; destroy: WlResourceDestroyFunc) {.importc: "wl_resource_set_implementation".}
proc setDispatcher*(resource: ptr WlResource; dispatcher: WlDispatcherFunc; implementation: pointer; data: pointer; destroy: WlResourceDestroyFunc) {.importc: "wl_resource_set_dispatcher".}
proc destroy*(resource: ptr WlResource) {.importc: "wl_resource_destroy".}
proc getId*(resource: ptr WlResource): uint32 {.importc: "wl_resource_get_id".}
proc getLink*(resource: ptr WlResource): ptr WlList {.importc: "wl_resource_get_link".}
proc fromLink*(resource: ptr WlList): ptr WlResource {.importc: "wl_resource_from_link".}
proc findForclient*(list: ptr WlList; client: ptr WlClient): ptr WlResource {.importc: "wl_resource_find_for_client".}
proc getClient*(resource: ptr WlResource): ptr WlClient {.importc: "wl_resource_get_client".}
proc setUserData*(resource: ptr WlResource; data: pointer) {.importc: "wl_resource_set_user_data".}
proc getUserData*(resource: ptr WlResource): pointer {.importc: "wl_resource_get_user_data".}
proc getVersion*(resource: ptr WlResource): cint {.importc: "wl_resource_get_version".}
proc setDestructor*(resource: ptr WlResource; destroy: WlResourceDestroyFunc) {.importc: "wl_resource_set_destructor".}
proc instanceOf*(resource: ptr WlResource; `interface`: ptr WlInterface; implementation: pointer): cint {.importc: "wl_resource_instance_of".}
proc getClass*(resource: ptr WlResource): cstring {.importc: "wl_resource_get_class".}
proc addDestroyListener*(resource: ptr WlResource; listener: ptr WlListener) {.importc: "wl_resource_add_destroy_listener".}
proc getDestroyListener*(resource: ptr WlResource; notify: WlNotifyFunc): ptr WlListener {.importc: "wl_resource_get_destroy_listener".}

proc getWlShmBuffer*(resource: ptr WlResource): ptr WlShmBuffer {.importc: "wl_shm_buffer_get".}
proc beginAccess*(buffer: ptr WlShmBuffer) {.importc: "wl_shm_buffer_begin_access".}
proc endAccess*(buffer: ptr WlShmBuffer) {.importc: "wl_shm_buffer_end_access".}
proc getData*(buffer: ptr WlShmBuffer): pointer {.importc: "wl_shm_buffer_get_data".}
proc getStride*(buffer: ptr WlShmBuffer): int32 {.importc: "wl_shm_buffer_get_stride".}
proc getFormat*(buffer: ptr WlShmBuffer): uint32 {.importc: "wl_shm_buffer_get_format".}
proc getWidth*(buffer: ptr WlShmBuffer): int32 {.importc: "wl_shm_buffer_get_width".}
proc getHeight*(buffer: ptr WlShmBuffer): int32 {.importc: "wl_shm_buffer_get_height".}
proc refPool*(buffer: ptr WlShmBuffer): ptr WlShmPool {.importc: "wl_shm_buffer_ref_pool".}
proc unref*(pool: ptr WlShmPool) {.importc: "wl_shm_pool_unref".}
proc initShm*(display: ptr WlDisplay): cint {.importc: "wl_display_init_shm".}
proc addShmFormat*(display: ptr WlDisplay; format: uint32): ptr uint32 {.importc: "wl_display_add_shm_format".}
proc setHandlerServer*(handler: WlLogFunc) {.importc: "wl_log_set_handler_server".}

type WlProtocolLoggerType* {.pure.} = enum
  REQUEST, EVENT

type WlProtocolLoggerMessage* {.bycopy.} = object
  resource*: ptr WlResource
  message_opcode*: cint
  message*: ptr WlMessage
  arguments_count*: cint
  arguments*: ptr WlArgument

type WlProtocolLoggerFunc* = proc (user_data: pointer; direction: WlProtocolLoggerType; message: ptr WlProtocolLoggerMessage)

proc addProtocolLogger*(display: ptr WlDisplay; a2: WlProtocolLoggerFunc; user_data: pointer): ptr WlProtocolLogger {.importc: "wl_display_add_protocol_logger".}
proc destroy*(logger: ptr WlProtocolLogger) {.importc: "wl_protocol_logger_destroy".}

{.pop.}
