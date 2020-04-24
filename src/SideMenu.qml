import QtQuick 2.9
import QtQuick.Window 2.9
import QtLocation 5.11
import QtPositioning 5.11
import QtQuick.Controls 1.4
import com.calviton.navigationsegment 1.0

Rectangle{
    id:sideMenu
    Rectangle {
        height: parent.height*7/8
        width: parent.width
        anchors.top: parent.top
        anchors.left: parent.left
        color: "white"
        border.width: 1
        border.color: "#CCCCCC"
        visible: true
        ListView {
            width: parent.width
            height: parent.height*0.9
            anchors.bottom: parent.bottom
            spacing: 0
            model: routeQuery.waypoints
            visible: model !== null

            delegate: Row {
                width: parent.width
                height: (zone.height+units.height)*1.5
                spacing: 10

                Rectangle {
                    height: parent.height
                    width: parent.width
                    Text {
                        id:zone
                        GeocodeModel {
                            plugin: osmPlugin
                            autoUpdate: true
                            query: modelData
                            onLocationsChanged: {
                                zone.zoneName = this.get(0).address.district
                            }
                        }
                        property string zoneName: ""
                        text: "\n" + zoneName
                        wrapMode: Text.Wrap
                        width: parent.width*2/3
                        anchors.right: parent.right
                        anchors.top: parent.top
                        font.bold: true
                        font.pointSize: 16
                        color: "#555555"
                        verticalAlignment: Text.AlignVCenter
                    }
                    Text {
                        id: units
                        text: "0 units"
                        wrapMode: Text.Wrap
                        width: parent.width*2/3
                        anchors.right: parent.right
                        anchors.top: zone.bottom
                        font.pointSize: 14
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
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        color: "white"
        border.width: 1
        border.color: "#CCCCCC"
        visible: true
        Button{
            height: parent.height/2
            width: parent.width/4
            anchors.left:parent.left
            anchors.top:parent.top
            anchors.topMargin: parent.height/4
            anchors.bottomMargin: parent.height/4
            anchors.leftMargin: parent.width/8
            anchors.rightMargin: parent.width/8
            text: "Back"
            onClicked: {
                currentRouteInfo.visible = !currentRouteInfo.visible
            }
        }
        Button {
            height: parent.height/2
            width: parent.width/4
            text: "Exit route"
            anchors.right: parent.right
            anchors.top:parent.top
            anchors.topMargin: parent.height/4
            anchors.bottomMargin: parent.height/4
            anchors.leftMargin: parent.width/8
            anchors.rightMargin: parent.width/8
            onClicked: ;
        }
    }
}
