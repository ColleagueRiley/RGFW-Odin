package RGFW

when ODIN_OS == .Windows do foreign import native "RGFW/libRGFW.dll"
when ODIN_OS == .Darwin do foreign import native "RGFW/libRGFW.dylib"
when (ODIN_OS == .Linux || ODIN_OS == .FreeBSD || ODIN_OS == .OpenBSD) do foreign import native "RGFW/libRGFW.so"

import _c "core:c"


/*! Optional arguments for making a windows */
TRANSPARENT_WINDOW ::	(1<<9) /*!< the window is transparent */
NO_BORDER	 :: (1<<3) /*!< the window doesn't have border */
NO_RESIZE	 :: (1<<4) /*!< the window cannot be resized  by the user */
ALLOW_DND     :: (1<<5) /*!< the window supports drag and drop*/
HIDE_MOUSE :: (1<<6) /*! the window should hide the mouse or not (can be toggled later on) using `window_mouseShow*/
FULLSCREEN :: (1<<8) /* the window is fullscreen by default or not */
CENTER :: (1<<10) /*! center the window on the screen */
OPENGL_SOFTWARE :: (1<<11) /*! use OpenGL software rendering */
COCOA_MOVE_TO_RESOURCE_DIR :: (1 << 12) /* (cocoa only), move to resource folder */
SCALE_TO_MONITOR :: (1 << 13) /* scale the window to the screen */

NO_GPU_RENDER :: (1<<14) /* don't render (using the GPU based API)*/
NO_CPU_RENDER :: (1<<15) /* don't render (using the CPU based buffer rendering)*/

/*! event codes */
keyPressed :: 2 /* a key has been pressed */
keyReleased :: 3 /*!< a key has been released*/
/*! key event note
the code of the key pressed is stored in
Event.keyCode
!!Keycodes defined at the bottom of the header file!!

while a string version is stored in
Event.KeyString

Event.lockState holds the current lockState
this means if CapsLock, NumLock are active or not
*/
mouseButtonPressed :: 4 /*!< a mouse button has been pressed (left,middle,right)*/
mouseButtonReleased :: 5 /*!< a mouse button has been released (left,middle,right)*/
mousePosChanged :: 6 /*!< the position of the mouse has been changed*/
/*! mouse event note
the x and y of the mouse can be found in the vector, Event.point

Event.button holds which mouse button was pressed
*/
jsButtonPressed :: 7 /*!< a joystick button was pressed */
jsButtonReleased :: 8 /*!< a joystick button was released */
jsAxisMove :: 9 /*!< an axis of a joystick was moved*/
/*! joystick event note
Event.joystick holds which joystick was altered, if any
Event.button holds which joystick button was pressed

Event.axis holds the data of all the axis
Event.axisCount says how many axis there are
*/
windowMoved :: 10 /*!< the window was moved (by the user) */
windowResized :: 11 /*!< the window was resized (by the user) */

focusIn :: 12 /*!< window is in focus now */
focusOut :: 13 /*!< window is out of focus now */

/* attribs change event note
The event data is sent straight to the window structure
with win->r.x, win->r.y, win->r.w and win->r.h
*/
quit :: 33 /*!< the user clicked the quit button*/ 
dnd :: 34 /*!< a file has been dropped into the window*/
dnd_init :: 35 /*!< the start of a dnd event, when the place where the file drop is known */
/* dnd data note
    The x and y coords of the drop are stored in the vector Event.point

    Event.droppedFilesCount holds how many files were dropped

    This is also the size of the array which stores all the dropped file string,
    Event.droppedFiles
*/

/*! mouse button codes (Event.button) */
mouseLeft :: 1 /*!< left mouse button is pressed*/
mouseMiddle :: 2 /*!< mouse-wheel-button is pressed*/
mouseRight :: 3 /*!< right mouse button is pressed*/
mouseScrollUp :: 4 /*!< mouse wheel is scrolling up*/
mouseScrollDown :: 5 /*!< mouse wheel is scrolling down*/

