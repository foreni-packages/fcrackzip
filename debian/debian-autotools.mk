#!/usr/bin/make -f
#
#   debian-autotools.mk -- Common tasks for Autotools
#
#   Copyright
#
#	Copyright (C) 2008-2010 Jari Aalto <jari.aalto@cante.net>
#
#   License
#
#	This program is free software; you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation; either version 2 of the License, or
#	(at your option) any later version.
#
#	This program is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#	GNU General Public License for more details.
#
#	You should have received a copy of the GNU General Public License
#	along with this program. If not, see <http://www.gnu.org/licenses/>.
#
#   Description
#
#	This is GNU makefile part that defines common variables,
#	targets and macros to be used in debian/rules.
#
#	Dealing with packages that have old Autotools config.* files
#	we can: (1) Save package's config.* (2) Copy the latest from
#	Debian (3) restore package's config.* files. This way the
#	Debian *diff.gz stays clean and understandable to examine. In
#	addition if sources are kept in version control, they are not
#	flagged as modified.
#
#	To install, add macro calls like this:
#
#	    override_dh_auto_configure:
#		$(make-depend-save)
#		$(config-prepare)
#		dh_auto_configure
#
#	    override_dh_auto_clean:
#		$(config-restore)
#		$(make-depend-restore)
#		dh_auto_clean

ifneq (,)
    This makefile requires GNU Make.
endif

# ...................................................... make.depend ...

define make-depend-save
	# make-depend-save: Save original file
	[ -f make.depend.original ] || cp -v make.depend make.depend.original
endef

define make-depend-restore
	# make-depend-restore: Restore original file
	[ ! -f make.depend.original ] || mv -v make.depend.original make.depend
endef

# ...................................................... config-h-in ...

define config-h-in-save
	# config-h-in-save: Save original file
	[ -f config.h.in.original ] || cp -v config.h.in config.h.in.original
endef

define config-h-in-restore
	# config-h-in-restore: Restore original file
	[ ! -f config.h.in.original ] || mv -v config.h.in.original config.h.in
endef

# ........................................................ configure ...

define config-configure-save
	# config-configure-save: Save original file
	[ -f configure.original ] || cp -v configure configure.original
endef

define config-configure-restore
	# config-configure-restore: Restore original file
	[ ! -f configure.original ] || mv -v configure.original configure
endef

# ........................................ Debian config.{sub,guess} ...

define config-patch-sub
	# config-patch-sub: Use latest version from Debian
	[ ! -f /usr/share/misc/config.sub ] || \
	cp -vf /usr/share/misc/config.sub .
endef

define config-patch-guess
	# config-patch-guess: Use latest version from Debian
	[ ! -f /usr/share/misc/config.guess ] || \
	cp -vf /usr/share/misc/config.guess .
endef

# ............................................... config.{sub,guess} ...

define config-save
	# config-save: Save original files
	[ ! -f config.sub.original   ] || cp -v config.sub config.sub.original
	[ ! -f config.guess.original ] || cp -v config.guess config.guess.original
endef

define config-restore
	# config-restore: Restore original files
	[ ! -f config.sub.original   ] || mv -v config.sub.original config.sub
	[ ! -f config.guess.original ] || mv -v config.guess.original config.guess
endef

define config-restore-copy
	# config-restore-copy: Copy original files
	[ ! -f config.sub.original   ] || cp -v config.sub.original config.sub
	[ ! -f config.guess.original ] || cp -v config.guess.original config.guess
endef

define config-delete
	# config-delete: Delete config files
	rm -f config.sub config.guess
endef

define config-patch
	# config-patch: copy latest
	$(config-patch-sub)
	$(config-patch-guess)
endef

define config-prepare
       # config-prepare: save and patch
       $(config-save)
       $(config-patch)
endef

# End of Makefile part
