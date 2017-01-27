ifeq ($(OS), Windows_NT)
	SUFFIX=.dll
else
	UNAME := $(shell uname)
	ifeq ($(UNAME), Darwin)
		SUFFIX=.dylib
	else
		SUFFIX=.so
	endif
endif

LIBDIR=lib
LIB_SUBDIR=$(LIBDIR)/algo

SRCDIR=src
SRC_SUBDIR=$(SRCDIR)/algo

DOUBLE_VECTOR=doubleVector.c
DOUBLE_VECTOR_LIB=libdoubleVector
DOUBLE_MATRIX=doubleMatrix.c
DOUBLE_MATRIX_LIB=libdoubleMatrix

USER=$(shell whoami)
ifeq ($(USER), "root")
	PREFIX=/usr/local
else
	PREFIX=$(shell echo $$HOME)
endif

ifeq ($(USER), "root")
	DESTDIR=$(PREFIX)
else
	DESTDIR=$(PREFIX)/.luarocks
endif

LUA_VERSION=5.1
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
	mkdir -p $(CLUADIR)
	install $(LIBDIR)/init.lua $(LUADIR)
	install $(LIB_SUBDIR)/*.lua $(LUADIR)
	install $(SRC_SUBDIR)/$(DOUBLE_VECTOR_LIB)$(SUFFIX) $(CLUADIR)
	install $(SRC_SUBDIR)/$(DOUBLE_MATRIX_LIB)$(SUFFIX) $(CLUADIR)

lib: object
	$(CC) $(CFLAGS_LIB) -o $(SRC_SUBDIR)/$(DOUBLE_VECTOR_LIB)$(SUFFIX) $(SRC_SUBDIR)/$(DOUBLE_VECTOR:.c=.o)
	$(CC) $(CFLAGS_LIB) -o $(SRC_SUBDIR)/$(DOUBLE_MATRIX_LIB)$(SUFFIX) $(SRC_SUBDIR)/$(DOUBLE_MATRIX:.c=.o)

object:
	$(CC) -c -o $(SRC_SUBDIR)/$(DOUBLE_VECTOR:.c=.o) $(CFLAGS_OBJ) -lm $(SRC_SUBDIR)/$(DOUBLE_VECTOR)
	$(CC) -c -o $(SRC_SUBDIR)/$(DOUBLE_MATRIX:.c=.o) $(CFLAGS_OBJ) -lm $(SRC_SUBDIR)/$(DOUBLE_MATRIX)

clean:
	$(RM) $(RMFLAG) $(SRC_SUBDIR)/$(DOUBLE_VECTOR_LIB)$(SUFFIX) $(VECTOR:.c=.o) $(TARGET) *.dSYM
