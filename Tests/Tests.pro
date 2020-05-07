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
    ../src/navigationsegment.cpp \
    ../src/zone.cpp \
    ../src/route.cpp \
    ../src/availableroutes.cpp \
    ../src/traveler.cpp \
    ../src/collisionhelper.cpp


HEADERS += \
    ../src/navigator.h \
    ../src/navigation.h \
    ../src/navigationtask.h \
    ../src/navigationsegment.h \
    ../src/zone.h \
    ../src/route.h \
    ../src/availableroutes.h\
    ../src/traveler.h \
    ../src/collisionhelper.h

