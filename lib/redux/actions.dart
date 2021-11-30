import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:mileus/model/api_client.dart';
import 'package:mileus/redux/app_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

class ShowMarkerAction {
  final LatLng markerLatlng;
  ShowMarkerAction({required this.markerLatlng});
}

class ShowRouteAction {
  final List<LatLng> routePoints;

  ShowRouteAction({required this.routePoints});
}

class GetRouteAction {
  final LatLng origin;
  final LatLng destination;

  GetRouteAction({required this.origin, required this.destination});
}

class MapClearAction {}

class UpdateOriginAction {
  final LatLng origin;
  UpdateOriginAction({required this.origin});
}

class UpdateDestinationAction {
  final LatLng destination;

  UpdateDestinationAction({required this.destination});
}

ThunkAction<AppState> getRoute(LatLng origin, LatLng destination) {
  List<LatLng> points = [];

  return (Store<AppState> store) {
    ApiClient.getRoute(origin, destination).then((value) {
      for (List<double> point in value.geometry.coordinates.points) {
        points.add(LatLng(point[1], point[0]));
      }
      store.dispatch(ShowRouteAction(routePoints: points));
    });
  };
}

ThunkAction<AppState> getUserLocation() {
  return (Store<AppState> store) {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      store.dispatch(UpdateOriginAction(
          origin: LatLng(position.latitude, position.longitude)));
      store.dispatch(ShowMarkerAction(markerLatlng: store.state.origin));
    });
  };
}
