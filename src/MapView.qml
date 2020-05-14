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

    property int targetZoneIndex: 0
    property var targetZone: menuButtons.route ? menuButtons.route.zoneList[targetZoneIndex] : null;

    Traveler {
        id: traveler
        navigation: task.isDone ? task.result : null
        targetZone: top.targetZone
        position: currentLocation.coordinate
    }
    Location {
        id: currentLocation
        coordinate: QtPositioning.coordinate(59.86, 17.64)
    }
    // Enable me for real/spoofed gps
    /*
    PositionSource {
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
    */

    AvailableRoutes{
        id: allRoutes
    }
    Connections {
        target: pickRoute
        // Regenerate all routes (with optimized paths) when the route picker menu is opened.
        onVisibleChanged: allRoutes.updateRoutes(currentLocation.coordinate)
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
            center: QtPositioning.coordinate(59.858564, 17.638927)
            minimumZoomLevel: 0
            maximumZoomLevel: 20
            zoomLevel: menuButtons.isNavigating ? 16 : 14
            tilt: menuButtons.isNavigating ? 50 : 0

            MapQuickItem {
                id: startMarker
                rotation: traveler.direction

                sourceItem: Image {
                    id: driverIcon
                    source: "qrc:///images/driver.png"
                    width: 40
                    height: 40
                }

                coordinate : QtPositioning.coordinate(59.86, 17.64)
                anchorPoint.x: driverIcon.width / 2
                anchorPoint.y: driverIcon.height / 2

                MouseArea  {
                    drag.target: startMarker
                    anchors.fill: startMarker
                }

                onCoordinateChanged: currentLocation.coordinate = coordinate;
            }

            MapPolyline {
                visible: task.isDone &&  menuButtons.isNavigating
                line.width: 3
                line.color: "#FF8E00"
                path: task.isDone ? task.result.coordinates.splice(traveler.navigationCoordinateIndex) : null
            }
            MapPolyline {
                visible: task.isDone &&  menuButtons.isNavigating
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
            // Bounds of zones
            MapPolygon {
                color: 'gray'
                opacity: 0.2
                visible: menuButtons.route
                path: targetZone ? targetZone.bounds : null
            }

            //Locations in zones
            MapItemView {
                model: targetZone ? targetZone.coordinates : null
                visible: traveler.insideZone
                delegate: MapQuickItem {
                    property int iconSize: 20
                    anchorPoint.x: iconSize / 2
                    anchorPoint.y: iconSize / 2
                    coordinate: modelData
                    sourceItem: Image {
                        source: "qrc:///images/trashcan.png"
                        width: 30
                        height: 30

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
            visible: menuButtons.isNavigating && traveler.insideZone == false
        }

        ZoneInfo {

        }

    }
}