CAPSLOCK :: (1 << 1)
NUMLOCK :: (1 << 2)

JS_A :: 0 /* or PS X button */
JS_B :: 1 /* or PS circle button */
JS_Y :: 2 /* or PS triangle button */
JS_X :: 3 /* or PS square button */
JS_START :: 9 /* start button */
JS_SELECT :: 8 /* select button */
JS_HOME :: 10 /* home button */
JS_UP :: 13 /* dpad up */
JS_DOWN :: 14 /* dpad down*/
JS_LEFT :: 15 /* dpad left */
JS_RIGHT :: 16 /* dpad right */
JS_L1 :: 4 /* left bump */
JS_L2 :: 5 /* left trigger*/
JS_R1 :: 6 /* right bumper */
JS_R2 :: 7 /* right trigger */

vector :: struct {
    x : i32, 
    y : i32
}

rect :: struct {
    x : i32, 
    y : i32,
    w : i32,
    h : i32
}

area :: struct {
    w : i32,
    h : i32
}

monitor :: struct {
    name : cstring,  /* monitor name */
    rect : rect, /* monitor Workarea */
    scaleX : f32,
    scaleY : f32, /* monitor content scale*/
    physW : f32, 
    physH : f32
}

Event :: struct {
    keyName : cstring, /*!< key name of event */
    /*! drag and drop data */
    /* 260 max paths with a max length of 260 */
    droppedFiles : [260]cstring,
    droppedFilesCount : u32, /*!< house many files were dropped */

    type : u32, /*!< which event has been sent?*/
    point : vector, /*!< mouse x, y of event (or drop point) */
    keyCode : u32,  /*!< keycode of event 	!!Keycodes defined at the bottom of the header file!! */

    fps : u32, /*the current fps of the window [the fps is checked when events are checked]*/
    frameTime : u64, 
    frameTime2 : u64,

    inFocus : u8,  /*if the window is in focus or not*/

    lockState : u8,

    joystick : u16, /* which joystick this event applies to (if applicable to any) */

    button : u8, /*!< which mouse button has been clicked (0) left (1) middle (2) right OR which joystick button was pressed*/
    scroll : f64, /* the raw mouse scroll value */

    axisesCount : u8, /* number of axises */
    axis : [2]vector /* x, y of axises (-100 to 100) */
}; /*!< Event structure for checking/getting events */

window_src :: struct {
    
}

window ::  struct {
    src : window_src,
    //buffer : [^]u8 /* buffer for non-GPU systems (OSMesa, basic software rendering) */
    /* when rendering using BUFFER, the buffer is in the RGBA format */

    event : Event, /*!< current event */

    r : rect, /* the x, y, w and h of the struct */

    fpsCap : u32 /*!< the fps cap of the window should run at (change this var to change the fps cap, 0 :: no limit)*/
    /*[the fps is capped when events are checked]*/
}; /*!< Window structure for managing the window */

