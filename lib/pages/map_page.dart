import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:latlong2/latlong.dart';
import 'package:mileus/redux/actions.dart';
import 'package:mileus/redux/app_state.dart';
import 'package:mileus/redux/reducer.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final store = Store<AppState>(appReducer,
      initialState: AppState.initialState(), middleware: [thunkMiddleware]);
  TextEditingController originLatTextFieldController = TextEditingController();
  TextEditingController destinationLatTextFieldController =
      TextEditingController();

  TextEditingController originLngTextFieldController = TextEditingController();

  TextEditingController destinationLngTextFieldController =
      TextEditingController();
  MapController mapController = MapController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
        store: store,
        child: Scaffold(
          appBar: AppBar(),
          body: StoreConnector<AppState, List<LayerOptions>>(
            distinct: true,
            builder: (context, layers) {
              return FlutterMap(
                mapController: mapController,
                layers: layers,
                options: MapOptions(
                  center: LatLng(50.023474, 14.514984),
                  zoom: 10.0,
                ),
              );
            },
            converter: (store) => store.state.layers,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: TextFormField(
                                  controller: originLatTextFieldController,
                                  onFieldSubmitted:
                                      store.state.origin.latitude != 0.0
                                          ? (value) {}
                                          : (value) {
                                              store.state.origin.latitude =
                                                  double.parse(value);
                                              if (store
                                                      .state.origin.longitude !=
                                                  0.0) {
                                                store.dispatch(ShowMarkerAction(
                                                    markerLatlng:
                                                        store.state.origin));
                                                mapController.move(
                                                    store.state.origin, 10.0);
                                              }
                                            },
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (store.state.origin.latitude == 0.0) {
                                      if ((value == null || value.isEmpty)) {
                                        return 'Please enter a value';
                                      } else if (!(double.parse(value) >=
                                              -90.0 &&
                                          double.parse(value) <= 90.0)) {
                                        return 'value must be between -90 and 90';
                                      }
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'origin latitude',
                                  )),
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: originLngTextFieldController,
                                onFieldSubmitted:
                                    store.state.origin.longitude != 0.0
                                        ? (value) {}
                                        : (value) {
                                            store.state.origin.longitude =
                                                double.parse(value);
                                            if (store.state.origin.latitude !=
                                                0.0) {
                                              store.dispatch(ShowMarkerAction(
                                                  markerLatlng:
                                                      store.state.origin));
                                              mapController.move(
                                                  store.state.origin, 10.0);
                                            }
                                          },
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (store.state.origin.longitude == 0.0) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a value';
                                    } else if (!(double.parse(value) >= -90.0 &&
                                        double.parse(value) <= 90.0)) {
                                      return 'value must be between -90 and 90';
                                    }
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Origin longitude'),
                              ),
                            ),
                            FloatingActionButton(
                                child: const Icon(Icons.gps_fixed),
                                onPressed: () {
                                  store.dispatch(getUserLocation());
                                  Navigator.pop(context);
                                }),
                            const SizedBox(
                              height: 16,
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: destinationLatTextFieldController,
                                onFieldSubmitted: (value) {
                                  store.state.destination.latitude =
                                      double.parse(value);
                                  if (store.state.destination.longitude ==
                                      0.0) {
                                    store.dispatch(ShowMarkerAction(
                                        markerLatlng: store.state.destination));
                                    mapController.move(
                                        store.state.destination, 10.0);
                                  }
                                },
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a value';
                                  }
                                  if (!(double.parse(value) >= -90.0 &&
                                      double.parse(value) <= 90.0)) {
                                    return 'value must be between -90 and 90';
                                  }

                                  return null;
                                },
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Destination latitude'),
                              ),
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: destinationLngTextFieldController,
                                keyboardType: TextInputType.number,
                                onFieldSubmitted: (value) {
                                  store.state.destination.longitude =
                                      double.parse(value);
                                  if (store.state.destination.latitude == 0.0) {
                                    store.dispatch(ShowMarkerAction(
                                        markerLatlng: store.state.destination));
                                    mapController.move(
                                        store.state.destination, 10.0);
                                  }
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a value';
                                  }
                                  if (!(double.parse(value) >= -90.0 &&
                                      double.parse(value) <= 90.0)) {
                                    return 'value must be between -90 and 90';
                                  }

                                  return null;
                                },
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Destination longitude'),
                              ),
                            ),
                            ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    store.dispatch(MapClearAction());
                                    store.dispatch(ShowMarkerAction(
                                        markerLatlng: store.state.origin));
                                    store.dispatch(ShowMarkerAction(
                                        markerLatlng: store.state.destination));
                                    store.dispatch(getRoute(store.state.origin,
                                        store.state.destination));
                                    Navigator.pop(context);
                                  }
                                },
                                child: const Text('Search'))
                          ],
                        ),
                      ),
                    );
                  });
            },
          ),
        ));
  }
}
