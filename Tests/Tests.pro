QT += testlib \
    location \
    positioning
QT -= gui

CONFIG += qt console warn_on depend_includepath testcase
CONFIG -= app_bundle

TEMPLATE = app

SOURCES +=  tst_tests.cpp \
    ../src/navigator.cpp \
    ../src/navigation.cpp \
    ../src/navigationtask.cpp \
    ../src/navigationsegment.cpp

HEADERS += \
    ../src/navigator.h \
    ../src/navigation.h \
    ../src/navigationtask.h \
    ../src/navigationsegment.h

