package RGFW
import winapi "core:sys/windows"

window_src :: struct {
    window : winapi.HWND, /*!< source window */
    HDC : winapi.HDC, /*!< source HDC */
    hOffset : u32, /*!< height offset for window */
    rSurf : winapi.HGLRC, /*!< source graphics context */

    maxSize : area, 
    minSize : area,

    bitmap : winapi.HBITMAP,
    hdcMem : winapi.HDC,

    jsPressed : [4][16] u8, /* if a key is currently pressed or not (per joystick) */

    joysticks : [4]i16, /* limit of 4 joysticks at a time */
    joystickCount : u16, /* the actual amount of joysticks */

    scale : area, /* window scaling */

    winArgs : u32 /* windows args (for RGFW to check) */
    /*
        !< if dnd is enabled or on (based on window creating args)
        cursorChanged
    */
}