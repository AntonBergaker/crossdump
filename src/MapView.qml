import QtQuick 2.0

import QtQuick.Window 2.0
import QtLocation 5.6
import QtPositioning 5.6

Rectangle {
    RouteQuery {
        id: currentRouteQuery
        waypoints: [QtPositioning.coordinate(59.86, 17.64), QtPositioning.coordinate(59.84, 17.648)]
    }
    RouteModel{
        id: currentRoute
        plugin: mapboxglPlugin
        query: currentRouteQuery
        autoUpdate: true
    }

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
        color: "#999999"
        ListView{
            anchors.fill: parent
            spacing: 10
            model: currentRoute//currentRoute.status == RouteModel.Ready ? currentRoute.get(0).segments : null
            visible: true//model ? true : false
            delegate: Row {
                width: parent.width
                spacing: 10
                property bool hasManeuver : modelData.maneuver && modelData.maneuver.valid
                visible: true//hasManeuver
                Rectangle {
                    anchors.fill: parent
                    color: "blue"
                }
                Text { text: (1 + index) + "." }
                Text { text: hasManeuver ? modelData.maneuver.instructionText : "" }
            }
        }
        Text {
            anchors.fill: parent
            text: qsTr(currentRouteQuery.waypoints[0].toString() + "\n" + currentRouteQuery.waypoints[1].toString())
        }
    }
}
