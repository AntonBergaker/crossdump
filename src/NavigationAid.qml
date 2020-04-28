import QtQuick 2.0


Box {
    headerIconSource: "qrc:/images/navigation-icon.png"
    headerText: "NAVIGATION"
    height: 180


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
