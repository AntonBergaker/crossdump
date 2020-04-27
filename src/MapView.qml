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

            MapItemView {
                model: routeQuery.waypoints
                delegate: MapQuickItem {
                    property int iconSize: 20
                    anchorPoint.x: iconSize / 2
                    anchorPoint.y: iconSize / 2
                    coordinate: modelData
                    sourceItem: Rectangle {
                        width: iconSize
                        height: iconSize
                        radius: width
                        color: "#f29200"
                    }
                }
            }


            MapItemView {
                model: sideMenu.selectedRoute.zoneList
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

            MouseArea {

                onClicked: {
                    routeQuery.addWaypoint(map.toCoordinate(Qt.point(mouse.x, mouse.y)))
                    if (routeQuery.waypointObjects().length >= 2) {
                        navigator.navigateWithCoordinates(
                                    task,
                                    routeQuery.waypoints
                                    )
                    }

                }
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
        }

        NavigationAid {
            visible: routeButton.isNavigating
        }

        SideMenu{
            id:sideMenu
            anchors.top: map.top
            anchors.left: map.left
            height: map.height-17 //-17 is to not hide copyright message
            width: map.width*1/3
        }

        Button{
            id: routeButton
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            visible: !sideMenu.visible
            text: "routes"
            height: 50
            width: 100
            property bool isNavigating: false
            onClicked: {
                sideMenu.visible = true
                if(isNavigating){ //TODO: connect to turn-by-turn navigation when it is implemented
                    sideMenu.routeListVisible = false
                }
                else{
                    sideMenu.routeListVisible = true
                }
                isNavigating = !isNavigating
            }
        }

        Rectangle {
            height: map.height*1/5
            width: map.width*1/3
            anchors.bottom: map.bottom
            anchors.right: map.right
            color: "white"
            border.width: 1
            border.color: "#CCCCCC"

            Rectangle {
                width: parent.width
                height: parent.height * 1 / 5
                anchors.top: parent.top
                anchors.left: parent.left
                border.width: 1
                border.color: "#CCCCCC"
            }

            Rectangle {
                width: parent.width
                height: parent.height * 4 / 5
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                border.width: 1
                border.color: "#CCCCCC"

                Text {
                    id:destination
                    anchors.top: parent.top
                    anchors.left: parent.left
                    width: parent.width
                    height: parent.height*0.6
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pointSize: 18
                    font.bold: true
                    text: ""

                    GeocodeModel {
                        id: geocodeModel
                        plugin: osmPlugin
                        autoUpdate: true
                        query: routeQuery.waypoints[1]//Will need an index from somewhere else to know what next stop is
                        onLocationsChanged: {
                            var address = geocodeModel.get(0).address
                            destination.text = address.street + ", " + address.district
                        }
                    }
                }
                Text {
                    id: estimatedTime
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    width: parent.width
                    height: parent.height*0.4
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pointSize: 15
                    font.bold: true

                    //This is currently showing the time to end destination and not to next destination
                    text: task.isDone ? Math.round(task.result.travelTime / 60) + " min" : ""
                }
            }
        }
    }
}

