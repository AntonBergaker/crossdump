import QtQuick 2.6

Rectangle {
    width: 200;
    height: 300;
    color: "#00000000"


    Image {
        source: "sprites/cards/CardFront.png"
    }
    Image {
        source: "sprites/cards/" + model.colorImageSource
    }
    Image {
        source: "sprites/cards/King.png"
    }

    Text {
        text: model.topLetter;
        anchors.top: parent.top;
        anchors.left: parent.left;
        anchors.margins: 24;
        font.pixelSize: 20;
    }

}
