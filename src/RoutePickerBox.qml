import QtQuick 2.9
import QtQuick.Window 2.9
import QtLocation 5.11
import QtPositioning 5.11
import QtQuick.Controls 1.4
import com.calviton.navigationsegment 1.0
import com.calviton.zone 1.0
import com.calviton.route 1.0
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

    rightButtonVisible: true
    rightButtonText: "Go!"
    onRightClicked: {
        visible = false
        routeButton.routePicked = true
        routeButton.route = selectedRoute
        routeButton.isNavigating = true
        navigator.navigateWithStartEnd(task, currentLocation.coordinate, selectedRoute.zoneList[0].averagePoint);
    }

    ListView {
        width: parent.width
        height: parent.height - 140
        anchors.top: parent.top
        anchors.topMargin: 80
        spacing: 0
        model: allRoutes.routeList
        delegate: Row {
            width: parent.width
            height: text.height*1.5
            spacing: 10
            Rectangle {
                color: selectedRoute == modelData ? "#dddddd" : "#ffffff"
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
                        selectedRoute = modelData;
                    }
                }
            }
        }
    }

}


