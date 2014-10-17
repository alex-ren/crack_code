#
# A Simple Makefile
#

######

include \
$(PATSHOME)/share/atsmake-pre.mk

######

CFLAGS += -O2

######

LDFLAGS += 
# LDFLAGS += -lgc

######

MALLOCFLAG := -DATS_MEMALLOC_LIBC
# MALLOCFLAG := -DATS_MEMALLOC_GCBDW


######

SOURCES_SATS += \


SOURCES_DATS += \


#######

RMF = rm -rf

#######

TARGET = 01_01 01_02

all:: $(TARGET)

%: %.dats
	$(PATSCC) $(INCLUDE) $(INCLUDE_ATS) \
	    $(MALLOCFLAG) \
	    $(CFLAGS) $(LDFLAGS) -o $@ $<

clean:
	$(RMF) *_?ats.c
	$(RMF) *_?ats.o
	$(RMF) $(TARGET)






######

###### end of [Makefile] ######
