OS=$(shell uname)
ifeq ($(findstring MINGW64,$(OS)),MINGW64)
$(error MINGW64 not supported for now)
endif # ?MINGW64
MACHINE=$(shell uname -m)
ifeq ($(MACHINE),amd64)
ARCH=x86_64
else # !amd64
ifeq ($(MACHINE),aarch64)
ARCH=arm64
else # !aarch64
ARCH=$(MACHINE)
endif # ?aarch64
endif # ?amd64
RM=rm -rfv
ifndef LIBPVN
LIBPVN=../../libpvn
endif # !LIBPVN
CC=$(shell $(LIBPVN)/src/pvn.exe -C)
CFLAGS=$(shell $(LIBPVN)/src/pvn.exe -i)
ifdef MARCH
CFLAGS += $(subst -xHost,-x$(MARCH),$(shell $(LIBPVN)/src/pvn.exe -c))
else # !MARCH
CFLAGS += $(shell $(LIBPVN)/src/pvn.exe -c)
endif # ?MARCH
CLFLAGS=$(subst PIC,PIE,$(CFLAGS))
LDFLAGS=$(shell $(LIBPVN)/src/pvn.exe -l)

SRCS=dmc.c   \
nrmp.c       \
crh_relerr.c \
laf_relerr.c \
reh_relerr.c \
rhh_relerr.c
EXES=$(SRCS:.c=.exe) Blue.exe

.PHONY: all help clean

all: $(EXES)
	@echo "BUILT: $(EXES)"

help:
	@echo $(MAKE) "[CC=icx => MARCH=...] [GNU=...] [all|clean|help]"

%.exe : %.c
	$(CC) $(CPPFLAGS) $(CLFLAGS) $< -o $@ $(LDFLAGS)

Blue.exe: Blue.f90
	gfortran$(GNU) -cpp -o $@ Blue.f90

clean:
	-$(RM) *.exe
	-$(RM) *.so
	-$(RM) *.dylib
	-$(RM) *.a
	-$(RM) *.o
	-$(RM) *.optrpt
	-$(RM) *.dSYM
