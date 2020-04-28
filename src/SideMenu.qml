import QtQuick 2.9
import QtQuick.Window 2.9
import QtLocation 5.11
import QtPositioning 5.11
import QtQuick.Controls 1.4
import com.calviton.navigationsegment 1.0
import com.calviton.zone 1.0
import com.calviton.route 1.0

Item{
    id:sideMenu
    property Route selectedRoute: null
    property bool routeListVisible: true
    property bool currentRouteVisible: !routeListVisible
    visible: false
    Rectangle {
        id: routeList
        anchors.fill: parent
        visible: sideMenu.routeListVisible
        Rectangle {
            height: parent.height*7/8
            width: parent.width
            anchors.top: parent.top
            anchors.left: parent.left
            color: "white"
            border.width: 1
            border.color: "#CCCCCC"
            ListView {
                width: parent.width
                height: parent.height*0.9
                anchors.bottom: parent.bottom
                spacing: 0
                model: allRoutes.routeList
                delegate: Row {
                    width: parent.width
                    height: text.height*1.5
                    spacing: 10
                    Rectangle {
                        color: sideMenu.selectedRoute == modelData ? "#dddddd" : "#ffffff"
                        height: parent.height
                        width: parent.width
                        Text {
                            id: text
                            text: "\nroute " + (index+1)
                            wrapMode: Text.Wrap
                            width: parent.width*2/3
                            anchors.right: parent.right
                            anchors.top: parent.top
                            font.bold: true
                            font.pointSize: 16
                            color: "#555555"
                            verticalAlignment: Text.AlignVCenter
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                sideMenu.selectedRoute = modelData;
                            }
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
            Button{
                height: parent.height/2
                width: parent.width/4
                anchors.left:parent.left
                anchors.top:parent.top
                anchors.topMargin: parent.height/4
                anchors.leftMargin: parent.width/8
                text: "Cancel"
                onClicked: {
                    sideMenu.visible = false
                }
            }
            Button{
                height: parent.height/2
                width: parent.width/4
                text: "Go!"
                anchors.right: parent.right
                anchors.top:parent.top
                anchors.topMargin: parent.height/4
                anchors.rightMargin: parent.width/8
                onClicked: {
                    if(sideMenu.selectedRoute != null){
                        sideMenu.visible = false;
                        routeButton.isNavigating=true;

                        navigator.navigateWithStartEnd(task, currentLocation.coordinate, selectedRoute.zoneList[0].averagePoint);
                    }
                }
            }
        }
    }
    Rectangle {
        id: currentRouteInfo
        anchors.fill: parent
        visible: sideMenu.currentRouteVisible
        Rectangle {
            height: parent.height*7/8
            width: parent.width
            anchors.top: parent.top
            anchors.left: parent.left
            color: "white"
            border.width: 1
            border.color: "#CCCCCC"
            ListView {
                width: parent.width
                height: parent.height*0.9
                anchors.bottom: parent.bottom
                spacing: 0
                model: sideMenu.selectedRoute ? sideMenu.selectedRoute.zoneList : null
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
                            text: "\n" + modelData.name//zone name
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
                            text: modelData.coordinates.length + " units"
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
            Button{
                height: parent.height/2
                width: parent.width/4
                anchors.right: parent.right
                anchors.top:parent.top
                anchors.topMargin: parent.height/4
                anchors.rightMargin: parent.width/8
                text: "Back"
                onClicked: {
                    sideMenu.visible = false
                }
            }
            Button{
                height: parent.height/2
                width: parent.width/4
                text: "Exit route"
                anchors.left:parent.left
                anchors.top:parent.top
                anchors.topMargin: parent.height/4
                anchors.leftMargin: parent.width/8
                onClicked: {
                    sideMenu.selectedRoute = null;
                    routeButton.isNavigating = false;
                    sideMenu.routeListVisible = true;
                }
            }
        }
    }

}

