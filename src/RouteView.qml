import QtQuick 2.0
import QtPositioning 5.5
import QtLocation 5.6
import QtQuick.Window 2.0
Rectangle {
    Map {
         anchors.fill: parent
         plugin: mapboxglPlugin
         center: QtPositioning.coordinate(59.86, 17.64)
         zoomLevel: 14

        RouteQuery {
            id: currentRouteQuery
            waypoints: [QtPositioning.coordinate(59.86, 17.64), QtPositioning.coordinate(59.84, 17.648)] //Uppsala centrum till polacksbacken
        }

        RouteModel {
            id: routeModel
            query: currentRouteQuery
        }

        MapItemView {
            model: routeModel
            delegate: routeDelegate
        }

        Component {
            id: routeDelegate

            MapRoute {
                route: routeData
                line.color: "blue"
                line.width: 5
                smooth: true
                opacity: 0.8
            }
        }
    }
}
