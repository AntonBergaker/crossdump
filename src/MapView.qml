import QtQuick 2.9
import QtQuick.Window 2.9
import QtLocation 5.11
import QtPositioning 5.11
import QtQuick.Controls 1.4
import com.calviton.navigationsegment 1.0

Rectangle {
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

            MouseArea {
                anchors.fill: parent
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
                path: task.isDone ? task.result.coordinates : null
            }
        }

        Rectangle{
            id:currentRouteInfo
            height: map.height-17//-17 is to not hide copyright message
            width: map.width*1/3
            anchors.top: map.top
            anchors.left: map.left

        Rectangle {
            height: map.height-17
            width: parent.width
            anchors.top: parent.top
            anchors.left: parent.left
            color: "white"
            border.width: 1
            border.color: "#CCCCCC"
            visible: true
            ListView {
                //TODO: make sure listview can't grow larger than parent
                width: parent.width
                height: parent.height*0.9
                anchors.bottom: parent.bottom
                spacing: 0
                model: task.isDone ? routeQuery.waypoints : null
                visible: model !== null

                delegate: Row {
                    width: parent.width
                    height: text.height*2
                    spacing: 10

                    Rectangle {
                        height: parent.height
                        width: parent.width

                        Text {
                            id:text
                            GeocodeModel {
                                plugin: osmPlugin
                                autoUpdate: true
                                query: modelData
                                onLocationsChanged: {
                                    text.zoneName = this.get(0).address.district
                                }
                            }
                            property string zoneName: ""
                            text: "\n" + zoneName + "\n" + "0 units"
                            wrapMode: Text.Wrap
                            width: parent.width*2/3
                            anchors.right: parent.right
                            anchors.top: parent.top
                            font.bold: true
                            font.pointSize: 16
                            color: "#555555"
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }
            }
        }
        Rectangle {
            height: parent.height*1/8
            width: parent.width
            anchors.bottom: currentRouteInfo.bottom
            anchors.left: map.left
            color: "white"
            border.width: 1
            border.color: "#CCCCCC"
            visible: true
            Button{
                text: "Back"
                onClicked: currentRouteInfo.visible = !currentRouteInfo.visible
            }
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

    Rectangle {
        id: directions
        height: parent.height/2
        width: parent.width * 1 / 3
        anchors.right: parent.right
        color: "white"
        visible: true

        ListView {
            width: parent.width
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            spacing: 0
            model: task.isDone ? task.result.segments : null
            visible: model !== null

            delegate: Row {
                width: parent.width
                height: text2.height
                spacing: 10
                property bool hasManeuver: modelData.instructionText !== ""
                visible: true

                Rectangle {
                    width: parent.width
                    height: parent.height
                    border.color: "black";
                    border.width: 1

                    Text {
                        id:text2
                        text: "\n  " + (1 + index) + ". " + (hasManeuver ? modelData.instructionText : "") + "\n"
                        wrapMode: Text.Wrap
                        width: parent.width
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                    }
                }
            }
        }
    }
}

