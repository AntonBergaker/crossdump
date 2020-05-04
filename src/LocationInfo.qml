import QtQuick 2.0

Rectangle {
    height: parent.height
    width: parent.width/3
    anchors.right: parent.right

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
        text: "ZONE"
        color: "#707070"
    }
    // Header end
}
