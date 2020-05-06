import QtQuick 2.9
import QtQuick.Window 2.9
import QtLocation 5.11
import QtPositioning 5.11
import QtQuick.Controls 1.4
import com.crossdump.navigationsegment 1.0
import com.crossdump.zone 1.0
import com.crossdump.route 1.0
Box {

    property Route selectedRoute: null
    headerIconSource: "qrc:/images/navigation-icon.png"
    headerText:"ROUTE"
    footer: true
    anchors.top: parent.top
    anchors.left: parent.left

    leftButtonVisible: true
    leftButtonText: "Cancel"
    onLeftClicked: {
        visible = false;
        selectedRoute = null;
    }

    rightButtonVisible: selectedRoute
    rightButtonText: "Go!"
    onRightClicked: {
        visible = false
        menuButtons.routePicked = true
        menuButtons.route = selectedRoute
        menuButtons.isNavigating = true
        navigator.navigateWithStartEnd(task, currentLocation.coordinate, selectedRoute.zoneList[0].averagePoint);
        selectedRoute = null;
    }

    Text {
        anchors.top: parent.top
        anchors.topMargin: 100
        anchors.left: parent.left
        anchors.leftMargin: 20
        text: "Pick a route"
        font.family: "roboto"
        font.pointSize: 14
        font.bold: true
    }

    ListView {
        width: 0.90* parent.width
        height: parent.height - 180
        anchors.top: parent.top
        anchors.topMargin: 130
        anchors.horizontalCenter: parent.horizontalCenter

        model: allRoutes.routeList
        delegate: Rectangle {
            width: parent.width * 0.90
            height: 100
            anchors.leftMargin: 0.24 * parent.height


            Rectangle {
                color: selectedRoute == modelData ? "#dddddd" : "#ffffff"
                height: parent.height
                anchors.right: parent.right
                anchors.left: parent.left
                Text {
                    id: text
                    text: "\nROUTE " + (index+1)
                    wrapMode: Text.Wrap
                    width: parent.width
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    font.bold: true
                    font.pointSize: 16

                    color: "#555555"

                }

                ListView {
                 anchors.left: parent.left
                 anchors.leftMargin: 20
                 anchors.bottom: parent.bottom
                 anchors.bottomMargin: 3
                 width: parent.width
                 height: 40
                 orientation: Qt.Horizontal
                 spacing: 20
                 model: modelData.zoneList
                 delegate:
                Rectangle {
                    id: zoneTag
                    color: "#E7E7E7"
                    radius: 8
                    height: 25
                    width: tagText.width + 5

                    Text {
                        id: tagText
                        color: "#636366"
                        text: modelData.name
                        anchors.fill: parent.center
                    }
                 }
                }
                 Rectangle {
                     anchors.bottom: parent.bottom
                     anchors.horizontalCenter: parent.horizontalCenter

                     height: 3
                     width: parent.width
                     color: selectedRoute == modelData ? "#FF8E00" : "#C7C7C7"
                 }

                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        selectedRoute = modelData;
                    }
                }
            }
        }
    }

}


