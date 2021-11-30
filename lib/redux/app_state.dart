import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class AppState {
  final List<LayerOptions> layers;
  final LatLng origin;
  final LatLng destination;
  const AppState(
      {required this.layers, required this.origin, required this.destination});

  factory AppState.initialState() => AppState(layers: [
        TileLayerOptions(
            urlTemplate:
                "https://api.mapbox.com/styles/v1/wijdan/ckw0sds8k93z614m334h3qp20/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoid2lqZGFuIiwiYSI6ImNqZG41NXdoejA5czcyd2tnbTVmNG1ieWMifQ.IpTC9KTdQQ1jumo4Pud7dQ",
            additionalOptions: {
              'accessToken':
                  'pk.eyJ1Ijoid2lqZGFuIiwiYSI6ImNqZG41NXdoejA5czcyd2tnbTVmNG1ieWMifQ.IpTC9KTdQQ1jumo4Pud7dQ',
              'id': 'mapbox.mapbox-streets-v8'
            })
      ], origin: LatLng(0.0, 0.0), destination: LatLng(0.0, 0.0));
//clear map view - remove old markers and route
  factory AppState.clearAppState(AppState state) => AppState(layers: [
        TileLayerOptions(
            urlTemplate:
                "https://api.mapbox.com/styles/v1/wijdan/ckw0sds8k93z614m334h3qp20/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoid2lqZGFuIiwiYSI6ImNqZG41NXdoejA5czcyd2tnbTVmNG1ieWMifQ.IpTC9KTdQQ1jumo4Pud7dQ",
            additionalOptions: {
              'accessToken':
                  'pk.eyJ1Ijoid2lqZGFuIiwiYSI6ImNqZG41NXdoejA5czcyd2tnbTVmNG1ieWMifQ.IpTC9KTdQQ1jumo4Pud7dQ',
              'id': 'mapbox.mapbox-streets-v8'
            })
      ], origin: state.origin, destination: state.destination);
  AppState copywith(
      List<LayerOptions> layers, LatLng origin, LatLng destination) {
    return AppState(layers: layers, origin: origin, destination: destination);
  }
}
