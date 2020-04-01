import QtQuick 2.0

import QtQuick.Window 2.0
import QtLocation 5.6
import QtPositioning 5.6
import QtQuick.Controls 1.4

Rectangle {
    Rectangle {
        height: parent.height
        width: parent.width * 2 / 3
        anchors.left: parent.left
        anchors.top: parent.top

        RouteQuery {
            id: routeQuery
            waypoints: [QtPositioning.coordinate(59.86, 17.64), QtPositioning.coordinate(59.84, 17.648)]
        }

        RouteModel {
            id: route
            plugin: mapboxglPlugin
            query: routeQuery
            autoUpdate: true
        }

        Map {
            id: map
            anchors.fill: parent
            plugin: mapboxglPlugin
            zoomLevel: 14
            center: QtPositioning.coordinate(59.86, 17.64)

            Repeater {
                model: routeQuery.waypoints

                MapQuickItem {
                    property int iconWidth: 25
                    property int iconHeight: 25
                    anchorPoint.x: iconWidth / 2
                    anchorPoint.y: iconHeight / 2
                    coordinate: routeQuery.waypoints[index]
                    sourceItem: Rectangle {
                        width: iconWidth
                        height: iconHeight
                        radius: width
                        color: "#f29200"
                    }
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    routeQuery.waypoints.push(map.toCoordinate(Qt.point(mouse.x, mouse.y)))
                    console.log(routeQuery.waypoints.length)
                }
            }
        }
    }

    Rectangle {
        height: parent.height
        width: parent.width * 1 / 3
        anchors.right: parent.right

        Text {
            text: "Routes"
        }
    }
}
