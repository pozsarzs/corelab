Name: corelab
Version: 0.1.0
Release: 1
Summary: Modular Processor Simulation Framework
Group: System/Emulators
Packager: Pozsar Zsolt <pozsarzs@gmail.com>
Vendor: Pozsar Zsolt
License: EUPL
URL: https://pozsarzs.github.io/corelab/

%description
The CoreLAB project is a functional 8 bits microprocessor and
microcontroller simulator born from a fusion of academic
research, technical passion, and historical preservation.

%post
update-mime-database %{_datadir}/mime
gtk-update-icon-cache -t %{_datadir}/icons

%postun
update-mime-database %{_datadir}/mime
gtk-update-icon-cache -t %{_datadir}/icons

%files
%defattr(-,root,root,-)
%{_bindir}/clioport
%{_bindir}/clmemory
%{_bindir}/clprocessor
%{_bindir}/corelab
%{_bindir}/lhelp
%{_datadir}/applications/clioport.desktop
%{_datadir}/applications/clmemory.desktop
%{_datadir}/applications/clprocessor.desktop
%{_datadir}/applications/corelab.desktop
%{_datadir}/corelab/help/*.chm
%{_datadir}/corelab/syntax/*
%{_datadir}/icons/hicolor/16x16/apps/corelab-green.png
%{_datadir}/icons/hicolor/16x16/apps/corelab-orange.png
%{_datadir}/icons/hicolor/16x16/apps/corelab-pink.png
%{_datadir}/icons/hicolor/16x16/apps/corelab-red.png
%{_datadir}/icons/hicolor/16x16/mimetypes/application-x-corelab-project.png
%{_datadir}/icons/hicolor/16x16/mimetypes/application-x-corelab-scriptembly.png
%{_datadir}/icons/hicolor/16x16/mimetypes/application-x-corelab-snapshot.png
%{_datadir}/icons/hicolor/16x16/mimetypes/application-x-corelab-status.png
%{_datadir}/icons/hicolor/24x24/apps/corelab-green.png
%{_datadir}/icons/hicolor/24x24/apps/corelab-orange.png
%{_datadir}/icons/hicolor/24x24/apps/corelab-pink.png
%{_datadir}/icons/hicolor/24x24/apps/corelab-red.png
%{_datadir}/icons/hicolor/24x24/mimetypes/application-x-corelab-project.png
%{_datadir}/icons/hicolor/24x24/mimetypes/application-x-corelab-scriptembly.png
%{_datadir}/icons/hicolor/24x24/mimetypes/application-x-corelab-snapshot.png
%{_datadir}/icons/hicolor/24x24/mimetypes/application-x-corelab-status.png
%{_datadir}/icons/hicolor/32x32/apps/corelab-green.png
%{_datadir}/icons/hicolor/32x32/apps/corelab-orange.png
%{_datadir}/icons/hicolor/32x32/apps/corelab-pink.png
%{_datadir}/icons/hicolor/32x32/apps/corelab-red.png
%{_datadir}/icons/hicolor/32x32/mimetypes/application-x-corelab-project.png
%{_datadir}/icons/hicolor/32x32/mimetypes/application-x-corelab-scriptembly.png
%{_datadir}/icons/hicolor/32x32/mimetypes/application-x-corelab-snapshot.png
%{_datadir}/icons/hicolor/32x32/mimetypes/application-x-corelab-status.png
%{_datadir}/icons/hicolor/48x48/apps/corelab-green.png
%{_datadir}/icons/hicolor/48x48/apps/corelab-orange.png
%{_datadir}/icons/hicolor/48x48/apps/corelab-pink.png
%{_datadir}/icons/hicolor/48x48/apps/corelab-red.png
%{_datadir}/icons/hicolor/48x48/mimetypes/application-x-corelab-project.png
%{_datadir}/icons/hicolor/48x48/mimetypes/application-x-corelab-scriptembly.png
%{_datadir}/icons/hicolor/48x48/mimetypes/application-x-corelab-snapshot.png
%{_datadir}/icons/hicolor/48x48/mimetypes/application-x-corelab-status.png
%{_datadir}/icons/hicolor/64x64/apps/corelab-green.png
%{_datadir}/icons/hicolor/64x64/apps/corelab-orange.png
%{_datadir}/icons/hicolor/64x64/apps/corelab-pink.png
%{_datadir}/icons/hicolor/64x64/apps/corelab-red.png
%{_datadir}/icons/hicolor/64x64/mimetypes/application-x-corelab-project.png
%{_datadir}/icons/hicolor/64x64/mimetypes/application-x-corelab-scriptembly.png
%{_datadir}/icons/hicolor/64x64/mimetypes/application-x-corelab-snapshot.png
%{_datadir}/icons/hicolor/64x64/mimetypes/application-x-corelab-status.png
%{_datadir}/icons/hicolor/scalable/apps/corelab-green.svg
%{_datadir}/icons/hicolor/scalable/apps/corelab-orange.svg
%{_datadir}/icons/hicolor/scalable/apps/corelab-pink.svg
%{_datadir}/icons/hicolor/scalable/apps/corelab-red.svg
%{_datadir}/icons/hicolor/scalable/mimetypes/application-x-corelab-project.svg
%{_datadir}/icons/hicolor/scalable/mimetypes/application-x-corelab-scriptembly.svg
%{_datadir}/icons/hicolor/scalable/mimetypes/application-x-corelab-snapshot.svg
%{_datadir}/icons/hicolor/scalable/mimetypes/application-x-corelab-status.svg
%{_datadir}/locale/hu/LC_MESSAGES/clioport.mo
%{_datadir}/locale/hu/LC_MESSAGES/clmemory.mo
%{_datadir}/locale/hu/LC_MESSAGES/clprocessor.mo
%{_datadir}/locale/hu/LC_MESSAGES/corelab.mo
%{_datadir}/locale/hu/LC_MESSAGES/lhelp.mo
%{_datadir}/mime/packages/corelab.xml
%{_docdir}/corelab/*
%{_mandir}/man1/clioport.1*
%{_mandir}/man1/clmemory.1*
%{_mandir}/man1/clprocessor.1*
%{_mandir}/man1/corelab.1*
%{_prefix}/lib/corelab/*
