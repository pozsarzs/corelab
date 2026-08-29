# +----------------------------------------------------------------------------+
# | CoreLAB v0.1 - Modular Processor Simulation Framework                      |
# | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                       |
# | Makefile                                                                   |
# | Make file for source code                                                  |
# +----------------------------------------------------------------------------+

include ../../Makefile.global

project=clprocessor
logfile=../../build.log

all:
	@mkdir -p $(outdir)/
	@if [ -f $(project).lpr ]; then \
	  $(fpc) $(fpcargs) -dNOT_A_LIBRARY_BUT_A_UNIT $(project).lpr; \
          $(call addtobuildlog,$(project).lpr,$$?); \
	  echo ""; \
	fi
	@mkdir -p $(podir)/
	@if ls $(outdir)/*.rsj >/dev/null 2>&1; then \
	  rm -f $(outdir)/*.po; \
	  for rsj in $(outdir)/*.rsj; do \
	    $(rstconv) -f po -p utf-8 -i "$$rsj" -o "$${rsj%.rsj}.po"; \
	  done; \
	  msgcat $(outdir)/*.po -o $(podir)/$(project).pot; \
	  rm -f $(outdir)/*.po; \
	fi
	@if [ -f $(podir)/$(project).pot ]; then \
	  cp $(podir)/$(project).pot  ../../message/; \
	fi

clean:
	@$(rm) $(outdir)/*
	@$(rm) $(podir)/*

install:

uninstall:

convert:

createhelp:
