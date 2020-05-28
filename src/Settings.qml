import QtQuick 2.9
import QtQuick.Window 2.9
import QtLocation 5.11
import QtPositioning 5.11
import QtQuick.Controls 2.2
import com.crossdump.navigationsegment 1.0
import com.crossdump.route 1.0
import com.crossdump.availableroutes 1.0
import com.crossdump.traveler 1.0

Box {
        headerIconSource: "qrc:/images/settings.png"
        headerText: "Settings"

        footer: true

        leftButtonVisible: true
        leftButtonText: "Close"
        onLeftClicked: {
            visible = false
        }
        Rectangle{
            color: parent.color
            anchors.fill: parent
            anchors.margins: 1 + 30
            anchors.topMargin: 42 + 30
            anchors.bottomMargin: 122 + 30
            Text {
                font.family: base.font
                font.pointSize: 12
                anchors.verticalCenter: dayNightSwitch.verticalCenter
                anchors.left: parent.left
                text: "Toggle Day/Night mode"
            }
            Switch{
                id: dayNightSwitch
                anchors.right: parent.right
                anchors.top: parent.top
                checked: base.nightMode
                onToggled: {
                    if (base.nightMode){
                        map.activeMapType = map.supportedMapTypes[0]
                    }
                    else{
                        map.activeMapType = map.supportedMapTypes[1]
                    }
                    base.nightMode = !base.nightMode;
                }
            }
            Text {
                font.family: base.font
                font.pointSize: 12
                anchors.verticalCenter: uselessSwitch.verticalCenter
                anchors.left: parent.left
                text: "Toggle American English/British English"
            }
            Switch{
                id: uselessSwitch
                anchors.right: parent.right
                anchors.top: dayNightSwitch.bottom
                anchors.topMargin: 20
            }
            Text {
                width: parent.width
                anchors.bottom: parent.bottom
                wrapMode: Text.Wrap
                text: "Made by: Anton Bergåker, Carl Enlund, \nAstrid Nord Olsson and Arvid Sandin"
            }
        }
    }
