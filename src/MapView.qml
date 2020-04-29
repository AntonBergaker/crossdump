import QtQuick 2.9
import QtQuick.Window 2.9
import QtLocation 5.11
import QtPositioning 5.11
import QtQuick.Controls 1.4
import com.calviton.navigationsegment 1.0
import com.calviton.route 1.0
import com.calviton.availableroutes 1.0
import com.calviton.traveler 1.0

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
            plugin: osmPlugin
            zoomLevel: 14
            center: QtPositioning.coordinate(59.86, 17.64)
            minimumZoomLevel: 0
            maximumZoomLevel: 20

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

                onCoordinateChanged: currentLocation.coordinate = coordinate

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

            MapItemView {
                model: pickRoute.selectedRoute ? pickRoute.selectedRoute.zoneList : null
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
                            text: coordinates.length
                            font.family: "Roboto"
                            font.pointSize: 12
                            anchors.centerIn: parent
                        }
                    }
                }
            }
        }

        NavigationAidBox {
            visible: routeButton.isNavigating
        }

        RoutePickerBox {
            id: pickRoute
            visible: false
        }

        RouteInfoBox {
            id: currentRouteInfo
            visible: false
        }


        Button{
            id: routeButton
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            visible: !pickRoute.visible && !currentRouteInfo.visible
            text: "routes"
            height: 50
            width: 100
            property bool isNavigating: false
            property bool routePicked: false
            property Route route: null
            onClicked: {
                if(!routePicked){
                    pickRoute.visible = true
                }
                else{
                    currentRouteInfo.visible = true
                }
            }
        }
        NavigationDestinationBox {
            visible: routeButton.isNavigating
        }
    }
}
