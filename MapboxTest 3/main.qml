import QtQuick 2.6

import QtQuick.Window 2.0
import QtLocation 5.9
import QtPositioning 5.6
import QtGraphicalEffects 1.12
import QtQuick.Controls 2.6

Item {
    id: base
    width: displayWidth
    height: displayHeight
    visible: true

    Plugin {
        id: mapboxglPlugin
        name: "mapboxgl"
    }

    Rectangle {
        id: view

        anchors.centerIn: parent

        // this will provide automatic adaption to screen size and orientation
        width: (targetARM && orientationPortrait) ? base.height : base.width;
        height: (targetARM && orientationPortrait) ? base.width : base.height;
        rotation: parent.orientationOverride


        // add your GUI code below this line

        color: "black"
        Rectangle{
            id: leftList
            anchors.left: parent.left
            anchors.top: parent.top
            height: parent.height
            width: parent.width/4
            color: "#dadada"
            Rectangle{
                anchors.left: parent.left; anchors.top: parent.top
                width: parent.width; height: parent.height/10
                border.color: "black"
                border.width: 2
                Text {
                    anchors.fill: parent
                    anchors.margins: 5
                    text: qsTr("School")
                }
                MouseArea{
                    anchors.fill:parent
                    onClicked:{
                        map.center = QtPositioning.coordinate(59.8408, 17.6483)
                        map.zoomLevel = 17
                    }
                }
            }
        }

        Map {
            id: map
            copyrightsVisible: false //For legal reasons, this will probaly have to be true
            anchors.top: parent.top
            anchors.left: leftList.right
            anchors.right: parent.right
            height: parent.height
            width: parent.width-leftList.width
            plugin: mapboxglPlugin
            center: QtPositioning.coordinate(59.86, 17.64) // Uppsala
            zoomLevel: 14
            MapParameter {
                type: "paint"
                property string layer: "background"
                property string backgroundColor: "#f4f4f4"
            }
        }

        MyButtom {
            id: zoomIn
            anchors.bottom: zoomOut.top
            anchors.right: view.right
            onClicked: map.zoomLevel += 0.5
            Text {
             anchors.centerIn: parent
             font.pointSize: 40
             text: qsTr("+")
            }
        }
        MyButtom {
            id: zoomOut
            anchors.bottom: view.bottom
            anchors.right: view.right
            onClicked: map.zoomLevel -= 0.5
            Text {
             anchors.centerIn: parent
             font.pointSize: 40
             text: qsTr("-")
            }
        }

    }
}
