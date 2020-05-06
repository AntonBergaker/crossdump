import QtQuick 2.9
import QtQuick.Window 2.9
import QtLocation 5.11
import QtPositioning 5.11
import QtQuick.Controls 1.4
import com.crossdump.navigationsegment 1.0
import com.crossdump.route 1.0
import com.crossdump.availableroutes 1.0
import com.crossdump.traveler 1.0

Rectangle {
    id:top

    Traveler {
        id: traveler
        navigation: task.isDone ? task.result : null
        position: currentLocation.coordinate;
    }
    Location {
        id: currentLocation
        coordinate: QtPositioning.coordinate(59.86, 17.64)
    }
    PositionSource{
        id: positionSource
        active: true
        preferredPositioningMethods: PositionSource.AllPositioningMethods
        onPositionChanged: {
            var coord = position.coordinate;
            startMarker.coordinate = coord;
            if (menuButtons.isNavigating){
                map.center = coord;
            }

        }
        //This is for a pregenerated demo route
        nmeaSource: Qt.resolvedUrl("data/GPS_movement.nmea")
    }

    AvailableRoutes{
        id: allRoutes
    }

    Rectangle {
        height: parent.height
        width: parent.width * 3 / 3
        anchors.left: parent.left
        anchors.top: parent.top

        Map {
            id: map
            anchors.fill: parent
            plugin: mapboxPlugin
            activeMapType: MapType.StreetMap
            center: QtPositioning.coordinate(59.858564, 17.638927)
            minimumZoomLevel: 0
            maximumZoomLevel: 20
            zoomLevel: 14

            // MapBoxGL parameters. These parameters don't work with regular MapBox.
            MapParameter {
                type: "paint"

                property string layer: "road-motorway"
                property string lineColor: "#FFF"
            }
            MapParameter {
                type: "paint"

                property string layer: "road-motorway_link"
                property string lineColor: "#FFF"
            }
            MapParameter {
                type: "paint"

                property string layer: "road-trunk"
                property string lineColor: "#FFF"
            }
            MapParameter {
                type: "paint"

                property string layer: "road-trunk_link"
                property string lineColor: "#FFF"
            }
            MapParameter {
                type: "paint"

                property string layer: "road-primary"
                property string lineColor: "#FFF"
            }

            MapQuickItem {
                id: startMarker

                sourceItem: Image {
                    id: greenMarker
                    source: "qrc:///images/marker-green.png"
                }

                coordinate : QtPositioning.coordinate(59.86, 17.64)
                anchorPoint.x: greenMarker.width / 2
                anchorPoint.y: greenMarker.height

                MouseArea  {
                    drag.target: startMarker
                    anchors.fill: startMarker
                }

                onCoordinateChanged: currentLocation.coordinate = coordinate;
            }

            MapPolyline {
                visible: task.isDone
                line.width: 3
                line.color: "#FF8E00"
                path: task.isDone ? task.result.coordinates.splice(traveler.navigationCoordinateIndex) : null
            }
            MapPolyline {
                visible: task.isDone
                line.width: 3
                line.color: "#636363"
                path: task.isDone ? task.result.coordinates.splice(0, traveler.navigationCoordinateIndex+1) : null
            }

            //Zones
            MapItemView {
                model: menuButtons.route ? menuButtons.route.zoneList : null
                delegate: MapQuickItem {
                    property int iconSize: 35
                    anchorPoint.x: iconSize / 2
                    anchorPoint.y: iconSize / 2
                    coordinate: averagePoint
                    sourceItem: Rectangle {
                        width: iconSize
                        height: iconSize
                        radius: width
                        color: "#fff"
                        border.color: "#636366"
                        border.width: 3
                        Text {
                            text: coordinates.length < 2 ? "" :coordinates.length
                            font.family: "Roboto"
                            font.pointSize: 12
                            anchors.centerIn: parent
                        }
                    }
                }
            }
            //Locations in zones
            MapItemView {
                model: menuButtons.route ? menuButtons.route.zoneList : null
                visible: false
                delegate: MapItemView {
                    model: modelData.coordinates
                    property real distanceToUser:modelData.averagePoint.distanceTo(currentLocation.coordinate);
                    visible: distanceToUser < 850;
                    delegate: MapQuickItem {
                        property int iconSize: 20
                        anchorPoint.x: iconSize / 2
                        anchorPoint.y: iconSize / 2
                        coordinate: modelData
                        sourceItem: Rectangle {
                            width: iconSize
                            height: iconSize
                            radius: width
                            color: "#0097BA"
                        }
                    }
                }
            }
        }

        NavigationAidBox {
            visible: menuButtons.isNavigating
        }

        MenuButtons {
            id: menuButtons
            height: parent.height*0.4
            width: parent.width*1/15
            anchors.bottom: parent.bottom
            anchors.left: parent.left
        }

        RoutePickerBox {
            id: pickRoute
            visible: false
        }

        RouteInfoBox {
            id: currentRouteInfo
            visible: false
        }

        NavigationDestinationBox {
            visible: menuButtons.isNavigating
        }
    }
}
