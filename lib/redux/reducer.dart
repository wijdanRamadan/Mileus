import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mileus/redux/actions.dart';
import 'package:mileus/redux/app_state.dart';
import 'package:latlong2/latlong.dart';

AppState appReducer(AppState state, dynamic action) {
  if (action is MapClearAction) {
    return AppState.clearAppState(state);
  }
  if (action is ShowMarkerAction) {
    state.layers.add(showMarker(action));
    return state.copywith(state.layers, state.origin, state.destination);
  }
  if (action is ShowRouteAction) {
    state.layers.add(showRoute(action.routePoints));
    return state.copywith(state.layers, state.origin, state.destination);
  }

  if (action is UpdateOriginAction) {
    return state.copywith(state.layers, action.origin, state.destination);
  }

  if (action is UpdateDestinationAction) {
    return state.copywith(state.layers, state.origin, action.destination);
  }

  return state;
}

MarkerLayerOptions showMarker(ShowMarkerAction action) {
  List<Marker> markers = [];
  markers.add(
    Marker(
      width: 80.0,
      height: 80.0,
      point: action.markerLatlng,
      builder: (ctx) => const Icon(
        Icons.person_pin_circle_outlined,
        color: Colors.blue,
      ),
    ),
  );
  return MarkerLayerOptions(markers: markers);
}

PolylineLayerOptions showRoute(List<LatLng> points) {
  return PolylineLayerOptions(
    polylines: [
      Polyline(
          points: points,
          color: Colors.blue,
          borderColor: Colors.blue,
          borderStrokeWidth: 2.0,
          strokeWidth: 2)
    ],
  );
}

MarkerLayerOptions showCurrentLocation() {
  List<Marker> markers = [];
  Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best,
          forceAndroidLocationManager: true)
      .then((Position position) {
    markers.add(
      Marker(
        width: 80.0,
        height: 80.0,
        point: LatLng(position.latitude, position.longitude),
        builder: (ctx) => const Icon(
          Icons.person_pin_circle_outlined,
          color: Colors.blue,
        ),
      ),
    );
  }).catchError((e) {});
  return MarkerLayerOptions(markers: markers);
}
