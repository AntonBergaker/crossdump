import QtQuick 2.9
import com.crossdump.navigator 1.0
import com.crossdump.navigationtask 1.0
import com.crossdump.navigationsegment 1.0
import QtQuick.Window 2.9
import QtLocation 5.11
import QtPositioning 5.11
import QtQuick.Controls 1.4

Item {
    id: base
    width: displayWidth
    height: displayHeight
    visible: true

    Theme {
        id: dayTheme
        background: "#FFFFFF"
        text: "#111111"
        weakText: "#636363"
        strongText: "#000000"
        selected: "#DDDDDD"
        secondSelected: "#E7E7E7"
        main: "#FF8E00"
        button: "#FFFFFF"
        disabledButton: "#999999"
        border: "#C4C4C4"
    }

    Theme {
        id: nightTheme
        background: "#333333"
        text: "#F3F3F3"
        weakText: "#B3B3B3"
        strongText: "#FFFFFF"
        selected: "#555555"
        secondSelected: "#444444"
        main: "#FF8E00"
        button: "#565656"
        disabledButton: "#222222"
        border: "#000000"
    }


    property var theme: dayTheme

    // this will provide automatic adaption to screen size and orientation
    property int orientationOverride: 0  // -90 , 0 , 90, 180
    readonly property bool orientationPortrait: Math.abs(orientationOverride % 180) == 90

    property string font: "Helvetica"
    property bool nightMode: false
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
            value: "pk.eyJ1IjoiY2Fsdml0b24iLCJhIjoiY2s4anVjejFlMGRvMDNsbjYxa2w0YWhlYiJ9.Ke_LEN3--vioiy_T8dqDjw"
        }
        PluginParameter {
            name: "mapboxgl.access_token"
            value: "pk.eyJ1IjoiY2Fsdml0b24iLCJhIjoiY2s4anVjejFlMGRvMDNsbjYxa2w0YWhlYiJ9.Ke_LEN3--vioiy_T8dqDjw"
        }
        //day
        PluginParameter {
            id: mapStyle
            name: "mapboxgl.mapping.additional_style_urls"
            value: "mapbox://styles/calviton/cka3oanhl0lif1iqqj01o9z6r,mapbox://styles/calviton/ckaqge6mf4muu1ipkjjjgf6i4"
        }
        //night
        /*PluginParameter {
            name: "mapboxgl.mapping.additional_style_urls"
            value: "mapbox://styles/calviton/ckaqge6mf4muu1ipkjjjgf6i4"
        }*/
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
}
