import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

import Todo 1.0

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

        ColumnLayout {
            anchors.centerIn: parent

            Frame {
                Layout.fillWidth: true

                ListView {
                    anchors.fill: parent
                    // Note: implicit = automatically resize
                    implicitWidth: 250
                    implicitHeight: 250
                    // Note: clips overflowing list elements
                    clip: true

                    model: TodoModel {
                        list: todoList
                    }

                    delegate: RowLayout {
                        CheckBox {
                            checked: model.done
                            onClicked: model.done = checked
                        }
                        TextField {
                            Layout.fillWidth: true
                            text: model.description
                            onEditingFinished: model.description = text
                        }
                    }
                }
            }


            RowLayout {
                Button {
                    Layout.fillWidth: true
                    text: "Add new item"
                    onClicked: todoList.appendItem()
                }
                Button {
                    Layout.fillWidth: true
                    text: "Remove completed items"
                    onClicked: todoList.removeCompletedItem()
                }
            }
        }
    }
}
