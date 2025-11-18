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
LIBPVN=$(realpath ../../libpvn)
endif # !LIBPVN
CC=$(shell $(LIBPVN)/src/pvn.exe -C)
FC=$(shell $(LIBPVN)/src/pvn.exe -F)
CFLAGS=-DPVN_LAPACK=1
FCFLAGS=$(shell $(LIBPVN)/src/pvn.exe -f)
ifdef MARCH
CFLAGS += $(subst VECLEN=32,VECLEN=64,$(shell $(LIBPVN)/src/pvn.exe -i)) $(subst -xHost,-x$(MARCH),$(shell $(LIBPVN)/src/pvn.exe -c))
FCFLAGS += $(subst VECLEN=32,VECLEN=64,$(shell $(LIBPVN)/src/pvn.exe -i)) $(subst -xHost,-x$(MARCH),$(shell $(LIBPVN)/src/pvn.exe -f))
else # !MARCH
CFLAGS += $(shell $(LIBPVN)/src/pvn.exe -i) $(shell $(LIBPVN)/src/pvn.exe -c)
FCFLAGS += $(shell $(LIBPVN)/src/pvn.exe -i) $(shell $(LIBPVN)/src/pvn.exe -f)
endif # ?MARCH
CLFLAGS=$(subst PIC,PIE,$(CFLAGS))
FLFLAGS=$(subst PIC,PIE,$(FCFLAGS))
LDFLAGS=$(shell $(LIBPVN)/src/pvn.exe -L) -L$(LAPACK) -ltmglib -lrefblas $(shell $(LIBPVN)/src/pvn.exe -l)

SRCS=dmc.c   \
nrm2.c       \
nrmp.c       \
parse_p.c    \
one_p.c      \
two_p.c      \
crh_relerr.c \
laf_relerr.c \
reh_relerr.c \
rhh_relerr.c
FSSRCS=Hf90/snrm1.f90 Hf90/snrmf.f90 Hf90/snrmI.f90 Hf90/snrmp.f90
FDSRCS=Hf90/dnrm1.f90 Hf90/dnrmf.f90 Hf90/dnrmI.f90 Hf90/dnrmp.f90
FQSRCS=Hf90/qnrm1.f90 Hf90/qnrmf.f90 Hf90/qnrmI.f90
FXSRCS=Hf90/xnrmI.f90 Hf90/xnrm1.f90 Hf90/xnrmf.f90
ifeq ($(findstring ifx,$(FC)),ifx)
FSRCS=$(FSSRCS) $(FDSRCS) $(FQSRCS)
endif # ifx
ifeq ($(findstring gfortran,$(FC)),gfortran)
FSRCS=$(FSSRCS) $(FDSRCS) $(FQSRCS)
ifeq ($(ARCH),x86_64)
FSRCS += $(FXSRCS)
endif # x86_64
endif # gfortran
EXES=$(SRCS:.c=.exe)
ifdef FSRCS
FOBJS=$(FSRCS:.f90=.o)
EXES += Blue.exe
endif # FSRCS

.PHONY: all help clean

all: $(EXES) $(FOBJS)
	@echo "BUILT: $(EXES) $(FOBJS)"

help:
	@echo $(MAKE) "LAPACK=... [CC=icx => MARCH=...] [all|clean|help]"

%.exe : %.c GNUmakefile
	$(CC) $(CLFLAGS) $< -o $@ $(LDFLAGS)

Hf90/%.o : Hf90/%.f90 GNUmakefile
	$(FC) $(FCFLAGS) $< -c -o $@

Blue.exe: Blue.F90 GNUmakefile
	$(FC) $(FLFLAGS) -o $@ Blue.F90

clean:
	-$(RM) $(FOBJS) $(EXES)
	-$(RM) *.optrpt
	-$(RM) *.dSYM
