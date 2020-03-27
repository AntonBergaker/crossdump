import QtQuick 2.6

Item {
    id: base
    width: displayWidth
    height: displayHeight
    visible: true

    // this will provide automatic adaption to screen size and orientation
    property int orientationOverride: 0  // -90 , 0 , 90, 180
    readonly property bool orientationPortrait: Math.abs(orientationOverride % 180) == 90


    Rectangle {
        id: view

        anchors.centerIn: parent

        // this will provide automatic adaption to screen size and orientation
        width: (targetARM && orientationPortrait) ? base.height : base.width;
        height: (targetARM && orientationPortrait) ? base.width : base.height;
        rotation: parent.orientationOverride


        // add your GUI code below this line

        color: "gray"

        Hand {
            source: playerHandView;
        }

        // a simple exit-button in the top-right corner
        Rectangle {
            width: 120;  height: 100
            anchors.right: parent.right
            anchors.top: parent.top
            color: "grey"
            Text {
                anchors.centerIn: parent
                text: "Exit"
            }
            MouseArea {
                anchors.fill: parent
                onClicked: { Qt.quit(); }
            }
        }
    }
}
