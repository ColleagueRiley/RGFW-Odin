package main

import "core:fmt"
import "RGFW"
import gl "vendor:OpenGL"

running := true

icon := []u8{0xFF, 0x00, 0x00, 0xFF, 0xFF, 0x00, 0x00, 0xFF, 0xFF, 0x00, 0x00, 0xFF, 0xFF, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0x00, 0xFF, 0xFF, 0xFF, 0x00, 0xFF, 0xFF, 0x00, 0x00, 0xFF, 0xFF, 0x00, 0x00, 0xFF, 0xFF, 0x00, 0x00, 0xFF};

main :: proc() {  
    win := RGFW.createWindow("RGFW Example Window", {500, 500, 500, 500}, RGFW.ALLOW_DND | RGFW.CENTER);
    RGFW.window_makeCurrent(win);

    gl.load_up_to(3, 3, RGFW.gl_set_proc_address)

    RGFW.window_swapInterval(win, 1);
    RGFW.window_setIcon(win, raw_data(icon), {3, 3}, 4);

    gl.ClearColor(0, 0, 0, 0);

    for (running && RGFW.isPressedI(win, .Escape) == false) {   
        for (RGFW.window_checkEvent(win) != nil) {
            if (win.event.type == RGFW.windowMoved) {
                fmt.printf("window moved\n");
            }
            else if (win.event.type == RGFW.windowResized) {
                fmt.printf("window resized\n");
            }
            if (win.event.type == RGFW.quit) {
                running = false;  
                break;
            }
            if (RGFW.isPressedI(win, .Up)) {
                str := RGFW.readClipboard(nil);
                fmt.printf("Pasted : %s\n", str);
                RGFW.clipboardFree(str);
            }
            else if (RGFW.isPressedI(win, .Down)) {
                RGFW.writeClipboard("DOWN", 4);
            }
            else if (RGFW.isPressedI(win, .Space)) {
                fmt.printf("fps : %i\n", win.event.fps);
            }
            else if (RGFW.isPressedI(win, .w)) {
                RGFW.window_setMouseDefault(win);
            }
            else if (RGFW.isPressedI(win, .q)) {
                RGFW.window_showMouse(win, 0);
            }
            else if (RGFW.isPressedI(win, .t)) {
                RGFW.window_setMouse(win, raw_data(icon), {3, 3}, 4);
            }   

            if (win.event.type == RGFW.dnd) {
                for i := u32(0); i < win.event.droppedFilesCount; i += 1 {
                    fmt.printf("dropped : %s\n", win.event.droppedFiles[i]);
                }
            }
            else if (win.event.type == RGFW.jsButtonPressed) {
                fmt.printf("pressed %i\n", win.event.button);
            }
            else if (win.event.type == RGFW.jsAxisMove && !bool(win.event.button)) {
                fmt.printf("{%i, %i}\n", win.event.axis[0].x, win.event.axis[0].y);
            }
        }
        
        drawLoop(win);
    }
    
    RGFW.window_close(win);
}

drawLoop :: proc(w: ^RGFW.window) {
    RGFW.window_makeCurrent(w);

    gl.ClearColor(0.35, 0, 0.25, 255);

    gl.Clear(gl.COLOR_BUFFER_BIT);
    
    RGFW.window_swapBuffers(w); 
}