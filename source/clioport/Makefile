# +----------------------------------------------------------------------------+
# | CoreLAB v0.1 - Modular Processor Simulation Framework                      |
# | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                       |
# | Makefile                                                                   |
# | Make file for source code                                                  |
# +----------------------------------------------------------------------------+

include ../../Makefile.global

project=clioport

all:
	@mkdir -p $(outdir)/
	@if [ -f $(project).lpr ]; then \
	  $(fpc) $(fpcargs) $(project).lpr; \
          $(call addtobuildlog,$(project).lpr,$$?); \
	  echo ""; \
	fi
	@mkdir -p $(podir)/
	@if ls $(outdir)/*.rsj >/dev/null 2>&1; then \
	  rm -f $(outdir)/*.po; \
	  for lrj in *.lrj; do \
	    cp "$$lrj" $(outdir)/form-"$${lrj%.lrj}.rsj"; \
	  done; \
	  for rsj in $(outdir)/*.rsj; do \
	    $(rstconv) -f po -p utf-8 -i "$$rsj" -o "$${rsj%.rsj}.po"; \
	  done; \
	  for po in $(outdir)/*.po; do \
	    msguniq "$$po" -o "$${po%.po}.unique.po"; \
	  done; \
	  msgcat --unique $(outdir)/*.unique.po -o $(podir)/$(project).pot; \
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
