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

        color: "#444444"

        Rectangle {
            id: topRow
            width: parent.width
            height: parent.height/20
            anchors.left: parent.left
            anchors.top: parent.top
            color: "#bbbbbb"
            Rectangle {
                id: rand
                width: parent.width/20;  height: parent.height
                anchors.right: de.left
                anchors.leftMargin: 2
                anchors.rightMargin: 2
                property bool isPressed: false
                property bool vertical: false
                property string color1: "white"
                property string color2: "white"
                property string color3: "white"
                anchors.top: parent.top
                color: isPressed ? "green" : "white"
                Text {
                    anchors.centerIn: parent
                    text: "Random"
                }
                MouseArea {
                    id: randMA
                    anchors.fill: parent
                    onClicked: {
                        parent.isPressed = !parent.isPressed
                        parent.vertical = Math.random() >= 0.5
                        parent.color1 = Qt.hsla(Math.random(),Math.random(),Math.random(),1)
                        parent.color2 = Qt.hsla(Math.random(),Math.random(),Math.random(),1)
                        parent.color3 = Qt.hsla(Math.random(),Math.random(),Math.random(),1)
                    }
                }
            }
            Rectangle {
                id: de
                width: parent.width/20;  height: parent.height
                anchors.right: fr.left
                property bool isPressed: false
                anchors.top: parent.top
                anchors.leftMargin: 2
                anchors.rightMargin: 2
                color: isPressed ? "green" : "white"
                Text {
                    anchors.centerIn: parent
                    text: "Germany"
                }
                MouseArea {
                    id: deMA
                    anchors.fill: parent
                    onClicked: {parent.isPressed = !parent.isPressed}
                }
            }
            Rectangle {
                id: fr
                width: parent.width/20;  height: parent.height
                anchors.right: it.left
                anchors.top: parent.top
                anchors.leftMargin: 2
                anchors.rightMargin: 2
                property bool isPressed: false
                color: isPressed ? "green" : "white"
                Text {
                    anchors.centerIn: parent
                    text: "France"
                }
                MouseArea {
                    id: frMA
                    anchors.fill: parent
                    onClicked: {parent.isPressed = !parent.isPressed}
                }
            }
            Rectangle {
                id: it
                width: parent.width/20;  height: parent.height
                anchors.right: exit.left
                anchors.top: parent.top
                anchors.leftMargin: 2
                property bool isPressed: false
                color: isPressed ? "green" : "white"
                Text {
                    anchors.centerIn: parent
                    text: "Italy"
                }
                MouseArea {
                    id: itMA
                    anchors.fill: parent
                    onClicked: {parent.isPressed = !parent.isPressed}
                }
            }
            Rectangle {
                id: exit
                width: parent.width/20;  height: parent.height
                anchors.right: parent.right
                anchors.top: parent.top
                color: "red"
                Text {
                    anchors.centerIn: parent
                    text: "X"
                }
                MouseArea {
                    id: exitMA
                    anchors.fill: parent
                    onClicked: { Qt.quit(); }
                }
            }
        }

        Rectangle{
            id: main
            anchors.top: topRow.bottom
            anchors.left: parent.left
            width: parent.width
            height:parent.height-topRow.height
            color: "#333333"
            Flag {
                id: italy
                visible: it.isPressed
                Rectangle {
                    id: itLeft
                    width: parent.width/3;  height: parent.height
                    anchors.left: parent.left
                    anchors.top: parent.top
                    color: "red"
                }
                Rectangle {
                    id: itMiddle
                    width: parent.width/3;  height: parent.height
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    color: "white"
                }
                Rectangle {
                    id: itRight
                    width: parent.width/3;  height: parent.height
                    anchors.right: parent.right
                    anchors.top: parent.top
                    color: "green"
                }
            }
            Flag {
                id: france
                visible: fr.isPressed
                Rectangle {
                    id: frLeft
                    width: parent.width/3;  height: parent.height
                    anchors.left: parent.left
                    anchors.top: parent.top
                    color: "blue"
                }
                Rectangle {
                    id: frMiddle
                    width: parent.width/3;  height: parent.height
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    color: "white"
                }
                Rectangle {
                    id: frRight
                    width: parent.width/3;  height: parent.height
                    anchors.right: parent.right
                    anchors.top: parent.top
                    color: "red"
                }
            }
            Flag {
                id: germany
                visible: de.isPressed
                Rectangle {
                    width: parent.width;  height: parent.height/3
                    anchors.left: parent.left
                    anchors.top: parent.top
                    color: "black"
                }
                Rectangle {
                    width: parent.width;  height: parent.height/3
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    color: "red"
                }
                Rectangle {
                    width: parent.width;  height: parent.height/3
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    color: "yellow"
                }
            }
            Flag {
                id: random
                visible: rand.isPressed
                Rectangle {
                    id: topLeft
                    width: rand.vertical ? parent.width/3 : parent.width
                    height: rand.vertical ? parent.height : parent.height/3
                    anchors.left: parent.left
                    anchors.top: parent.top
                    color: rand.color1
                }
                Rectangle {
                    width: rand.vertical ? parent.width/3 : parent.width
                    height: rand.vertical ? parent.height : parent.height/3
                    anchors.left: rand.vertical ? topLeft.right : parent.left
                    anchors.top: rand.vertical ? parent.top : topLeft.bottom
                    color: rand.color2
                }
                Rectangle {
                    width: rand.vertical ? parent.width/3 : parent.width
                    height: rand.vertical ? parent.height : parent.height/3
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    color: rand.color3
                }
            }
        }
    }
}
