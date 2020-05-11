import QtQuick 2.0
import QtLocation 5.11
import QtPositioning 5.11

Box {
        headerIconSource: "qrc:/images/navigation-icon.png"
        headerText: "NEXT DESTINATION"
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        height: 180
        width: 400

        Text {
            id:destination
            anchors.top: parent.top
            anchors.topMargin: 65
            anchors.left: parent.left
            anchors.leftMargin: 40
            font.pointSize: 28
            text: targetZone ? targetZone.name : ""
            color: "#555555"
        }

        Text {
            id: estimatedTime
            anchors.top: parent.top
            anchors.topMargin: 120
            anchors.left: parent.left
            anchors.leftMargin: 40
            font.pointSize: 20
            textFormat: Text.StyledText

            text: task.isDone ?
                      "<strong>" + traveler.destinationTime + "</strong>" +
                      " (" + traveler.destinationDistance + ")"
                    : ""
        }
    }

