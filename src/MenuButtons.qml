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
        color: sideMenu.visible ? "#FF8E00" : "#FFF"
        Image {
            source: "qrc:///images/icons8-track-order.png"
            width: height
            anchors.top: parent.top
            anchors.margins: 5
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.botton
            opacity: 0.5
            //Track Order icon by Icons8
            //https://icons8.com/icons/set/track-order"
        }
        Text {
            anchors.fill: parent
            anchors.bottomMargin: 5
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
        color: if (sideMenu.selectedRoute === null){
            "#999"}
               else if(menuButtons.isNavigating) {
                   "#FF8E00"
               }
               else{
                   "#FFF"
               }
        Image {
            source: "qrc:///images/navigation.png"
            width: height
            anchors.top: parent.top
            anchors.margins: 5
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.botton
            opacity: 0.5
            rotation: 45
        }
        Text {
            anchors.fill: parent
            anchors.bottomMargin: 5
            text: qsTr("Navigation")
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignBottom
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                if (sideMenu.selectedRoute != null){
                    menuButtons.isNavigating = !menuButtons.isNavigating
                }

            }
        }
    }
    Rectangle{
        id: myLocationButton
        anchors.top: navigationButton.bottom
        anchors.left: parent.left
        height: parent.height/4
        width: parent.width
        color: map.center === currentLocation.coordinate ? "#FF8E00" : "#FFF"
        Image {
            source: "qrc:///images/crosshairs-gps.png"
            width: height
            anchors.top: parent.top
            anchors.margins: 5
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.botton
            opacity: 0.5
        }
        Text {
            anchors.fill: parent
            anchors.bottomMargin: 5
            text: qsTr("My location")
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
        id: settingsButton
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        height: parent.height/4
        width: parent.width
        color: "#999"
        Image {
            source: "qrc:///images/settings.png"
            width: height
            anchors.top: parent.top
            anchors.margins: 5
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.botton
            opacity: 0.5
        }
        Text {
            anchors.fill: parent
            anchors.bottomMargin: 5
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