RGFW_Key :: enum{
    RGFW_KEY_NULL = 0,
    RGFW_Escape,
    RGFW_F1,
    RGFW_F2,
    RGFW_F3,
    RGFW_F4,
    RGFW_F5,
    RGFW_F6,
    RGFW_F7,
    RGFW_F8,
    RGFW_F9,
    RGFW_F10,
    RGFW_F11,
    RGFW_F12,

    RGFW_Backtick,

    RGFW_0,
    RGFW_1,
    RGFW_2,
    RGFW_3,
    RGFW_4,
    RGFW_5,
    RGFW_6,
    RGFW_7,
    RGFW_8,
    RGFW_9,

    RGFW_Minus,
    RGFW_Equals,
    RGFW_BackSpace,
    RGFW_Tab,
    RGFW_CapsLock,
    RGFW_ShiftL,
    RGFW_ControlL,
    RGFW_AltL,
    RGFW_SuperL,
    RGFW_ShiftR,
    RGFW_ControlR,
    RGFW_AltR,
    RGFW_SuperR,
    RGFW_Space,

    RGFW_a,
    RGFW_b,
    RGFW_c,
    RGFW_d,
    RGFW_e,
    RGFW_f,
    RGFW_g,
    RGFW_h,
    RGFW_i,
    RGFW_j,
    RGFW_k,
    RGFW_l,
    RGFW_m,
    RGFW_n,
    RGFW_o,
    RGFW_p,
    RGFW_q,
    RGFW_r,
    RGFW_s,
    RGFW_t,
    RGFW_u,
    RGFW_v,
    RGFW_w,
    RGFW_x,
    RGFW_y,
    RGFW_z,

    RGFW_Period,
    RGFW_Comma,
    RGFW_Slash,
    RGFW_Bracket,
    RGFW_CloseBracket,
    RGFW_Semicolon,
    RGFW_Return,
    RGFW_Quote,
    RGFW_BackSlash,

    RGFW_Up,
    RGFW_Down,
    RGFW_Left,
    RGFW_Right,

    RGFW_Delete,
    RGFW_Insert,
    RGFW_End,
    RGFW_Home,
    RGFW_PageUp,
    RGFW_PageDown,

    RGFW_Numlock,
    RGFW_KP_Slash,
    RGFW_Multiply,
    RGFW_KP_Minus,
    RGFW_KP_1,
    RGFW_KP_2,
    RGFW_KP_3,
    RGFW_KP_4,
    RGFW_KP_5,
    RGFW_KP_6,
    RGFW_KP_7,
    RGFW_KP_8,
    RGFW_KP_9,
    RGFW_KP_0,
    RGFW_KP_Period,
    RGFW_KP_Return
};

RGFW_mouseIcons :: enum  {
    RGFW_MOUSE_NORMAL = 0,
    RGFW_MOUSE_ARROW,
    RGFW_MOUSE_IBEAM,
    RGFW_MOUSE_CROSSHAIR,
    RGFW_MOUSE_POINTING_HAND,
    RGFW_MOUSE_RESIZE_EW,
    RGFW_MOUSE_RESIZE_NS,
    RGFW_MOUSE_RESIZE_NWSE,
    RGFW_MOUSE_RESIZE_NESW,
    RGFW_MOUSE_RESIZE_ALL,
    RGFW_MOUSE_NOT_ALLOWED,
};

// Thread type definition
when (ODIN_OS == .Linux || ODIN_OS == .FreeBSD || ODIN_OS == .OpenBSD || ODIN_OS == .Darwin) {
    thread :: u64
}
else {
    thread :: rawptr
}

