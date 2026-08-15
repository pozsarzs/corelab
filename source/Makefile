# +----------------------------------------------------------------------------+
# | ModShell v0.1 * Command-driven scriptable Modbus utility                   |
# | Copyright (C) 2023-2025 Pozsar Zsolt <pozsarzs@gmail.com>                  |
# | Makefile                                                                   |
# | Make file for source code                                                  |
# +----------------------------------------------------------------------------+

include ../Makefile.global

title1="binary files  "
title2="libraries     "
removetargetdir=0
sourcedir=$(outdir)
targetdir=$(bindir)
targetlibdir=$(libdir)
filemode=$(binmode)
majorlibversion=`echo "$(libversion)" | cut -c1`
projectdirs=corelab lhelp clprocessor clioport clmemory
plugins=`ls corelab-plugins | grep -v Makefile | grep -v Makefile.w32 | grep -v Makefile.w64 | sed s/'.pas'/''/`

all:
	@mkdir -p $(sourcedir)/
	@if [ ! $(lib) = "no" ]; then \
	  cd corelab-plugins; \
	  make; \
	  cd ..; \
	fi
	@if [ ! $(app) = "no" ]; then \
	  cd corelab; \
	  make; \
	  cd ..; \
	  cd clprocessor; \
	  make; \
	  cd ..; \
	  cd clioport; \
	  make; \
	  cd ..; \
	  cd clmemory; \
	  make; \
	  cd ..; \
	fi
	@if [ ! $(lhelp) = "no" ]; then \
	  cd lhelp; \
	  make; \
	  cd ..; \
	fi

clean:
	@for x in $(projectdirs); do \
	  cd $$x; \
	  make clean; \
	  cd ..; \
	done
	@cd corelab-plugins; \
	make clean; \
	cd ..

install:
	@echo -n "- Installing "$(title1)"["
	@$(install) -d $(targetdir)
	@for x in $(projectdirs); do \
	  if [ -f $$x/$(sourcedir)/$$x ]; \
	  then \
	    $(install) -m $(filemode) $$x/$(sourcedir)/$$x $(targetdir); \
	    echo -n "#"; \
	  fi \
	done
	@echo "]"
	@echo -n "- Installing "$(title2)"["
	@$(install) -d $(targetlibdir)
	@for x in $(plugins); do \
	  if [ -f corelab-plugins/$(sourcedir)/lib$$x.so ]; \
	  then \
	    $(install) -m $(filemode) corelab-plugins/$(sourcedir)/lib$$x.so $(targetlibdir)/lib$$x.so.$(libversion); \
	    $(ln) $(targetlibdir)/lib$$x.so.$(libversion) $(targetlibdir)/lib$$x.so.$(majorlibversion); \
	    $(ln) $(targetlibdir)/lib$$x.so.$(majorlibversion) $(targetlibdir)/lib$$x.so; \
	    echo -n "#"; \
	  fi; \
	done
	@echo "]"

uninstall:
	@echo -n "- Removing "$(title1)"["
	@for x in $(projectdirs); do \
	  $(rm) $(targetdir)/$$x; \
	  echo -n "#"; \
	done
	@if [ $(removetargetdir) -eq 1 ]; \
	then \
	  if [ -d $(targetdir) ]; then $(rmdir) $(targetdir); fi; \
	fi
	@echo "]"
	@echo -n "- Removing "$(title2)"["
	@for x in $(plugins); do \
	  $(rm) $(targetlibdir)/lib$$x.so*; \
	  echo -n "#"; \
	done
	@if [ $(removetargetdir) -eq 1 ]; \
	then \
	  if [ -d $(targetlibdir) ]; then $(rmdir) $(targetlibdir); fi; \
	fi
	@echo "]"

convert:

createhelp:
