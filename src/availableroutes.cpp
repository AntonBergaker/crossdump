#include "availableroutes.h"
#include "navigator.h"

#include <climits>

AvailableRoutes::AvailableRoutes(QObject *parent)
    : QObject(parent), routeList_(), navigationTaskRoutes_(), routeZoneDistances_(),
      numCalculatedZoneDistances_(0), totalZoneDistances_(0)
{
}

AvailableRoutes::~AvailableRoutes()
{
}

void AvailableRoutes::updateRoutes(QGeoCoordinate currentLocation)
{
    QList<QGeoCoordinate> svartBackenTrash = QList<QGeoCoordinate>();
    svartBackenTrash.append(QGeoCoordinate(59.871749, 17.626814));
    svartBackenTrash.append(QGeoCoordinate(59.871135, 17.627174));
    svartBackenTrash.append(QGeoCoordinate(59.872576, 17.628881));
    svartBackenTrash.append(QGeoCoordinate(59.872057, 17.628982));
    svartBackenTrash.append(QGeoCoordinate(59.871605, 17.629222));
    svartBackenTrash.append(QGeoCoordinate(59.872576, 17.629599));
    svartBackenTrash.append(QGeoCoordinate(59.877239, 17.620151));
    svartBackenTrash.append(QGeoCoordinate(59.872037, 17.620264));

    QList<QGeoCoordinate> svartBackenBound = QList<QGeoCoordinate>();
    svartBackenBound.append(QGeoCoordinate(59.87021238370366, 17.627726211570376));
    svartBackenBound.append(QGeoCoordinate(59.87120329200191, 17.616739883431194));
    svartBackenBound.append(QGeoCoordinate(59.87848340826979, 17.618370666494172));
    svartBackenBound.append(QGeoCoordinate(59.87503739808607, 17.631245269785268));
    svartBackenBound.append(QGeoCoordinate(59.87167719422931, 17.632704391481298));

    Zone *svartbacken = new Zone(svartBackenTrash, svartBackenBound, QString("Svartbäcken"));

    QList<QGeoCoordinate> gamlaUppsalaTrash = QList<QGeoCoordinate>();
    gamlaUppsalaTrash.append(QGeoCoordinate(59.898706, 17.639026));
    gamlaUppsalaTrash.append(QGeoCoordinate(59.898089, 17.634557));
    gamlaUppsalaTrash.append(QGeoCoordinate(59.897326, 17.633420));
    gamlaUppsalaTrash.append(QGeoCoordinate(59.896910, 17.636785));
    gamlaUppsalaTrash.append(QGeoCoordinate(59.894180, 17.638513));
    gamlaUppsalaTrash.append(QGeoCoordinate(59.892899, 17.638623));
    gamlaUppsalaTrash.append(QGeoCoordinate(59.891629, 17.638677));

    QList<QGeoCoordinate> gamlaUppsalaBound = QList<QGeoCoordinate>();
    gamlaUppsalaBound.append(QGeoCoordinate(59.888897889832926,17.6378910388172  ));
    gamlaUppsalaBound.append(QGeoCoordinate(59.8919549665608  ,17.63171122926059 ));
    gamlaUppsalaBound.append(QGeoCoordinate(59.899747086908334,17.630595430298428));
    gamlaUppsalaBound.append(QGeoCoordinate(59.9000053579462  ,17.64158175843761 ));
    gamlaUppsalaBound.append(QGeoCoordinate(59.8957005785114  ,17.642783388083274));
    gamlaUppsalaBound.append(QGeoCoordinate(59.89001741535533 ,17.640723451564384));

    Zone *gamlaUppsala = new Zone(gamlaUppsalaTrash, gamlaUppsalaBound, QString("Gamla Uppsala"));

    QList<QGeoCoordinate> arstaTrash = QList<QGeoCoordinate>();
    arstaTrash.append(QGeoCoordinate(59.867470, 17.699388));
    arstaTrash.append(QGeoCoordinate(59.866712, 17.700339));
    arstaTrash.append(QGeoCoordinate(59.868323, 17.700968));
    arstaTrash.append(QGeoCoordinate(59.867885, 17.702753));
    arstaTrash.append(QGeoCoordinate(59.867004, 17.702690));
    arstaTrash.append(QGeoCoordinate(59.866223, 17.704891));
    arstaTrash.append(QGeoCoordinate(59.865035, 17.706990));
    arstaTrash.append(QGeoCoordinate(59.865268, 17.708397));

    QList<QGeoCoordinate> arstaBound = QList<QGeoCoordinate>();
    arstaBound.append(QGeoCoordinate(59.86722153582051 , 17.70735420225037 ));
    arstaBound.append(QGeoCoordinate(59.86941892502596 , 17.70126022337726 ));
    arstaBound.append(QGeoCoordinate(59.867523146849614, 17.69645370483323 ));
    arstaBound.append(QGeoCoordinate(59.86282632180076 , 17.70383514403548 ));
    arstaBound.append(QGeoCoordinate(59.86541181215437 , 17.710100784314136));

    Zone *arsta = new Zone(arstaTrash, arstaBound, QString("Årsta"));

    QList<QGeoCoordinate> ekebyTrash = QList<QGeoCoordinate>();
    ekebyTrash.append(QGeoCoordinate(59.852012, 17.608212));
    ekebyTrash.append(QGeoCoordinate(59.850702, 17.610547));
    ekebyTrash.append(QGeoCoordinate(59.849049, 17.607078));
    ekebyTrash.append(QGeoCoordinate(59.848890, 17.609047));

    QList<QGeoCoordinate> ekebyBound = QList<QGeoCoordinate>();
    ekebyBound.append(QGeoCoordinate(59.85367137609983, 17.60761512754229 ));
    ekebyBound.append(QGeoCoordinate(59.84832592175753, 17.602980270365208));
    ekebyBound.append(QGeoCoordinate(59.84737744501927, 17.610533370972973));
    ekebyBound.append(QGeoCoordinate(59.85211955845607, 17.613709106454024));

    Zone *ekeby = new Zone(ekebyTrash, ekebyBound, QString("Ekeby"));

    QList<QGeoCoordinate> atervinningsstationTrash = QList<QGeoCoordinate>();
    atervinningsstationTrash.append(QGeoCoordinate(59.846355, 17.680110));

    QList<QGeoCoordinate> atervinningsstationBound = QList<QGeoCoordinate>();
    atervinningsstationBound.append(QGeoCoordinate(59.84749956784321 , 17.678795471201767));
    atervinningsstationBound.append(QGeoCoordinate(59.846809752129396, 17.68291534423949 ));
    atervinningsstationBound.append(QGeoCoordinate(59.84469710256237 , 17.681370391859986));
    atervinningsstationBound.append(QGeoCoordinate(59.84547319349722 , 17.676220550543547));

    Zone *atervinningsstation = new Zone(atervinningsstationTrash, atervinningsstationBound, QString("Återvinningsstation"));

    // Recreate the routes every time.
    for (Route *route : routeList_) {
        delete route;
    }
    routeList_.clear();

    routeList_.append(new Route({svartbacken, gamlaUppsala, arsta}, QString("Route 1")));

    routeList_.append(new Route({arsta, ekeby, atervinningsstation}, QString("Route 2")));

    routeList_.append(new Route({svartbacken, ekeby}, QString("Route 3")));

    routeList_.append(new Route({ekeby, gamlaUppsala, arsta, svartbacken, atervinningsstation}, QString("Route 66")));

    emit routeListChanged(routeList());

    // Comment out this line for manual zone order for each route.
    OptimizeRoutes(currentLocation);
}

void AvailableRoutes::OptimizeRoutes(QGeoCoordinate currentLocation)
{
    navigationTaskRoutes_.clear();
    routeZoneDistances_.clear();
    navigationTaskZones_.clear();
    userZoneDistances_.clear();

    // Calculate how many distance combinations have to be computed.
    // This makes it easy to check whether all asynchronous requests have
    // been completed.
    totalZoneDistances_ = 0;
    numCalculatedZoneDistances_ = 0;
    for (Route *&route : routeList_) {
        QList<Zone*> &zones = route->zones();
        for (int i = 0; i < zones.size(); ++i) {
            for (int j = i + 1; j < zones.size(); ++j) {
                if (i == j) {
                  continue;
                }
                // All pairs of zones.
                ++totalZoneDistances_;
            }

            // The user and every zone.
            ++totalZoneDistances_;
        }
    }

    Navigator *navigator = new Navigator(this);

    // Route optimization.
    for (Route *&route : routeList_) {
        QList<Zone*> &zones = route->zones();

        for (int i = 0; i < zones.size(); ++i) {
            Zone *zone1 = zones[i];
            for (int j = i + 1; j < zones.size(); ++j) {
                if (i == j) {
                    continue;
                }
                Zone *zone2 = zones[j];

                NavigationTask *zoneTask = new NavigationTask(this);
                connect(zoneTask ,
                        SIGNAL(resultChanged(Navigation*)),
                        this,
                        SLOT(ZoneRouteCalculated(Navigation*)));
                QGeoCoordinate start = zone1->averagePoint();
                QGeoCoordinate end = zone2->averagePoint();

                navigationTaskRoutes_[zoneTask] = route;
                Route::ZoneDistance zoneDistance(zone1, zone2, 0);
                routeZoneDistances_[route][zoneTask] = zoneDistance;

                // Make an asynchronous request for calculating the distance.
                // The result is handled in ZoneRouteCalculated below.
                navigator->navigateWithStartEnd(zoneTask, start, end);
            }

            NavigationTask *userZoneTask = new NavigationTask(this);
            connect(userZoneTask,
                    SIGNAL(resultChanged(Navigation*)),
                    this,
                    SLOT(UserZoneRouteCalculated(Navigation*)));
            QGeoCoordinate start = currentLocation;
            QGeoCoordinate end = zone1->averagePoint();

            navigationTaskZones_[userZoneTask] = zone1;
            userZoneDistances_[zone1] = 0;

            // Make an asynchronous request for calculating the distance.
            // The result is handled in UserZoneRouteCalculated below.
            navigator->navigateWithStartEnd(userZoneTask, start, end);
        }
    }
}

