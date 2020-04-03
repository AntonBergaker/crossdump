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

            center: QtPositioning.coordinate(59.86, 17.64) // Uppsala
            zoomLevel: 16
            minimumZoomLevel: 0
            maximumZoomLevel: 20
            tilt: 45

            /// ROUTE LINE
            MapItemView {
                model: routeModel
                // draw with maproute component
                delegate: MapRoute {
                    // route to draw
                    route: routeData

                }
            }
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

