import QtQuick 2.0
import QtLocation 5.11
import QtPositioning 5.11

Box {
        headerIconSource: "qrc:/images/navigation-icon.png"
        headerText: "NEXT DESTINATION"
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        height: 180


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
                plugin: Plugin {
                    name: "osm"
                    parameters: [
                        PluginParameter{
                            name: "osm.useragent"; value: "crossdump"
                        }]
                }
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

