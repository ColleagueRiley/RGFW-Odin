CC = gcc

ODIN = odin
CUSTOM_CFLAGS = 

LIBS := -w -lgdi32 -lm -lopengl32 -lwinmm -ggdb 
LIB_EXT = .dll

ifneq (,$(filter $(CC),winegcc x86_64-w64-mingw32-gcc))
    detected_OS := Windows
	LIB_EXT = .dll
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
ifeq ($(detected_OS),Windows)
	make RGFW/libRGFW$(LIB_EXT)	
	@call build-cl.bat
else
	make RGFW/libRGFW$(LIB_EXT)	
endif

debug:
	make clean
	make RGFW/libRGFW$(LIB_EXT)
	$(ODIN) run basic.odin -file
	$(ODIN) run basic-buffer.odin -file

Odin:
	git clone https://github.com/odin-lang/Odin

Odin/odin:
	make Odin
	cd Odin && make

RGFW/RGFW.o:
	$(CC) $(CUSTOM_CFLAGS) -x c -c RGFW/RGFW.h -D RGFW_OPENGL -D RGFW_BUFFER -D RGFW_IMPLEMENTATION -fPIC -o RGFW/RGFW.o

RGFW/libRGFW$(LIB_EXT):
	make RGFW/RGFW.o
	$(AR) rcs RGFW.a RGFW/RGFW.o
	mv RGFW.a RGFW/RGFW$(LIB_EXT)

clean:
	rm -f RGFW/RGFW.o RGFW/libRGFW$(LIB_EXT)
	rm -f RGFW/RGFW.lib RGFW/RGFW.obj