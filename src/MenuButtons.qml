import QtQuick 2.9
import QtQuick.Window 2.9
import QtLocation 5.11
import QtPositioning 5.11
import QtQuick.Controls 1.4
import com.crossdump.navigationsegment 1.0
import com.crossdump.route 1.0
import com.crossdump.availableroutes 1.0
import com.crossdump.traveler 1.0

Rectangle{
    property bool isNavigating: false
    Rectangle{
        id: routeButton
        anchors.top: parent.top
        anchors.left: parent.left
        height: parent.height/4
        width: parent.width
        color: "#FFF"

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
            font.family: base.font
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignBottom
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                if(menuButtons.isNavigating){
                    currentRouteInfo.visible = true
                }
                else{
                    pickRoute.visible = true
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
        color: if (currentRoute === null){
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
            font.family: base.font
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignBottom
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                if (currentRoute != null){
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
            font.family: base.font
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
        color: "#FFF"
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
            font.family: base.font
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignBottom
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                settingsBox.visible = true
            }
        }
    }
}
