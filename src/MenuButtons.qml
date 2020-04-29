import QtQuick 2.9
import QtQuick.Window 2.9
import QtLocation 5.11
import QtPositioning 5.11
import QtQuick.Controls 1.4
import com.calviton.navigationsegment 1.0
import com.calviton.route 1.0
import com.calviton.availableroutes 1.0
import com.calviton.traveler 1.0

Rectangle{
    property bool isNavigating: false
    Rectangle{
        id: routeButton
        anchors.top: parent.top
        anchors.left: parent.left
        height: parent.height/4
        width: parent.width
        border.width: 1
        Text {
            anchors.fill: parent
            text: qsTr("Routes")
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignBottom
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                sideMenu.visible = true
                if(menuButtons.isNavigating){
                    sideMenu.routeListVisible = false
                }
                else{
                    sideMenu.routeListVisible = true
                }
            }
        }
    }
    Rectangle{
        id: navigationButton
        anchors.top: routeButton.bottom
        anchors.left: parent.left
        height: parent.height/4
        width: parent.width
        border.width: 1
        Text {
            anchors.fill: parent
            text: qsTr("Navigation")
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignBottom
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
            }
        }
    }
    Rectangle{
        id: myLocationButton
        anchors.top: navigationButton.bottom
        anchors.left: parent.left
        height: parent.height/4
        width: parent.width
        border.width: 1
        Text {
            anchors.fill: parent
            text: qsTr("Target vehicle")
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignBottom
            wrapMode: Text.Wrap
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                map.center = currentLocation.coordinate
            }
        }
    }
    Rectangle{
        id: settings
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        height: parent.height/4
        width: parent.width
        border.width: 1
        Text {
            anchors.fill: parent
            text: qsTr("Settings")
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignBottom
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
            }
        }
    }
}
