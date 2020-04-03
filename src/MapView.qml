import QtQuick 2.9

import QtQuick.Window 2.9
import QtLocation 5.11
import QtPositioning 5.11
import QtQuick.Controls 1.4

Rectangle {

    Rectangle {
        height: parent.height
        width: parent.width * 2 / 3
        anchors.left: parent.left
        anchors.top: parent.top

        Map {
            id: map
            anchors.fill: parent
            plugin: osmPlugin
            zoomLevel: 14
            center: QtPositioning.coordinate(59.86, 17.64)

            MapItemView {
                model: routeQuery.waypoints
                delegate: MapQuickItem {
                    property int iconSize: 20
                    anchorPoint.x: iconSize / 2
                    anchorPoint.y: iconSize / 2
                    coordinate: routeQuery.waypoints[index]
                    sourceItem: Rectangle {
                        width: iconSize
                        height: iconSize
                        radius: width
                        color: "#f29200"
                    }
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: routeQuery.addWaypoint(map.toCoordinate(Qt.point(mouse.x, mouse.y)))
            }
        }
    }

    Rectangle {
        height: parent.height
        width: parent.width * 1 / 3
        anchors.right: parent.right
        color: "white"
        Column {
            Button {
                text: "Clear route"
                onClicked: routeQuery.clearWaypoints()
            }
        }
        ListView{
            anchors.fill: parent
            spacing: 0
            model: routeModel.status == RouteModel.Ready ? routeModel.get(0).segments : null
            visible: model ? true : false
            delegate: Row {
                Rectangle{
                    width: parent.width; height: parent.height
                    border.color: "black"; border.width: 1
                    Text {
                        id:text
                        text: "\n  " + (1 + index) + ". " + (hasManeuver ? modelData.maneuver.instructionText : "") + "\n"
                        wrapMode: Text.Wrap
                        width: parent.width
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                    }
                }
                width: parent.width; height: text.height
                spacing: 10
                property bool hasManeuver : modelData.maneuver && modelData.maneuver.valid
                visible: hasManeuver
            }
        }
    }
}
