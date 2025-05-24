import 'package:flutter/material.dart';
import '../models/poi.dart';

class POIProvider with ChangeNotifier {
  final List<POI> _points = [];

  List<POI> get points => _points;

  void addPoint(POI poi) {
    _points.add(poi);
    notifyListeners();
  }
}