package RGFW

when ODIN_OS == .Windows do foreign import native "RGFW/libRGFW.dll"
when ODIN_OS == .Darwin do foreign import native "RGFW/libRGFW.dylib"
when (ODIN_OS == .Linux || ODIN_OS == .FreeBSD || ODIN_OS == .OpenBSD) do foreign import native "RGFW/libRGFW.so"

import _c "core:c"

MAX_PATH :: 260 /* max length of a path (for dnd) */
MAX_DROPS :: 260 /* max items you can drop at once */

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
    name : [128]i8,  /* monitor name */
    rect : rect, /* monitor Workarea */
    scaleX : f32,
    scaleY : f32, /* monitor content scale*/
    physW : f32, 
    physH : f32
}

Key :: enum u32 {
    KEY_NULL = 0,
    Escape,
    F1,
    F2,
    F3,
    F4,
    F5,
    F6,
    F7,
    F8,
    F9,
    F10,
    F11,
    F12,

    Backtick,

    KEY_0,
    KEY_1,
    KEY_2,
    KEY_3,
    KEY_4,
    KEY_5,
    KEY_6,
    KEY_7,
    KEY_8,
    KEY_9,

    Minus,
    Equals,
    BackSpace,
    Tab,
    CapsLock,
    ShiftL,
    ControlL,
    AltL,
    SuperL,
    ShiftR,
    ControlR,
    AltR,
    SuperR,
    Space,

    a,
    b,
    c,
    d,
    e,
    f,
    g,
    h,
    i,
    j,
    k,
    l,
    m,
    n,
    o,
    p,
    q,
    r,
    s,
    t,
    u,
    v,
    w,
    x,
    y,
    z,

    Period,
    Comma,
    Slash,
    Bracket,
    CloseBracket,
    Semicolon,
    Return,
    Quote,
    BackSlash,

    Up,
    Down,
    Left,
    Right,

    Delete,
    Insert,
    End,
    Home,
    PageUp,
    PageDown,

    Numlock,
    KP_Slash,
    Multiply,
    KP_Minus,
    KP_1,
    KP_2,
    KP_3,
    KP_4,
    KP_5,
    KP_6,
    KP_7,
    KP_8,
    KP_9,
    KP_0,
    KP_Period,
    KP_Return
};

