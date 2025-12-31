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
include ../../libpvn/src/pvn.mk
CC=$(PVN_CC)
FC=$(PVN_FC)
CPPFLAGS=-DMIMIC_LAPACK=3

CSRCS=dmc.c  \
nrm2.c       \
nrmp.c       \
parse_p.c    \
one_p.c      \
two_p.c      \
mreatp.c     \
crh_relerr.c \
laf_relerr.c \
reh_relerr.c \
rhh_relerr.c

# FSSRCS=Bf90/snrm1.f90 Bf90/snrmf.f90 Bf90/snrmI.f90 Bf90/snrmp.f90
# FDSRCS=Bf90/dnrm1.f90 Bf90/dnrmf.f90 Bf90/dnrmI.f90 Bf90/dnrmp.f90
# FQSRCS=Bf90/qnrm1.f90 Bf90/qnrmf.f90 Bf90/qnrmI.f90
# FXSRCS=Bf90/xnrmI.f90 Bf90/xnrm1.f90 Bf90/xnrmf.f90

EXES=$(CSRCS:.c=.exe)
ifeq ($(findstring flang,$(FC)),flang)
ifndef LAPACK
$(error LAPACK has to be set when using flang)
endif # !LAPACK
else # !flang
ifeq ($(findstring nvfortran,$(FC)),nvfortran)
ifndef LAPACK
$(error LAPACK has to be set when using nvfortran)
endif # !LAPACK
else # !nvfortran
EXES += Blue.exe
endif # ?nvfortran
endif # ?flang

ifdef LAPACK
CPPFLAGS += -DEXTERNAL_REFERENCE_LAPACK="\"$(LAPACK)\""
MKLFLAGS=-L$(LAPACK) -ltmglib -lrefblas
else # !LAPACK
FSRCS=dnrm2r.f90 snrm2r.f90 dlrran.f90 dlrrnd.f90 slrran.f90 slrrnd.f90
FOBJS=$(FSRCS:.f90=.o)
ifdef MKLROOT
CPPFLAGS += -I${MKLROOT}/include/intel64/lp64 -I${MKLROOT}/include
ifeq ($(OS),Darwin)
CPPFLAGS += -DUSE_SEQUENTIAL_MKL="intel_lp64"
MKLFLAGS=${MKLROOT}/lib/libmkl_intel_lp64.a ${MKLROOT}/lib/libmkl_sequential.a ${MKLROOT}/lib/libmkl_core.a
else # Linux
MKLFLAGS=-Wl,--start-group
ifeq ($(findstring gfortran,$(FC)),gfortran)
CPPFLAGS += -DUSE_SEQUENTIAL_MKL="gf_lp64"
MKLFLAGS += ${MKLROOT}/lib/libmkl_gf_lp64.a
else # !gfortran
CPPFLAGS += -DUSE_SEQUENTIAL_MKL="intel_lp64"
MKLFLAGS += ${MKLROOT}/lib/libmkl_intel_lp64.a
endif # ?gfortran
MKLFLAGS += ${MKLROOT}/lib/libmkl_sequential.a ${MKLROOT}/lib/libmkl_core.a -Wl,--end-group $(shell if [ -L /usr/lib64/libmemkind.so ]; then echo '-lmemkind'; fi)
ifeq ($(findstring ifx,$(FC)),ifx)
MKLFLAGS += ${ONEAPI_ROOT}/compiler/latest/lib/libifcoremt_pic.a
endif # ifx
endif # ?Darwin
else # !MKLROOT
$(error MKLROOT has to be set)
endif # ?MKLROOT
endif # ?LAPACK

ifdef REPROBLAS
CPPFLAGS += -DUSE_REPROBLAS="\"$(REPROBLAS)\"" -I$(REPROBLAS)/include
REPROFLAGS += -L$(REPROBLAS)/lib -lbinned -lbinnedblas -lreproblas
endif # REPROBLAS

ifdef CGIC
CPPFLAGS += -I$(CGIC)
CGICFLAGS += -L$(CGIC) -lcgic
EXES += pnrm.cgi
endif # CGIC

ifdef MARCH
CPPFLAGS += $(subst VECLEN=32,VECLEN=64,$(PVN_CPPFLAGS))
CFLAGS=$(CPPFLAGS) $(subst -xHost,-x$(MARCH),$(PVN_CFLAGS))
FCFLAGS=$(CPPFLAGS) $(subst -xHost,-x$(MARCH),$(PVN_FCFLAGS))
else # !MARCH
CPPFLAGS += $(PVN_CPPFLAGS)
CFLAGS=$(CPPFLAGS) $(PVN_CFLAGS)
FCFLAGS=$(CPPFLAGS) $(PVN_FCFLAGS)
endif # ?MARCH
CLFLAGS=$(subst PIC,PIE,$(CFLAGS))
FLFLAGS=$(subst PIC,PIE,$(FCFLAGS))
LDFLAGS=$(PVN_LDFLAGS) $(CGICFLAGS) $(REPROFLAGS) $(FOBJS) $(MKLFLAGS) $(PVN_LIBS)

.PHONY: all help clean

all: $(FOBJS) $(EXES)
	@echo "BUILT: $(FOBJS) $(EXES)"

help:
	@echo $(MAKE) "[LAPACK=...] [REPROBLAS=...] [CGIC=...] [CC=icx => MARCH=...] [all|clean|help]"

%.exe : %.c $(FOBJS) GNUmakefile
	$(CC) $(CLFLAGS) $< -o $@ $(LDFLAGS)

%.o : %.f90 GNUmakefile
	$(FC) $(FCFLAGS) $< -c -o $@

Blue.exe: Blue.F90 GNUmakefile
	$(FC) $(FLFLAGS) -o $@ Blue.F90

pnrm.cgi: pnrm.c pnrm.html GNUmakefile
	$(CC) $(CLFLAGS) $< -o $@ $(LDFLAGS)

clean:
	-$(RM) $(EXES)
	-$(RM) $(FOBJS)
	-$(RM) *.optrpt
	-$(RM) *.dSYM
