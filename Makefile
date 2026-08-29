# +----------------------------------------------------------------------------+
# | CoreLAB v0.1 - Modular Processor Simulation Framework                      |
# | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                       |
# | Makefile                                                                   |
# | Makefile for Unix-like systems                                             |
# +----------------------------------------------------------------------------+

include ./Makefile.global

logfile=./build.log
dirs=desktop document help manual message source syntax

all:
	@echo "Compiling source code..."
	@$(rm) logfile
	@for dir in $(dirs); do \
	  if [ -e Makefile ]; then $(make) -s -C $$dir all; fi; \
	done
	@echo "Done."

clean:
	@echo "Cleaning source code..."
	@for dir in $(dirs); do \
	  if [ -e Makefile ]; then $(make) -s -C $$dir clean; fi; \
	done
	@$(rm) build.log
	@$(rm) config.log
	@$(rm) config.status
	@$(rm) Makefile.global
	@echo "Done."

install:
	@echo "Installing program to "$(prefix)":"
	@for dir in $(dirs); do \
	  if [ -e Makefile ]; then $(make) -s -C $$dir install; fi; \
	done
	@ldconfig
	@update-mime-database $(datarootdir)/mime
	@gtk-update-icon-cache $(datarootdir)/icons
	@echo "Done."

uninstall:
	@echo "Removing program from "$(prefix)":"
	@for dir in $(dirs); do \
	  if [ -e Makefile ]; then $(make) -s -C $$dir uninstall; fi; \
	done
	@ldconfig
	@update-mime-database $(datarootdir)/mime
	@gtk-update-icon-cache $(datarootdir)/icons
	@echo "Done."

convert:
	@echo "Convert files for DOS and Windows"
	@for dir in $(dirs); do \
	  if [ -e Makefile ]; then $(make) -s -C $$dir convert; fi; \
	done
	@echo "Done."

createhelp:
	@echo "Create compressed HTML help file"
	@for dir in $(dirs); do \
	  if [ -e Makefile ]; then $(make) -s -C $$dir createhelp; fi; \
	done
	@echo "Done."