Event :: struct {
    keyName : [16]i8, /*!< key name of event */
    /*! drag and drop data */
    /* 260 max paths with a max length of 260 */
    droppedFiles : [MAX_DROPS][MAX_PATH]i8,
    droppedFilesCount : u32, /*!< house many files were dropped */

    type : u32, /*!< which event has been sent?*/
    point : vector, /*!< mouse x, y of event (or drop point) */
    keyCode : Key,  /*!< keycode of event 	!!Keycodes defined at the bottom of the header file!! */

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

window ::  struct {
    src : window_src,
    buffer : [^]u8, /* buffer for non-GPU systems (OSMesa, basic software rendering) */
    /* when rendering using BUFFER, the buffer is in the RGBA format */

    event : Event, /*!< current event */

    r : rect, /* the x, y, w and h of the struct */

    fpsCap : u32 /*!< the fps cap of the window should run at (change this var to change the fps cap, 0 :: no limit)*/
    /*[the fps is capped when events are checked]*/
}; /*!< Window structure for managing the window */

mouseIcons :: enum u32  {
    MOUSE_NORMAL = 0,
    MOUSE_ARROW,
    MOUSE_IBEAM,
    MOUSE_CROSSHAIR,
    MOUSE_POINTING_HAND,
    MOUSE_RESIZE_EW,
    MOUSE_RESIZE_NS,
    MOUSE_RESIZE_NWSE,
    MOUSE_RESIZE_NESW,
    MOUSE_RESIZE_ALL,
    MOUSE_NOT_ALLOWED,
};

// Thread type definition
when (ODIN_OS == .Linux || ODIN_OS == .FreeBSD || ODIN_OS == .OpenBSD || ODIN_OS == .Darwin) {
    thread :: u64
}
else {
    thread :: rawptr
}

@(default_calling_convention="c", link_prefix="RGFW_")
foreign native {   
    @(link_name="RGFW_createWindow")
    createWindowSrc :: proc(string: cstring, rect: rect, args: u16) -> ^window ---
    window_close :: proc(window: ^window) ---
    window_checkEvent ::  proc "c" (window: ^window) -> ^Event ---
    getMonitors :: proc() -> [6]monitor ---
    getPrimaryMonitor :: proc() -> monitor ---
    getScreenSize :: proc() -> area ---
    window_move :: proc(win: ^window, v: vector) ---
    window_moveToMonitor :: proc(win: ^window, m: monitor) ---
    window_resize :: proc(win: ^window, a: area) ---
    window_setMaxSize :: proc(win: ^window, a: area) ---
    window_maximize :: proc(win: ^window) ---
    window_minimize :: proc(win: ^window) ---
    window_restore :: proc(win: ^window) ---
    window_setName :: proc(win: ^window, name: cstring) ---
    window_setIcon :: proc(win: ^window, icon: ^u8, a: area, channels: int) ---
    window_setMouse :: proc(win: ^window, image: [^]u8, a: area, channels: int) ---
    window_setMouseStandard :: proc(win: ^window, mouse: mouseIcons) ---
    window_setMouseDefault :: proc(win: ^window) ---
    window_mouseHold :: proc(win: ^window, area: area) ---
    window_mouseUnhold :: proc(win: ^window) ---
    window_hide :: proc(win: ^window) ---
    window_show :: proc(win: ^window) ---
    window_setShouldClose :: proc(win: ^window) ---
    getGlobalMousePoint :: proc() -> vector ---
    window_getMousePoint :: proc(win: ^window) -> vector ---
    window_showMouse :: proc(win: ^window, show: int) ---
    window_moveMouse :: proc(win: ^window, v: vector) ---
    window_shouldClose :: proc(win: ^window) -> bool ---
    window_isFullscreen :: proc(win: ^window) -> bool ---
    window_isHidden :: proc(win: ^window) -> bool ---
    window_isMinimized :: proc(win: ^window) -> bool ---
    window_isMaximized :: proc(win: ^window) -> bool ---
    window_scaleToMonitor :: proc(win: ^window) ---
    window_getMonitor :: proc(win: ^window) -> monitor ---
    window_makeCurrent :: proc(win: ^window) ---
    Error :: proc() -> bool ---
    isPressedI :: proc(win: ^window, key: Key) -> b8 ---
    wasPressedI :: proc(win: ^window, key: Key) -> bool ---
    isHeldI :: proc(win: ^window, key: Key) -> bool ---
    isReleasedI :: proc(win: ^window, key: Key) -> bool ---
    isMousePressed :: proc(win: ^window, button: u8) -> bool ---
    isMouseHeld :: proc(win: ^window, button: u8) -> bool ---
    isMouseReleased :: proc(win: ^window, button: u8) -> bool ---
    wasMousePressed :: proc(win: ^window, button: u8) -> bool ---
    keyCodeTokeyStr :: proc(key: u64) -> cstring ---
    keyStrToKeyCode :: proc(key: cstring) -> u32 ---
    isPressedS :: proc(win: ^window, key: cstring) -> bool ---
    readClipboard :: proc(size: ^u32) -> cstring ---
    clipboardFree :: proc(str: cstring)  ---
    writeClipboard :: proc(text: cstring, textLen: u32) ---
    keystrToChar :: proc(key: cstring) -> i8 ---
    //createThread :: proc(ptr: threadFunc_ptr, args: rawptr) -> thread ---
    cancelThread :: proc(t: thread) ---
    joinThread :: proc(t: thread) ---
    setThreadPriority :: proc(t: thread, priority: u8) ---
    registerJoystick :: proc(win: ^window, jsNumber: i32) -> u16 ---
    registerJoystickF :: proc(win: ^window, file: cstring) -> u16 ---
    isPressedJS :: proc(win: ^window, controller: u16, button: u8) -> u32 ---
    getMaxGLVersion :: proc() -> [^]u8 ---
    setGLStencil :: proc(stencil: int) ---
    setGLSamples :: proc(samples: int) ---
    setGLStereo :: proc(stereo: int) ---
    setGLAuxBuffers :: proc(auxBuffers: int) ---
    setGLVersion :: proc(major: int, minor: int) ---
    getProcAddress :: proc(procname: cstring) -> rawptr ---
    window_swapBuffers :: proc(win: ^window) ---
    window_swapInterval :: proc(win: ^window, swapInterval: int) ---
    window_setGPURender :: proc(win: ^window, set: int) ---
    window_setCPURender :: proc(win: ^window, set: int) ---
    window_checkFPS :: proc(win: ^window) ---
    getTime :: proc() -> u64 ---
    getTimeNS :: proc() -> u64 ---
    sleep :: proc(microseconds: u64) ---
}

createWindow :: proc(string: cstring, rect: rect, args: u16) -> ^window {
    window := createWindowSrc(string, rect, args)
    window_setCPURender(window, 0)
    return window
}

/* sourced from https://github.com/odin-lang/Odin/blob/master/vendor/glfw/wrapper.odin */
gl_set_proc_address :: proc(p: rawptr, name: cstring) {
	(^rawptr)(p)^ = getProcAddress(name)
}