foreign native {   
    @(link_name="RGFW_createWindow")
    createWindow :: proc(string: cstring, rect: rect, args: u16) -> ^window ---
    
    @(link_name="RGFW_window_close")
    window_close :: proc(window: ^window) ---

    @(link_name="RGFW_window_checkEvent")
    window_checkEvent :: proc(window: ^window) -> ^Event ---
    
    @(link_name="RGFW_getMonitors")
    getMonitors :: proc() -> [6]monitor ---
    
    @(link_name="RGFW_getPrimaryMonitor")
    getPrimaryMonitor :: proc() -> monitor ---
    
    @(link_name="RGFW_getScreenSize")
    getScreenSize :: proc() -> area ---
    
    @(link_name="RGFW_window_move")
    window_move :: proc(win: ^window, v: vector) ---
    
    @(link_name="RGFW_window_moveToMonitor")
    window_moveToMonitor :: proc(win: ^window, m: monitor) ---
    
    @(link_name="RGFW_window_resize")
    window_resize :: proc(win: ^window, a: area) ---
    
    @(link_name="RGFW_window_setMaxSize")
    window_setMaxSize :: proc(win: ^window, a: area) ---
    
    @(link_name="RGFW_window_maximize")
    window_maximize :: proc(win: ^window) ---
    
    @(link_name="RGFW_window_minimize")
    window_minimize :: proc(win: ^window) ---
    
    @(link_name="RGFW_window_restore")
    window_restore :: proc(win: ^window) ---
    
    @(link_name="RGFW_window_setName")
    window_setName :: proc(win: ^window, name: cstring) ---
    
    @(link_name="RGFW_window_setIcon")
    window_setIcon :: proc(win: ^window, icon: ^u8, a: area, channels: int) ---
    
    @(link_name="RGFW_window_setMouse")
    window_setMouse :: proc(win: ^window, image: [^]u8, a: area, channels: int) ---
    
    @(link_name="RGFW_window_setMouseStandard")
    window_setMouseStandard :: proc(win: ^window, mouse: u8) ---
    
    @(link_name="RGFW_window_setMouseDefault")
    window_setMouseDefault :: proc(win: ^window) ---
    
    @(link_name="RGFW_window_mouseHold")
    window_mouseHold :: proc(win: ^window, area: area) ---
    
    @(link_name="RGFW_window_mouseUnhold")
    window_mouseUnhold :: proc(win: ^window) ---
    
    @(link_name="RGFW_window_hide")
    window_hide :: proc(win: ^window) ---
    
    @(link_name="RGFW_window_show")
    window_show :: proc(win: ^window) ---
    
    @(link_name="RGFW_window_setShouldClose")
    window_setShouldClose :: proc(win: ^window) ---
    
    @(link_name="RGFW_getGlobalMousePoint")
    getGlobalMousePoint :: proc() -> vector ---
    
    @(link_name="RGFW_window_getMousePoint")
    window_getMousePoint :: proc(win: ^window) -> vector ---
    
    @(link_name="RGFW_window_showMouse")
    window_showMouse :: proc(win: ^window, show: int) ---
    
    @(link_name="RGFW_window_moveMouse")
    window_moveMouse :: proc(win: ^window, v: vector) ---
    
    @(link_name="RGFW_window_shouldClose")
    window_shouldClose :: proc(win: ^window) -> bool ---
    
    @(link_name="RGFW_window_isFullscreen")
    window_isFullscreen :: proc(win: ^window) -> bool ---
    
    @(link_name="RGFW_window_isHidden")
    window_isHidden :: proc(win: ^window) -> bool ---
    
    @(link_name="RGFW_window_isMinimized")
    window_isMinimized :: proc(win: ^window) -> bool ---
    
    @(link_name="RGFW_window_isMaximized")
    window_isMaximized :: proc(win: ^window) -> bool ---
    
    @(link_name="RGFW_window_scaleToMonitor")
    window_scaleToMonitor :: proc(win: ^window) ---
    
    @(link_name="RGFW_window_getMonitor")
    window_getMonitor :: proc(win: ^window) -> monitor ---
    
    @(link_name="RGFW_window_makeCurrent")
    window_makeCurrent :: proc(win: ^window) ---
    
    @(link_name="RGFW_Error")
    Error :: proc() -> bool ---
    
    @(link_name="RGFW_isPressedI")
    isPressedI :: proc(win: ^window, key: u32) -> bool ---
    
    @(link_name="RGFW_wasPressedI")
    wasPressedI :: proc(win: ^window, key: u32) -> bool ---
    
    @(link_name="RGFW_isHeldI")
    isHeldI :: proc(win: ^window, key: u32) -> bool ---
    
    @(link_name="RGFW_isReleasedI")
    isReleasedI :: proc(win: ^window, key: u32) -> bool ---
    
    @(link_name="RGFW_isMousePressed")
    isMousePressed :: proc(win: ^window, button: u8) -> bool ---
    
    @(link_name="RGFW_isMouseHeld")
    isMouseHeld :: proc(win: ^window, button: u8) -> bool ---
    
    @(link_name="RGFW_isMouseReleased")
    isMouseReleased :: proc(win: ^window, button: u8) -> bool ---
    
    @(link_name="RGFW_wasMousePressed")
    wasMousePressed :: proc(win: ^window, button: u8) -> bool ---
    
    @(link_name="RGFW_keyCodeTokeyStr")
    keyCodeTokeyStr :: proc(key: u64) -> cstring ---
    
    @(link_name="RGFW_keyStrToKeyCode")
    keyStrToKeyCode :: proc(key: cstring) -> u32 ---
    
    @(link_name="RGFW_isPressedS")
    isPressedS :: proc(win: ^window, key: cstring) -> bool ---
    
    @(link_name="RGFW_readClipboard")
    readClipboard :: proc(size: ^u32) -> cstring ---
    
    @(link_name="RGFW_writeClipboard")
    writeClipboard :: proc(text: cstring, textLen: u32) ---
    
    @(link_name="RGFW_keystrToChar")
    keystrToChar :: proc(key: cstring) -> i8 ---
    
    //@(link_name="RGFW_createThread")
    //createThread :: proc(ptr: threadFunc_ptr, args: rawptr) -> thread ---
    
    @(link_name="RGFW_cancelThread")
    cancelThread :: proc(t: thread) ---
    
    @(link_name="RGFW_joinThread")
    joinThread :: proc(t: thread) ---
    
    @(link_name="RGFW_setThreadPriority")
    setThreadPriority :: proc(t: thread, priority: u8) ---
    
    @(link_name="RGFW_registerJoystick")
    registerJoystick :: proc(win: ^window, jsNumber: i32) -> u16 ---
    
    @(link_name="RGFW_registerJoystickF")
    registerJoystickF :: proc(win: ^window, file: cstring) -> u16 ---
    
    @(link_name="RGFW_isPressedJS")
    isPressedJS :: proc(win: ^window, controller: u16, button: u8) -> u32 ---
    
    @(link_name="RGFW_getMaxGLVersion")
    getMaxGLVersion :: proc() -> [^]u8 ---
    
    @(link_name="RGFW_setGLStencil")
    setGLStencil :: proc(stencil: int) ---
    
    @(link_name="RGFW_setGLSamples")
    setGLSamples :: proc(samples: int) ---
    
    @(link_name="RGFW_setGLStereo")
    setGLStereo :: proc(stereo: int) ---
    
    @(link_name="RGFW_setGLAuxBuffers")
    setGLAuxBuffers :: proc(auxBuffers: int) ---
    
    @(link_name="RGFW_setGLVersion")
    setGLVersion :: proc(major: int, minor: int) ---
    
    @(link_name="RGFW_getProcAddress")
    getProcAddress :: proc(procname: cstring) -> rawptr ---
    
    @(link_name="RGFW_window_swapBuffers")
    window_swapBuffers :: proc(win: ^window) ---
    
    @(link_name="RGFW_window_swapInterval")
    window_swapInterval :: proc(win: ^window, swapInterval: int) ---
    
    @(link_name="RGFW_window_setGPURender")
    window_setGPURender :: proc(win: ^window, set: int) ---
    
    @(link_name="RGFW_window_checkFPS")
    window_checkFPS :: proc(win: ^window) ---
    
    @(link_name="RGFW_getTime")
    getTime :: proc() -> u64 ---
    
    @(link_name="RGFW_getTimeNS")
    getTimeNS :: proc() -> u64 ---
    
    @(link_name="RGFW_sleep")
    sleep :: proc(microseconds: u64) ---
}

/* sourced from https://github.com/odin-lang/Odin/blob/master/vendor/glfw/wrapper.odin */
gl_set_proc_address :: proc(p: rawptr, name: cstring) {
	(^rawptr)(p)^ = getProcAddress(name)
}