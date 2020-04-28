import QtQuick 2.0

Box {
        property Route selectedRoute: null
        headerIconSource: "qrc:/images/navigation-icon.png"
        headerText: "ROUTE"

        footer: true

        leftButtonVisible: true
        leftButtonText: "Back"
        onLeftClicked: {visible = false}

        rightButtonVisible: true
        rightButtonText: "Exit route"
        onRightClicked: {
            selectedRoute = null;
            visible = false;
        }



        ListView {
            width: parent.width
            height: parent.height*0.9
            anchors.bottom: parent.bottom
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
