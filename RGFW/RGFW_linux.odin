package RGFW
import x11 "vendor:x11/xlib"

window_src :: struct {
    display : ^x11.Display, /*!< source display */
    window : x11.Window, /*!< source window */
    rSurf : rawptr, /*!< source graphics context (GLXContext) */

    bitmap : ^x11.XImage,
    gc : x11.GC,

    jsPressed : [4][16]u8, /* if a key is currently pressed or not (per joystick) */

    joysticks : [4]i32, /* limit of 4 joysticks at a time */
    joystickCount : u16, /* the actual amount of joysticks */

    scale : area, /* window scaling */

    winArgs : u32 /* windows args (for RGFW to check) */
    /*
        !< if dnd is enabled or on (based on window creating args)
        cursorChanged
    */
}