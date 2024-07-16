package RGFW

window_src :: struct {
    display : u32,
    displayLink : rawptr,
    window : rawptr,
    dndPassed : b8,
    ctx : rawptr, /*!< source graphics context */
    view : rawptr, /*apple viewpoint thingy*/

    bitmap : rawptr, /* API's bitmap for storing or managing */
    image : rawptr
}