package main

import "core:fmt"
import RGFW "RGFW"
import gl "vendor:OpenGL"
import "core:mem"

screenSize : RGFW.area

drawRect :: proc(win : ^RGFW.window, r : RGFW.rect, color: ^[3]u8) {
    for x := r.x; x < (r.x + r.w); x += 1 {
        for y := r.y; y < (r.y + r.h); y += 1 {
            index := y * (4 * screenSize.w) + x * 4;
            
            mem.copy(&win.buffer[index], &color[0], 3 * size_of(u8));
        }
    }
}

main :: proc() {  
    win := RGFW.createWindow("RGFW Example Window", {500, 500, 500, 500}, RGFW.ALLOW_DND | RGFW.CENTER);
    RGFW.window_makeCurrent(win);
    
    RGFW.window_setCPURender(win, 1)
    RGFW.window_setGPURender(win, 0)

    screenSize = RGFW.getScreenSize()

    for (RGFW.window_shouldClose(win) == false) {   
        for (RGFW.window_checkEvent(win) != nil) {
            if (win.event.type == RGFW.quit) {
                break;
            }
        }
        
        if (win.event.type == RGFW.quit) {
            break;
        }
        

        RGFW.window_setGPURender(win, 0);
        
        color1 : [3]u8 = {0, 0, 255}
        drawRect(win, {0, 0, win.r.w, win.r.h}, &color1)

        color2 : [3]u8 = {255, 0, 0}
        drawRect(win, {200, 200, 200, 200}, &color2)
        
        RGFW.window_swapBuffers(win); 
    }
    
    RGFW.window_close(win);
}