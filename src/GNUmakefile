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
ifneq ($(ARCH),x86_64)
$(error non-x86_64 architectures not supported for now)
endif # !x86_64
RM=rm -rfv
ifndef LIBPVN
LIBPVN=../../libpvn
endif # !LIBPVN

CC=$(shell $(LIBPVN)/src/pvn.exe -C)
CFLAGS=$(shell $(LIBPVN)/src/pvn.exe -i) $(shell $(LIBPVN)/src/pvn.exe -c)
CLFLAGS=$(subst PIC,PIE,$(CFLAGS))
LDFLAGS=$(shell $(LIBPVN)/src/pvn.exe -l)

EXES=nrmp.exe  \
crh_relerr.exe \
laf_relerr.exe \
reh_relerr.exe \
rhh_relerr.exe \
Blue.exe

.PHONY: all help clean

all: $(EXES)
	@echo "BUILT: $(EXES)"

help:
	@echo $(MAKE) "[all|clean|help]"

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
