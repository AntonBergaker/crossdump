import QtQuick 2.0

Rectangle {
    visible: task.isDone
    height: 180
    width: 450
    anchors.top: parent.top
    anchors.left: parent.left
    border.color: "#C4C4C4"

    // seperator between header and main thing
    Rectangle {
        anchors.top: parent.top
        anchors.topMargin: 40
        anchors.left: parent.left
        height: 1
        width: parent.width
        color: "#C4C4C4"
    }

    // Header
    Image {
        source: "qrc:///images/navigation-icon.png"
        width: 32
        height: 32
        anchors.top: parent.top
        anchors.topMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 8
    }

    Text {
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 45
        font.pixelSize: 20
        text: "NAVIGATION"
        color: "#707070"
    }
    // Header end


    // Main thing
    Text {
        text: traveler.nextTurnText
        font.pixelSize: 35
        anchors.top: parent.top
        anchors.topMargin: 70
        anchors.left: parent.left
        anchors.leftMargin: 125
        color: "#111111"
    }

    Text {
        text: traveler.nextRoadName == "" ? "" : "onto <strong>" + traveler.nextRoadName + "</strong>"
        textFormat: Text.StyledText
        font.pixelSize: 20
        anchors.top: parent.top
        anchors.topMargin: 125
        anchors.left: parent.left
        anchors.leftMargin: 125
        color: "#636363"
    }


    Image {
        source: traveler.nextTurnIcon == "" ? "" : "qrc:///images/" + traveler.nextTurnIcon
        width: 70
        height: 70
        anchors.top: parent.top
        anchors.topMargin: 55
        anchors.left: parent.left
        anchors.leftMargin: 20
    }


    Text {
        text: traveler.nextTurnDistance
        font.pixelSize: 20
        anchors.top: parent.top
        anchors.topMargin: 130
        horizontalAlignment: Text.AlignHCenter
        anchors.horizontalCenter: parent.left
        anchors.horizontalCenterOffset: 60
        color: "#636363"
    }

    // Main thing end
}
