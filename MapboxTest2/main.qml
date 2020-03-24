import QtQuick 2.6

import QtQuick.Window 2.0
import QtLocation 5.6
import QtPositioning 5.6

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

        /*
        // a text in the center of the application
        Text {
            anchors.centerIn: parent
            font.pointSize: 20
            color: "white"
            text: "MapboxTest2"
        }

        // a simple exit-button in the top-right corner
        Rectangle {
            width: 120;  height: 120
            anchors.right: parent.right
            anchors.top: parent.top
            color: "grey"
            Text {
                anchors.centerIn: parent
                text: "Exit"
            }
            MouseArea {
                anchors.fill: parent
                onClicked: { Qt.quit(); }
            }
        }
        */

        Map {
            anchors.fill: parent
            plugin: mapboxglPlugin
            center: QtPositioning.coordinate(59.91, 10.75) // Oslo
            zoomLevel: 14
        }
    }
}
