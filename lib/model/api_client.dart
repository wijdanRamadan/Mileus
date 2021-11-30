import 'dart:convert';

import 'package:mileus/model/route_mapper.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart';

class ApiClient {
  static Future<Routes> getRoute(LatLng origin, LatLng destination) async {
    var response = await get(Uri.parse(
        'https://router.project-osrm.org/route/v1/driving/${origin.longitude.toString()},${origin.latitude.toString()};${destination.longitude.toString()},${destination.latitude.toString()}?overview=full&geometries=geojson&annotations=distance'));

    return Routes.fromJson(jsonDecode(response.body));
  }
}
