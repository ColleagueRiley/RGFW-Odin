CC = gcc

ODIN = odin
CUSTOM_CFLAGS = 

LIBS := -w -lgdi32 -lm -lopengl32 -lwinmm -ggdb 
LIB_EXT = .lib

ifneq (,$(filter $(CC),winegcc x86_64-w64-mingw32-gcc))
    detected_OS := Windows
	LIB_EXT = .lib
else
	ifeq '$(findstring ;,$(PATH))' ';'
		detected_OS := Windows
	else
		detected_OS := $(shell uname 2>/dev/null || echo Unknown)
		detected_OS := $(patsubst CYGWIN%,Cygwin,$(detected_OS))
		detected_OS := $(patsubst MSYS%,MSYS,$(detected_OS))
		detected_OS := $(patsubst MINGW%,MSYS,$(detected_OS))
	endif
endif

ifeq ($(detected_OS),Windows)
	LIBS := -ggdb -lshell32 -lgdi32 -lopengl32 -lwinmm
	LIB_EXT = .dll
endif
ifeq ($(detected_OS),Darwin)        # Mac OS X
	LIBS := -lm -framework Foundation -framework AppKit -framework OpenGL -framework CoreVideo -w
	LIB_EXT = .a
endif
ifeq ($(detected_OS),Linux)
    LIBS := -lXrandr -lX11 -lm -lGL
	LIB_EXT = .a
endif


all:
	make RGFW/libRGFW$(LIB_EXT)
	$(ODIN) build basic.odin -file
	$(ODIN) build basic-buffer.odin -file

build-RGFW:
	make RGFW/libRGFW$(LIB_EXT)	

debug:
ifeq ($(detected_OS),Windows)
	make clean
	.\build-libs.bat
	make RGFW/libRGFW$(LIB_EXT)
	$(ODIN) run basic.odin -file
	$(ODIN) run basic-buffer.odin -file
else
	make clean
	make RGFW/libRGFW$(LIB_EXT)
	$(ODIN) run basic.odin -file
	$(ODIN) run basic-buffer.odin -file
endif

RGFW/RGFW.o:
	$(CC) $(CUSTOM_CFLAGS) RGFW/RGFW.c -c $(LIBS) -fPIC -o RGFW/RGFW.o

RGFW/libRGFW$(LIB_EXT):
ifeq ($(detected_OS),Windows)
	.\build-libs.bat
else
	make RGFW/RGFW.o
	$(AR) rcs libRGFW.a *.o
	mv libRGFW.a RGFW/RGFW.a
endif

clean:
	rm -f RGFW/RGFW.o RGFW/RGFW$(LIB_EXT)
	rm -f RGFW/RGFW.lib RGFW/RGFW.obj