import QtQuick 2.0

Box {
    height: parent.height
    width: parent.width/3
    anchors.right: parent.right

    headerIconSource: "qrc:///images/navigation-icon.png"
    headerText: "ZONE"
    visible: traveler.insideZone

    Text {
        anchors.top: parent.top
        anchors.topMargin: 100
        anchors.left: parent.left
        anchors.leftMargin: 50
        text: targetZone ? targetZone.name : ""
        color: "#333"
        font.pixelSize: 30
        font.family: base.font
    }

    // Hula hoop circle
    Item {
        anchors.horizontalCenter: parent.horizontalCenter
        width: 300
        height: 300
        anchors.top: parent.top
        anchors.topMargin: 280

        Image {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            source: "qrc:///images/orange-hula-hoop.png"
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 80
            text: targetZone ? targetZone.coordinates.length : null
            color: "#636366"
            font.pixelSize: 70
            font.family: base.font
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 160
            horizontalAlignment: Text.AlignHCenter
            text: "bins at this\nlocation"
            color: "#636366"
            font.pixelSize: 30
            font.family: base.font
        }
    }


    rightButtonVisible: true;
    rightButtonText: "Next location"
    rightButtonColor: "#88bb58"
    onRightClicked: {
        targetZoneIndex++;
        navigator.navigateWithStartEnd(task, currentLocation.coordinate, targetZone.averagePoint)
    }
}
