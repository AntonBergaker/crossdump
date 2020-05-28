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
    rightButtonColor: "#ff8e00"
    onRightClicked: {
        visible = false
        currentRoute = selectedRoute
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
        font.family: base.font
        font.pointSize: 14
        font.bold: true
        color: theme.text
    }

    ListView {
        width: 0.90* parent.width
        height: parent.height - 180-130
        anchors.top: parent.top
        anchors.topMargin: 130
        anchors.horizontalCenter: parent.horizontalCenter

        model: allRoutes.routeList
        delegate: Rectangle {
            width: parent.width * 0.90
            height: selectedRoute == modelData ? text.height + listView.height + 15: 100
            anchors.leftMargin: 0.10 * parent.width


            Rectangle {
                color: selectedRoute == modelData ? theme.selected : theme.background
                height: parent.height
                width:parent.width
                Text {
                    id: text
                    text: modelData.name
                    wrapMode: Text.Wrap
                    width: parent.width-20
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: 20
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    font.bold: true
                    font.pointSize: 16
                    font.family: base.font


                    color: theme.weakText

                }

                ListView {
                    id: listView
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    anchors.top: text.bottom
                    anchors.topMargin: 3
                    width: parent.width-20
                    property bool isSelected: selectedRoute == modelData
                    height: isSelected ? 40 * modelData.zoneList.length : 40
                    orientation: isSelected ? Qt.Vertical : Qt.Horizontal
                    spacing: isSelected ? 10 : 20
                    model: modelData.zoneList
                    clip: true
                    delegate:
                        Rectangle {
                        id: zoneTag
                        color: theme.secondSelected
                        radius: 8
                        height: 25
                        width: tagText.width + 5

                        Text {
                            id: tagText
                            color: theme.weakText
                            text: modelData.name
                            font.family: base.font
                            wrapMode: Text.Wrap
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
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


