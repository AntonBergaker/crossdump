import QtLocation 5.9
import QtPositioning 5.0
import QtQuick 2.0


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
        // basic map settings
        center: QtPositioning.coordinate(60.170448, 24.942046) // Helsinki
        zoomLevel: 16
        minimumZoomLevel: 0
        maximumZoomLevel: 20
        tilt: 45

        function updateRoute() {
            routeQuery.clearWaypoints();
            routeQuery.addWaypoint(startMarker.coordinate);
            routeQuery.addWaypoint(endMarker.coordinate);
        }

        /// START MARKER
        MapQuickItem { //QtQuick object that follows map panning/zooming
            id: startMarker
            // item to be drawn
            sourceItem: Image {
                id: greenMarker
                source: "qrc:///marker-green.png"
            }
            // placement, lines up with top-left corner of sourceItem
            coordinate : QtPositioning.coordinate(60.170448, 24.942046)
            // changes placement so it lines up correctly
            anchorPoint.x: greenMarker.width / 2
            anchorPoint.y: greenMarker.height
            //update route when moved
            onCoordinateChanged: {
                map.updateRoute();
            }
            //move it around
            MouseArea  {
                drag.target: parent // makes marker draggable
                anchors.fill: parent
            }
        }

        /// END MARKER
        MapQuickItem {
            id: endMarker

            sourceItem: Image {
                id: redMarker
                source: "qrc:///marker-red.png"
            }

            coordinate: QtPositioning.coordinate(61.170448, 24.942046)
            anchorPoint.x: redMarker.width / 2
            anchorPoint.y: redMarker.height

            onCoordinateChanged: {
                map.updateRoute();
            }
            MouseArea {
                drag.target: parent
                anchors.fill: parent
            }

        }

        /// ROUTE LINE
        MapItemView {
            model: routeModel

            // draw with maproute component
            delegate: MapRoute {
                // route to draw
                route: routeData
            }
        }

        // collects geographic routes from backend as list "routeData" used above
        RouteModel {
            id: routeModel

            autoUpdate: true
            query: routeQuery
            // collect data from mapbox
            plugin: osmPlugin
            Component.onCompleted: {
                    if (map) {
                        map.updateRoute();
             }
                }

            }
        }
        RouteQuery {
            id: routeQuery
        }
    }

Rectangle {
    height: parent.height
    width: parent.width * 1 / 3
    anchors.right: parent.right
    color: "white"
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
