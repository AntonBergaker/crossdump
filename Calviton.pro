QT += quick \
    location \
    positioning
CONFIG += c++11

# The following define makes your compiler emit warnings if you use
# any Qt feature that has been marked deprecated (the exact warnings
# depend on your compiler). Refer to the documentation for the
# deprecated API to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES +=         src/main.cpp \
    src/navigator.cpp \
    src/navigation.cpp \
    src/navigationtask.cpp \
    src/navigationsegment.cpp \
    src/zone.cpp \
    src/route.cpp \
    src/availableroutes.cpp \
    src/traveler.cpp \
    src/collisionhelper.cpp

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH = /opt/Qt-5.12.0/5.12.0/gcc_64/qml

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH = /opt/Qt-5.12.0/5.12.0/gcc_64/qml

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

RESOURCES +=     src/qml.qrc

DISTFILES +=     src/main.qml

unix: {
    linux-g++ { # Qt5 x86
       message(Compiling for Qt $$QT_VERSION OS Version - Linux Virtual Machine)
       DEFINES += TARGET_X86
       LIB_PATH = /opt/lib
       INCLUDEPATH += /opt/crosscontrol/include
    }

    linux-arm-none-gnueabi-g++ {
       message(Compiling for Qt $$QT_VERSION LinX Version - Linux ARM iMX5 CCpilot)
       DEFINES += LINUX
       DEFINES += CCAUX
       DEFINES += TARGET_ARM_IMX5
       QML_IMPORT_PATH = /opt/VA/Qt-5.6.3/qml
       LIBS += -lcc-aux2
    }

    linux-oe-g++ { # Qt5 VS/VI2 OS version
       DEFINES += LINUX
       DEFINES += CCAUX
       DEFINES += TARGET_ARM_IMX6
       LIBS += -lcc-aux2
       message(Compiling for Qt $$QT_VERSION OS Version - Linux ARM iMX6 CCpilot)
    }

    linux-imx6-g++ { # Qt5.12.0 LinX version VS/VI2
       DEFINES += LINUX
       DEFINES += CCAUX
       DEFINES += TARGET_ARM_IMX6
       LIBS += -lcc-aux2
       message(Compiling for Qt $$QT_VERSION LinX Version - Linux ARM iMX6 CCpilot)
    }
}

HEADERS += \
    src/navigator.h \
    src/navigation.h \
    src/navigationtask.h \
    src/navigationsegment.h \
    src/zone.h \
    src/route.h \
    src/availableroutes.h\
    src/traveler.h \
    src/collisionhelper.h


