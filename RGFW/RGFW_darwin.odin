package RGFW

window_src :: struct {
    display : u32,
    displayLink : rawptr,
    window : rawptr,
    dndPassed : u8,

    rSurf : rawptr, /*!< source graphics context */

    bitmap : rawptr, /* API's bitmap for storing or managing */
    image : rawptr,

    view : rawptr, /*apple viewpoint thingy*/

    jsPressed : [4][16]u8, /* if a key is currently pressed or not (per joystick) */

    joysticks[4] : i16, /* limit of 4 joysticks at a time */
    joystickCount : u16, /* the actual amount of joysticks */

    scale : area, /* window scaling */
    cursorChanged : u8, /* for steve jobs */

    winArgs : u32 /* windows args (for RGFW to check) */
    /*
        !< if dnd is enabled or on (based on window creating args)
        cursorChanged
    */
}