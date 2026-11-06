# +----------------------------------------------------------------------------+
# | CoreLAB v0.1 - Modular Processor Simulation Framework                      |
# | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                       |
# | Makefile                                                                   |
# | Make file for source code                                                  |
# +----------------------------------------------------------------------------+

include ../../Makefile.global

project=`ls | grep -v README.md | grep -v Makefile | grep -v Makefile.w32 | grep -v Makefile.w64 | grep -v microcode`
logfile=../../build.log

all:
	@mkdir -p $(outdir)/ppu
	@$(rm) --force $(outdir)/ppu/*
	@$(rm) --force $(outdir)/*.*
	@for x in $(project); do \
	  if [ -f $$x ]; then \
	    if [ "$$x" = "cpu_8080.pas" ] || [ "$$x" = "cpu_4004.pas" ]; then \
	      $(fpc) $(fpcargs) -dNOT_A_LIBRARY_BUT_A_UNIT -FE$(outdir)/ppu $$x; \
	      $(fpc) $(fpcargs) $$x; \
	    elif [ "$$x" = "cpu_8085.pas" ] || [ "$$x" = "cpu_4040.pas" ]; then \
	      $(fpc) $(fpcargs) -dNOT_A_LIBRARY_BUT_A_UNIT -Fu$(outdir)/ppu $$x; \
	    else \
	      $(fpc) $(fpcargs) $$x; \
	    fi; \
	    $(call addtobuildlog,$$x.pas,$$?); \
	  fi; \
	done

clean:
	@$(rm) $(outdir)/ppu/*
	@if [ -d $(outdir)/ppu ]; then $(rmdir) $(outdir)/ppu; fi
	@$(rm) $(outdir)/*

install:

uninstall:

convert:

createhelp:
