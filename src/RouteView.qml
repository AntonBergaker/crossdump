import QtQuick 2.0

import QtQuick.Window 2.0
import QtLocation 5.6
import QtPositioning 5.6

Rectangle {
    Rectangle {
        height: parent.height
        width: parent.width * 2 / 3
        anchors.left: parent.left
        anchors.top: parent.top

        Map {
            anchors.fill: parent
            plugin: mapboxglPlugin
            center: QtPositioning.coordinate(59.86, 17.64)
            zoomLevel: 14

            MapPolyline {
                line.width: 3
                line.color: 'green'
                path: [
                    { latitude: -27, longitude: 153.0 },
                    { latitude: -27, longitude: 154.1 },
                    { latitude: -28, longitude: 153.5 },
                    { latitude: -29, longitude: 153.5 }
                ]
            }
        }
    }

    Rectangle {
        height: parent.height
        width: parent.width * 1 / 3
        anchors.right: parent.right

        Text {
            text: "Routes"
        }
    }
}
