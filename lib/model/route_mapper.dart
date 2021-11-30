class Routes {
  final Geometry geometry;
  Routes({required this.geometry});
  factory Routes.fromJson(Map<String, dynamic> json) {
    var list = json['routes'] as List;

    return Routes(geometry: Geometry.fromJson(list.first));
  }
}

class Geometry {
  final Coordinates coordinates;
  Geometry({required this.coordinates});

  factory Geometry.fromJson(Map<String, dynamic> json) {
    return Geometry(coordinates: Coordinates.fromJson(json['geometry']));
  }
}

class Coordinates {
  final List<List<double>> points;

  Coordinates({required this.points});

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    List<List<double>> points = [];
    var list = json['coordinates'] as List;

    list.forEach((element) {
      points.add(element.cast<double>());
    });
    return Coordinates(points: points);
  }
}

class Point {
  List<double> point;

  Point({required this.point});

  factory Point.fromJson(Map<String, dynamic> json) {
    var point = json as List;
    return Point(point: point.cast());
  }
}
