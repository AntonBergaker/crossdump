import QtQuick 2.0

Box {
    headerIconSource: "qrc:/images/navigation-icon.png"
    headerText: "NAVIGATION"
    height: 180
    color: theme.background
    anchors.top: parent.top
    anchors.left: parent.left

    // Main thing
    Text {
        text: traveler.nextTurnText
        font.pixelSize: 35
        anchors.top: parent.top
        anchors.topMargin: 70
        anchors.left: parent.left
        anchors.leftMargin: 125
        color: theme.text
        font.family: base.font
    }

    Text {
        text: traveler.nextRoadName == "" ? "" : "onto <strong>" + traveler.nextRoadName + "</strong>"
        textFormat: Text.StyledText
        font.family: base.font
        font.pixelSize: 20
        anchors.top: parent.top
        anchors.topMargin: 125
        anchors.left: parent.left
        anchors.leftMargin: 125
        color: theme.weakText
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
        font.family: base.font
        anchors.horizontalCenter: parent.left
        anchors.horizontalCenterOffset: 60
        color: theme.weakText
    }

    // Main thing end
}
