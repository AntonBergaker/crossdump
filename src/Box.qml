
import QtQuick 2.0
import QtGraphicalEffects 1.0
import QtQuick 2.9
import QtQuick.Window 2.9
import QtLocation 5.11
import QtPositioning 5.11
import QtQuick.Controls 1.4
import com.crossdump.navigationsegment 1.0
import com.crossdump.zone 1.0
import com.crossdump.route 1.0


Rectangle {
    id: boxInstance
    signal leftClicked
    signal rightClicked
    property string headerText: ""
    property string headerIconSource: ""

    property bool footer: false

    property bool leftButtonVisible: false
    property alias leftButtonText: textLeftButton.text
    property alias leftButtonColor: leftButton.backgroundColor

    property bool rightButtonVisible: false
    property alias rightButtonText: textRightButton.text
    property alias rightButtonColor: rightButton.backgroundColor

    height: parent.height
    width: 450

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
        source: headerIconSource
        width: 32
        height: 32
        anchors.top: parent.top
        anchors.topMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 8
    }

    Text {
        font.family: base.font
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 45
        font.pixelSize: 20
        text: headerText
        color: "#707070"
    }
    // Header end

    // Footer start

    Rectangle {
        visible: footer
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 120
        anchors.left: parent.left
        height: 1
        width: parent.width
        color: "#C4C4C4"
    }

    /* Left button */
    CustomButton{
        id:leftButton
        visible: leftButtonVisible
        width: 140
        height: 70
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.leftMargin: 30
        anchors.bottomMargin: 20
        backgroundColor: "#e7e7e7"

        Text {
            id: textLeftButton
            anchors.centerIn: parent
            font.pixelSize: 18
            font.bold: true
            font.family: base.font
        }

        MouseArea{
            anchors.fill: parent
            onClicked: {
              leftClicked();
            }
        }
    }

    CustomButton{
        id:rightButton
        visible: rightButtonVisible
        width: 140
        height: 70
        anchors.bottom: parent.bottom
        anchors.right:parent.right
        anchors.rightMargin: 30
        anchors.bottomMargin: 20

        Text {
            id: textRightButton
            anchors.centerIn: parent
            font.pixelSize: 18
            font.bold: true
            font.family: base.font
            color: parent.parent.rightButtonColor==="#ff8e00" ? "#000" : "#fff"
        }

        MouseArea{
            anchors.fill: parent
            onClicked: {
              rightClicked();
            }
        }
    }

    // Main thing end
}
