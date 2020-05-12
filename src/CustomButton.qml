import QtQuick 2.9
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Button {
    id: customButton
    property string backgroundColor: "#fff"
    style: ButtonStyle {
        background: Rectangle {
            implicitWidth: 100
            implicitHeight: 25
            color: customButton.backgroundColor
        }
    }
}
