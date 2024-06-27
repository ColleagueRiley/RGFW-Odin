# RGFW-Odin
![THE RGFW Logo](https://github.com/ColleagueRiley/RGFW/blob/main/logo.png?raw=true)

## Build statuses
![workflow](https://github.com/ColleagueRiley/RGFW-Odin/actions/workflows/linux.yml/badge.svg)
![workflow windows](https://github.com/ColleagueRiley/RGFW-Odin/actions/workflows/windows.yml/badge.svg)
![workflow windows](https://github.com/ColleagueRiley/RGFW-Odin/actions/workflows/macos.yml/badge.svg)

# About
Odin bindings for RGFW, 

RGFW is a free multi-platform single-header very simple-to-use framework library for creating GUI Libraries or simple GUI programs. it is meant to be used as a very small and flexible alternative library to GLFW. 

The window backend supports XLib (UNIX), Cocoas (MacOS) and WinAPI (Windows)\
The graphics backend supports OpenGL (EGL, software, OSMesa, GLES), Vulkan, DirectX and software rendering buffers.

RGFW was designed as a backend for RSGL, but it can be used standalone or for other libraries, such as Raylib which uses it as an optional alternative backend.

This library

1) is single header and portable (written in C89 in mind)
2) is very small compared to other libraries
3) only depends on system API libraries, Winapi, X11, Cocoa
4) lets you create a window with a graphics context (OpenGL, Vulkan or DirectX) and manage the window and its events only with a few function calls 

This library does not

1) Handle any rendering for you (other than creating your graphics context)
2) do anything above the bare minimum in terms of functionality 

## building
To build the Odin binding simple run
`make build`
you can also run `make` to build and then run an example program or `make debug` to build from scratch then run an example program.

# examples
![examples](https://github.com/ColleagueRiley/RGFW/blob/main/screenshot.PNG?raw=true)

## basic 
A basic example can be found in `basic.py`, it includes a basic OpenGL example of just about all of RGFW's functionalities.

## a very simple example
```c
package main

import "core:fmt"
import "RGFW"
import gl "vendor:OpenGL"

main :: proc() {
	window := RGFW.createWindow("window", {200, 200, 200, 200}, RGFW.CENTER);
	RGFW.window_makeCurrent(window);

	gl.load_up_to(3, 3, RGFW.gl_set_proc_address)
	
	for (!RGFW.window_shouldClose(window)) {
		RGFW.window_checkEvent(window);


		gl.Clear(gl.COLOR_BUFFER_BIT)
		gl.ClearColor(0, 0, 0, 1.0)
		
		RGFW.window_swapBuffers(window);
	}


	RGFW.window_close(window);
}
```

# Contacts
- email : ColleagueRiley@gmail.com 
- discord : ColleagueRiley
- discord server : https://discord.gg/pXVNgVVbvh

# Documentation
More information about RGFW can be found on the [RGFW repo](https://RSGL.github.io/RGFW)

There is a lot of in-header-documentation, but more documentation can be found [here](https://RSGL.github.io/RGFW)

If you wish to build the documentation yourself, there is also a Doxygen file attached.


# RGFW vs GLFW
RGFW is more portable, in part because single-header library. It does not use callbacks and focuses on trying to be straightforward. RGFW tries to work with the programmer rather than forcing the programmer to work around it. It also uses far less RAM and storage than GLFW.

| Feature | RGFW | GLFW |
| --- | --- | --- |
| .o size  (avg) | 46kb  | 280kb |
| .so size (avg) | 94kb | 433kb |
| .h size | 152kb  | 256kb |
| basic demo lines | ~130  | ~160 |
| memory ussage (linux) | 47 Mib | 55.9 Mib |
| --- | --- | --- |
| fps counter | ✓  | X |
| multi-threading | ✓  | X |
| drag and drop (input) | ✓  | ✓ |
| drag and drop (output) | X | X |
| joystick input | ~ (no macos support) | ✓ |
| live window struct | ✓  | X |
| event pipeline (dynamic) | ✓  | X |
| multi-buffering | ✓  | ✓ |
| set icon based on bitmap | ✓  | ✓ |
| clipboard I/O | ✓  | ✓ |
| multi-window support | ✓  | ✓ |
| hide/show mouse | ✓  | ✓ |
| no resize window | ✓  | ✓ |
| no border window | ✓  | X |
| transparent window | ✓  | ✓ |
| key strings | ✓  | ✓ |
| custom cursors | ✓  | ✓ |
| wayland | ~ (backwards comp.)  | ✓ |
| OpenGL | ✓  | ✓ |
| Vulkan | ✓  | ✓ |
| OpenGL ES | ✓  | ✓ |
| EGL | ✓  | ✓ |
| OSMesa | ✓  | ✓ |
| Direct X | ✓  | X |