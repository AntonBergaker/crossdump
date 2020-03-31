import QtQuick 2.6

import QtQuick.Window 2.0
import QtLocation 5.6
import QtPositioning 5.6
import QtQuick.Controls 1.4

Item {
    id: base
    width: displayWidth
    height: displayHeight
    visible: true

    // this will provide automatic adaption to screen size and orientation
    property int orientationOverride: 0  // -90 , 0 , 90, 180
    readonly property bool orientationPortrait: Math.abs(orientationOverride % 180) == 90

    Plugin {
        id: mapboxglPlugin
        name: "mapboxgl"
    }

    Rectangle {
        anchors.centerIn: parent
        width: (targetARM && orientationPortrait) ? base.height : base.width;
        height: (targetARM && orientationPortrait) ? base.width : base.height;
        rotation: parent.orientationOverride

        Rectangle {
            id: menu
            color: "#666"
            anchors.top: parent.top
            anchors.right: parent.right
            height: parent.height
            width: 60

            Column {
                width: parent.width
                height: parent.height
                spacing: 5
                padding: 5

                Button {
                    width: parent.width
                    height: 50
                    text: "Route"
                    onClicked: view.view = routeView
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.margins: 5
                }

                Button {
                    width: parent.width
                    height: 50
                    text: "Map"
                    onClicked: view.view = mapView
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.margins: 5
                }

                Button {
                    width: parent.width
                    height: 50
                    text: "Nav"
                    onClicked: view.view = navigationView
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.margins: 5
                }
            }
        }

        Rectangle {
            id: view
            property Item view: mapView
            width: parent.width - menu.width
            height: parent.height
            anchors.left: parent.left
            anchors.top: parent.top

            Rectangle {
                id: routeView
                anchors.fill: parent
                visible: view.view === this
            }

            Rectangle {
                id: mapView
                anchors.fill: parent
                visible: view.view === this

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
                    }
                }

                Rectangle {
                    height: parent.height
                    width: parent.width * 1 / 3
                    anchors.right: parent.right
                }
            }

            Rectangle {
                id: navigationView
                anchors.fill: parent
                visible: view.view === this

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
                    }
                }

                Rectangle {
                    height: parent.height
                    width: parent.width * 3
                    anchors.right: parent.right
                }
            }
        }
    }
}
