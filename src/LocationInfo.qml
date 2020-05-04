import QtQuick 2.0

Box {
    height: parent.height
    width: parent.width/3
    anchors.right: parent.right

    headerIconSource: "qrc:///images/navigation-icon.png"
    headerText: "ZONE"

    // Hula hoop circle
    Item {
        anchors.horizontalCenter: parent.horizontalCenter
        width: 300
        height: 300
        anchors.top: parent.top
        anchors.topMargin: 200

        Image {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            source: "qrc:///images/orange-hula-hoop.png"
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 80
            text: "5"
            color: "#636366"
            font.pixelSize: 70
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 160
            horizontalAlignment: Text.AlignHCenter
            text: "bins at this\nlocation"
            color: "#636366"
            font.pixelSize: 30
        }
    }


    rightButtonVisible: true;
    rightButtonText: "Next location"
    onRightClicked: {
        console.log("hi")
    }
}
