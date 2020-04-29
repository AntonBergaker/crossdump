import QtQuick 2.9
import QtQuick.Window 2.9
import QtLocation 5.11
import QtPositioning 5.11
import QtQuick.Controls 1.4
import com.calviton.navigationsegment 1.0
import com.calviton.zone 1.0
import com.calviton.route 1.0

Box {
        property Route selectedRoute: routeButton.route
        headerIconSource: "qrc:/images/navigation-icon.png"
        headerText: "CURRENT ROUTE"

        footer: true

        leftButtonVisible: true
        leftButtonText: "Back"
        onLeftClicked: {visible = false}

        rightButtonVisible: true
        rightButtonText: "Exit route"
        onRightClicked: {
            routeButton.route = null;
            routeButton.isNavigating = false;
            visible = false;
        }



        ListView {
            width: parent.width
            height: parent.height -140
            anchors.top: parent.top
            anchors.margins: 80
            spacing: 0
            model: selectedRoute.zoneList
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
