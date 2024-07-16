package RGFW
import x11 "vendor:x11/xlib"

window_src :: struct {
    display : ^x11.Display, /*!< source display */
    window : x11.Window, /*!< source window */
    ctx : rawptr, /*!< source graphics context */
    bitmap : ^x11.XImage,
    gc : x11.GC
}