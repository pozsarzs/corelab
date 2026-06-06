# +----------------------------------------------------------------------------+
# | CoreLAB v0.1 - Modular Processor Simulation Framework                      |
# | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                       |
# | Makefile                                                                   |
# | Make file for source code                                                  |
# +----------------------------------------------------------------------------+

include ../../Makefile.global

outdir=../_lib/$(architecture)-$(os)
podir=../_po
project=corelab

all:
	@mkdir -p $(outdir)/
	@if [ -f $(project).lpr ]; then \
	    $(fpc) $(fpcargs) -Fu./builtin/ -Fu./core/ $(project).lpr; \
	  echo ""; \
	fi
	@if [ -f $(outdir)/$(project).rsj ]; then \
	  $(rstconv) -f po -p utf-8 -i $(outdir)/$(project).rsj -o ../../message/$(project).pot; \
	fi
	@if [ -f $(podir)/$(project).pot ]; then \
	  mv $(podir)/$(project).pot  ../message/; \
	fi

clean:

install:

uninstall:

convert:

createhelp:
