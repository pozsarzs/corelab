# +----------------------------------------------------------------------------+
# | CoreLab v0.1 - Modular Processor Simulation Framework                      |
# | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                       |
# | Makefile                                                                   |
# | Makefile for many files of the same type                                   |
# +----------------------------------------------------------------------------+

include ../Makefile.global

title="desktop files "
removetargetdir=0
sourcedir="."
filemode=$(txtmode)
targetdir1=$(datarootdir)/applications
files1=`ls $(sourcedir)/*.desktop`
targetdir2=$(datarootdir)mime/packages
files2=`ls $(sourcedir)/*.xml`
targetdir3=$(datarootdir)/icons/hicolor
size3=16x16 32x32 48x48 64x64
category3=apps mimetypes

all:

clean:

install:
	@echo -n "- Installing "$(title)"["
	@$(install) -d $(targetdir1)
	@for x in $(files1); do \
	  if [ -f $(sourcedir)/$$x ]; \
	  then \
	    $(install) -m $(filemode) $(sourcedir)/$$x $(targetdir1); \
	    echo -n "#"; \
	  fi \
	done

	@$(install) -d $(targetdir2)
	@for x in $(files2); do \
	  if [ -f $(sourcedir)/$$x ]; \
	  then \
	    $(install) -m $(filemode) $(sourcedir)/$$x $(targetdir2); \
	    echo -n "#"; \
	  fi \
	done

	@for c in $(category3); do \
	  for s in $(size3); do \
	    $(install) -d $(targetdir3)/$$s/$$c; \
	    files3=`ls $(sourcedir)/$$s/$$c`; \
	    for x in $$files3; do \
	      if [ -f $(sourcedir)/$$s/$$c/$$x ]; \
	      then \
	        $(install) -m $(filemode) $(sourcedir)/$$s/$$c/$$x $(targetdir3)/$$s/$$c; \
	        echo -n "#"; \
	      fi; \
	    done; \
	  done; \
	done
	@echo "]"

uninstall:
	@echo -n "- Removing "$(title)"["
	@for x in $(files1); do \
	  $(rm) $(targetdir1)/$$x; \
	  echo -n "#"; \
	done
	@for x in $(files2); do \
	  $(rm) $(targetdir2)/$$x; \
	  echo -n "#"; \
	done
	@for x in $(files3); do \
	  $(rm) $(targetdir3)/$$x; \
	  echo -n "#"; \
	done
	@if [ $(removetargetdir) -eq 1 ]; \
	then \
	  if [ -d $(targetdir1) ]; then $(rmdir) $(targetdir1); fi; \
	  if [ -d $(targetdir2) ]; then $(rmdir) $(targetdir2); fi; \
	  if [ -d $(targetdir3) ]; then $(rmdir) $(targetdir3); fi; \
	fi;
	@echo "]"

convert:

createhelp:
