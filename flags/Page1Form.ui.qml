import QtQuick 2.9
import QtQuick.Controls 2.2

Page {
    id: page
    width: 600
    height: 400

    header: Label {
        text: qsTr("Page 1")
        font.pixelSize: Qt.application.font.pixelSize * 2
        padding: 10
    }

    Rectangle {
        id: bgrect
        x: 151
        y: -3
        width: 300
        height: 300
        color: "#dddddd"

        MouseArea {
            id: bgrectMouseArea
            x: 20
            y: -24
            anchors.fill: parent
        }
    }

    Image {
        id: icon
        x: 171
        y: -27
        width: 259
        height: 348
        source: "dataEngineIcon.svg"
        fillMode: Image.PreserveAspectFit
    }

}

/*##^## Designer {
    D{i:7;anchors_height:100;anchors_width:100}
}
 ##^##*/
