# +----------------------------------------------------------------------------+
# | ModShell v0.1 * Command-driven scriptable Modbus utility                   |
# | Copyright (C) 2023-2025 Pozsar Zsolt <pozsarzs@gmail.com>                  |
# | Makefile                                                                   |
# | Make file for source code                                                  |
# +----------------------------------------------------------------------------+

include ../Makefile.global

title="binary files  "
removetargetdir=0
sourcedir=_lib/$(architecture)-$(os)
targetdir=$(bindir)
targetlibdir=$(libdir)
filemode=$(binmode)
projectdirs=corelab lhelp
plugins=`ls corelab-plugins | grep -v Makefile | grep -v Makefile.w64`

all:
	@mkdir -p $(sourcedir)/
	@if [ ! $(app) = "no" ]; then \
	  cd corelab; \
	  make; \
	  cd ..; \
	  fi;
	@if [ ! $(lib) = "no" ]; then \
	  cd corelab-plugins; \
	  make; \
	  cd ..; \
	  fi;
	@if [ ! $(lhelp) = "no" ]; then \
	  cd lhelp; \
	  make; \
	  cd ..; \
	  fi;

clean:
	@$(rm) $(sourcedir)/*

install:
	@echo -n "- Installing "$(title)"["
	@$(install) -d $(targetdir)
	@for x in $(projectdirs); do \
	  if [ -f $(sourcedir)/$$x ]; \
	  then \
	    $(install) -m $(filemode) $(sourcedir)/$$x $(targetdir); \
	    echo -n "#"; \
	  fi \
	done
	@$(install) -d $(targetlibdir)
	@for x in $(plugins); do \
	  if [ -f $(sourcedir)/lib$$x.so ]; \
	  then \
	    $(install) -m $(filemode) $(sourcedir)/lib$$x.so $(targetlibdir); \
	    echo -n "#"; \
	  fi; \
	done
	@echo "]"

uninstall:
	@echo -n "- Removing "$(title)"["
	@for x in $(projectdirs); do \
	  $(rm) $(targetdir)/$$x; \
	  echo -n "#"; \
	done
	@if [ $(removetargetdir) -eq 1 ]; \
	then \
	  if [ -d $(targetdir) ]; then $(rmdir) $(targetdir); fi; \
	fi
	@for x in $(plugins); do \
	  $(rm) $(targetlibdir)/lib$$x.so; \
	  echo -n "#"; \
	done
	@if [ $(removetargetdir) -eq 1 ]; \
	then \
	  if [ -d $(targetlibdir) ]; then $(rmdir) $(targetlibdir); fi; \
	fi
	@echo "]"

convert:

createhelp:
