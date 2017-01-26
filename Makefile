ifeq ($(OS), Windows_NT)
	LIB=libdoubleVector.dll
else
	UNAME := $(shell uname)
	ifeq ($(UNAME), Darwin)
		LIB=libdoubleVector.dylib
	else
		LIB=libdoubleVector.so
	endif
endif

MACOSX_DEPLOYMENT_TARGET=10.10
LUA_VERSION=5.1

LIBDIR=lib
LIB_SUBDIR=$(LIBDIR)/algo

SRCDIR=src
INCLUDE=$(SRCDIR)
SRC_SUBDIR=$(SRCDIR)/algo
SOURCE=$(SRC_SUBDIR)/doubleVector.c

HOME=$(shell echo $$HOME)
DESTDIR=$(HOME)/.luarocks
CLUADIR ?= $(DESTDIR)/lib/lua/$(LUA_VERSION)
LUADIR ?= $(DESTDIR)/share/lua/$(LUA_VERSION)/algo

CC=gcc
CFLAGS_OBJ=-fPIC -std=c11
CFLAGS_LIB=-shared
RM=rm
RMFLAG=-rf

all: install

install: lib
	mkdir -p $(LUADIR)
	install $(LIBDIR)/init.lua $(LUADIR)
	install $(LIB_SUBDIR)/*.lua $(LUADIR)
	install $(SRC_SUBDIR)/$(LIB) $(CLUADIR)

lib: object
	$(CC) $(CFLAGS_LIB) -o $(SRC_SUBDIR)/$(LIB) $(SOURCE:.c=.o) -I $(INCLUDE)

object:
	$(CC) -c -o $(SOURCE:.c=.o) $(CFLAGS_OBJ) $(SOURCE)

clean:
	$(RM) $(RMFLAG) $(SRC_SUBDIR)/$(LIB) $(VECTOR:.c=.o) $(TARGET) *.dSYM