void AvailableRoutes::ZoneRouteCalculated(Navigation* reply)
{
    if (reply == nullptr) {
        return;
    }
    NavigationTask *task = (NavigationTask*)sender();
    Q_ASSERT(task->result() != nullptr);

    Route *route = navigationTaskRoutes_[task];
    Route::ZoneDistance *zoneDistance = &routeZoneDistances_[route][task];
    zoneDistance->time = task->result()->travelTime();

    ++numCalculatedZoneDistances_;
    bool allRoutesDone = numCalculatedZoneDistances_ >= totalZoneDistances_;
    if (allRoutesDone) {
        OptimizeRoutesWithZoneDistances();
    }
}

void AvailableRoutes::UserZoneRouteCalculated(Navigation* reply)
{
    if (reply == nullptr) {
        return;
    }
    NavigationTask *task = (NavigationTask*)sender();
    Q_ASSERT(task->result() != nullptr);

    Zone *zone = navigationTaskZones_[task];
    userZoneDistances_[zone] = task->result()->travelTime();

    ++numCalculatedZoneDistances_;
    bool allRoutesDone = numCalculatedZoneDistances_ >= totalZoneDistances_;
    if (allRoutesDone) {
        OptimizeRoutesWithZoneDistances();
    }
}

void AvailableRoutes::OptimizeRoutesWithZoneDistances()
{
    for (Route *route : routeList_) {
        std::vector<Route::ZoneDistance> zoneDistances;
        zoneDistances.reserve(routeZoneDistances_[route].size());
        for (auto keyValue : routeZoneDistances_[route]) {
            zoneDistances.push_back(keyValue.second);
        }

        Zone *nearestZone = nullptr;
        int nearestZoneDistance = INT_MAX;
        for (auto keyValue : userZoneDistances_) {
            Zone *zone = keyValue.first;
            int distance = keyValue.second;

            bool zoneIsInRoute = false;
            for (Zone *routeZone : route->zones()) {
                if (routeZone == zone) {
                    zoneIsInRoute = true;
                    break;
                }
            }

            if (zoneIsInRoute && distance < nearestZoneDistance) {
                nearestZoneDistance = distance;
                nearestZone = zone;
            }
        }

        route->OptimizeOrder(zoneDistances, nearestZone);
    }

    emit routeListChanged(routeList());
}
