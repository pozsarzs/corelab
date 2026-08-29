# +----------------------------------------------------------------------------+
# | CoreLAB v0.1 - Modular Processor Simulation Framework                      |
# | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                       |
# | Makefile                                                                   |
# | Make file for source code                                                  |
# +----------------------------------------------------------------------------+

include ../../Makefile.global

project=lhelp

all:
	@mkdir -p $(outdir)/
	@if [ -f $(project).lpr ]; then \
	  $(fpc) $(fpcargs) $(project).lpr; \
          $(call addtobuildlog,$(project).lpr,$$?); \
	  echo ""; \
	fi

clean:
	@$(rm) $(outdir)/*

install:

uninstall:

convert:

createhelp:
