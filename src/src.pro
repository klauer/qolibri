HEADERS += mainwindow.h \
           method.h \
           book.h \
           qeb.h \
           ebcore.h \
           ebcache.h \
           ebook.h \
           bookview.h \
           globaleventfilter.h \
           groupdock.h \
           groupwidget.h \
           bookwidget.h \
           configure.h \
           booksetting.h \
           optiondialog.h \
           fontsetting.h  \
           model.h \
           ssheetsetting.h \
           ssheet.h \
           titlelabel.h \
           toolbar.h \
           server.h \
           client.h \
           textcodec.h

SOURCES += qolibri.cpp \
           mainwindow.cpp \
           method.cpp \
           book.cpp \
           qeb.cpp \
           ebcore.cpp \
           ebcache.cpp \
           ebhook.cpp \
           ebook.cpp \
           bookview.cpp \
           globaleventfilter.cpp \
           groupdock.cpp \
           groupwidget.cpp \
           bookwidget.cpp \
           configure.cpp \
           booksetting.cpp \
           optiondialog.cpp \
           fontsetting.cpp \
           model.cpp \
           ssheetsetting.cpp \
           textcodec.cpp \
           toolbar.cpp

QT += network
QT += webkit
RESOURCES += qolibri.qrc
FORMS += optiondialog.ui

win32 {
} else {
    include("config")
}

TARGET = qolibri
DESTDIR = ./bin
OBJECTS_DIR = ./build
MOC_DIR = ./build
RCC_DIR = ./build
UI_DIR = ./build
LIBS += -leb

win32:LIBS += -lzlib
else:LIBS += -lz

TRANSLATIONS = qolibri_ja_JP.ts

#DEFINES += USE_GIF_FOR_FONT
#DEFINES += FIXED_POPUP
#DEFINES += RUBY_ON_TOOLBAR

unix:!macx {
    isEmpty(INSTALL_PREFIX):INSTALL_PREFIX=/usr/local
    isEmpty(INSTALL_BINDIR):INSTALL_BINDIR=$$INSTALL_PREFIX/bin
    isEmpty(INSTALL_DATADIR):INSTALL_DATADIR=$$INSTALL_PREFIX/share
    isEmpty(INSTALL_PKGDATADIR):INSTALL_PKGDATADIR=$$INSTALL_DATADIR/$$TARGET

    DEFINES += PKGDATADIR=\\\"$$INSTALL_PKGDATADIR\\\"

    target.path = $$INSTALL_BINDIR
    INSTALLS += target
    translations.path = $$INSTALL_PKGDATADIR
    translations.files = translations
    samples.path = $$INSTALL_PKGDATADIR
    samples.files = i18n/qolibri/*
}

INSTALLS += translations samples

isEmpty(QMAKE_LRELEASE) {
    win32:QMAKE_LRELEASE = $$[QT_INSTALL_BINS]\\lrelease.exe
    else:QMAKE_LRELEASE = $$[QT_INSTALL_BINS]/lrelease
    !exists($$QMAKE_LRELEASE) { QMAKE_LRELEASE = lrelease-qt4 }
}

updateqm.input = TRANSLATIONS
updateqm.output = translations/${QMAKE_FILE_BASE}.qm
updateqm.commands = $$QMAKE_LRELEASE -silent ${QMAKE_FILE_IN} -qm translations/${QMAKE_FILE_BASE}.qm
updateqm.CONFIG += no_link target_predeps
QMAKE_EXTRA_COMPILERS += updateqm

win32 {
    gitversion.commands = $$PWD/gitversion.cmd \"$$PWD\"
    gitversion.depends = $$PWD/../.git
    PRE_TARGETDEPS += gitversion
} else {
    gitversion.target = gitversion.h
    gitversion.commands = ./gitversion.sh > gitversion.h
    gitversion.depends = ${SOURCES} ${HEADERS}
    PRE_TARGETDEPS += gitversion.h
}
QMAKE_EXTRA_TARGETS += gitversion

message(Version = $$QT_VERSION)
message(Config = $$CONFIG)
message(Plugins = $$QTPLUGIN)
message(Defines  = $$DEFINES)
message(Libs = $$LIBS)
message(Include Path = $$INCLUDEPATH)
message(Installs = $$INSTALLS)
message(Target  = $$TARGET)

win32 {
    # NOTE: modify the path to libeb here
    INCLUDEPATH += C:\\dev\\eb\\eb-4.2.2-win32\\portsrc C:\\dev\\eb\\eb 
    Debug:QMAKE_LIBDIR += C:\\dev\\eb\\eb-4.2.2-win32\\Debug
    Release:QMAKE_LIBDIR += C:\\dev\\eb\\eb-4.2.2-win32\\Release
    RC_FILE = qolibri.rc
}
