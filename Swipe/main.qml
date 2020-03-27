import QtQuick 2.9
import QtQuick.Controls 2.2

ApplicationWindow {
    visible: true
    width: 1280
    height: 800
    title: qsTr("Tabs")

    SwipeView {
        id: view
        currentIndex: 0
        anchors.fill: parent
        Item {
            id: firstPage
            DropArea{
                anchors.fill: parent
                Rectangle{
                    anchors.fill: parent
                    id: firstPageBG
                    color: "#222222"
                    Rectangle{
                        anchors.centerIn: parent
                        height: view.height/5
                        width: height
                        Drag.active: dragArea.drag.active
                        Drag.hotSpot.x:x+(height/2)
                        Drag.hotSpot.y:y+(width/2)
                        color: "#7777ff"
                        Text {
                            id: name1
                            text: qsTr("This is the firstpage")
                            anchors.centerIn: parent
                        }
                        MouseArea{
                            id:dragArea
                            anchors.fill: parent
                            drag.target: parent
                        }
                    }
                }
            }
        }
        Item {
            id: secondPage
            Rectangle{
                anchors.fill: parent
                id: secondPpageBG
                color: "#555555"
                Rectangle{
                    color: qtrgba(0,0,0,0)
                    id: emptyRectangle
                    height: view.height
                    width: view.width
                    Rectangle{
                        id: myRectangle
                        anchors.centerIn: parent
                        height: view.height/5
                        width: height
                        color: "#ff7777"
                        Text {
                            id: name2
                            text: qsTr("This is the second page")
                            anchors.centerIn: parent
                        }
                    }
                }
            }
        }
        Item {
            id: thirdPage
            Rectangle{
                anchors.fill: parent
                id: thirdPageBG
                color: "#999999"
                Rectangle{
                    anchors.centerIn: parent
                    height: parent.height/5
                    width: height
                    color: "#77ff77"
                    Text {
                        id: name3
                        text: qsTr("This is the third page")
                        anchors.centerIn: parent
                    }
                }
            }
        }
    }

}
