import QtLocation 5.9
import QtPositioning 5.0
import QtQuick 2.0

Rectangle {
    Map {
        id: map
        anchors.fill: parent
        plugin: mapboxglPlugin

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
            plugin: Plugin {
                name: "mapbox"

                // Copied development access token, do not use in production!

                PluginParameter {
                    name: "mapbox.access_token"
                    value: "pk.eyJ1IjoicXRzZGsiLCJhIjoiY2l5azV5MHh5MDAwdTMybzBybjUzZnhxYSJ9.9rfbeqPjX2BusLRDXHCOBA"

                }
                // create route at launch
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
}
