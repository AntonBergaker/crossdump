import QtQuick 2.9
import com.crossdump.navigator 1.0
import com.crossdump.navigationtask 1.0
import com.crossdump.navigationsegment 1.0
import QtQuick.Window 2.9
import QtLocation 5.11
import QtPositioning 5.11
import QtQuick.Controls 1.4
import com.crossdump.fpscounter 1.0

Item {
    id: base
    width: displayWidth
    height: displayHeight
    visible: true

    // this will provide automatic adaption to screen size and orientation
    property int orientationOverride: 0  // -90 , 0 , 90, 180
    readonly property bool orientationPortrait: Math.abs(orientationOverride % 180) == 90

    NavigationTask {
        id: task
    }

    Navigator {
        id: navigator;
    }

    Plugin {
        id: mapboxPlugin
        name: "mapboxgl"
        PluginParameter {
            name: "mapbox.access_token"
            value: "pk.eyJ1IjoiY2Fsdml0b24iLCJhIjoiY2s4anVncTFtMDRhcDNmbWtveXpua2kzbSJ9.mkdCbAYVquQK_uljD4_p0A"
        }
        PluginParameter {
            name: "mapboxgl.access_token"
            value: "pk.eyJ1IjoiY2Fsdml0b24iLCJhIjoiY2s4anVncTFtMDRhcDNmbWtveXpua2kzbSJ9.mkdCbAYVquQK_uljD4_p0A"
        }
        PluginParameter {
            name: "mapboxgl.mapping.additional_style_urls"
            value: "mapbox://styles/calviton/cka3oanhl0lif1iqqj01o9z6r"
        }
    }

    Rectangle {
        anchors.centerIn: parent
        width: (targetARM && orientationPortrait) ? base.height : base.width;
        height: (targetARM && orientationPortrait) ? base.width : base.height;
        rotation: parent.orientationOverride

        Rectangle {
            id: view
            property Item view: mapView
            width: parent.width
            height: parent.height
            anchors.left: parent.left
            anchors.top: parent.top
            MapView {
                id: mapView
                visible: view.view === this
                anchors.fill: parent
            }
        }
    }

    FPSCounter {
        id: fpsCounter
        width: 100
        height: 100
    }
    Text {
        text: fpsCounter.fps
    }
}
