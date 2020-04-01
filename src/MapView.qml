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
            plugin: mapboxglPlugin
            center: QtPositioning.coordinate(59.86, 17.64)
            zoomLevel: 14
        }
    }

    Rectangle {
        height: parent.height
        width: parent.width * 1 / 3
        anchors.right: parent.right
        color: "#bbbbbb"
        ListView{
            anchors.fill: parent
            spacing: 10
            model: routeModel.status == RouteModel.Ready ? routeModel.get(0).segments : null
            visible: model ? true : false
            delegate: Row {
                width: parent.width
                spacing: 10
                property bool hasManeuver : modelData.maneuver && modelData.maneuver.valid
                visible: hasManeuver
                Text { text: (1 + index) + "." }
                Text { text: hasManeuver ? modelData.maneuver.instructionText : ""; wrapMode:Text.Wrap;width:parent.width}
            }
        }
    }
}
