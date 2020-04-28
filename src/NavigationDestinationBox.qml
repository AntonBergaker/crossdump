import QtQuick 2.0
import QtLocation 5.11
import QtPositioning 5.11

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
                query: {return task.isDone ? task.result.coordinates[task.result.coordinates.length-1] : "" }
                onLocationsChanged: {
                    var address = geocodeModel.get(0).address
                    if (address.district === ""){
                        destination.text = address.street
                    }
                    else{
                        destination.text = address.street + ", " + address.district
                    }
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

            text: task.isDone ? Math.round(task.result.travelTime / 60) + " min" : ""
        }
    }
}
