import QtQuick 2.9

import QtQuick.Window 2.9
import QtLocation 5.11
import QtPositioning 5.11

Rectangle {

    Rectangle {
        height: parent.height
        width: parent.width * 2 / 3
        anchors.left: parent.left
        anchors.top: parent.top

        Map {
            anchors.fill: parent
            plugin: osmPlugin
            center: QtPositioning.coordinate(59.86, 17.64)
            zoomLevel: 14

    }


    }
}
