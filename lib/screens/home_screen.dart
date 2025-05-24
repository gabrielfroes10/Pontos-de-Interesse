import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import '../providers/poi_provider.dart';
import 'add_poi_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) return;
    }

    final position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentPosition = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    final poiProvider = Provider.of<POIProvider>(context);

    return Scaffold(
  appBar: AppBar(title: const Text('Pontos de Interesse')),
  body: _currentPosition == null
    ? const Center(child: CircularProgressIndicator())
    : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              onPressed: _getCurrentLocation,
              icon: const Icon(Icons.my_location),
              label: const Text("Atualizar Localização"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Latitude: ${_currentPosition!.latitude.toStringAsFixed(6)}\n'
              'Longitude: ${_currentPosition!.longitude.toStringAsFixed(6)}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: poiProvider.points.length,
              itemBuilder: (ctx, i) {
                final poi = poiProvider.points[i];
                final distance = Geolocator.distanceBetween(
                  _currentPosition!.latitude,
                  _currentPosition!.longitude,
                  poi.latitude,
                  poi.longitude,
                );
                return ListTile(
                  title: Text(poi.name),
                  subtitle: Text(
                      '${poi.description}\nDistância: ${distance.toStringAsFixed(2)} m'),
                );
                },
              ),
            ),
          ],
        ),
  floatingActionButton: FloatingActionButton(
    onPressed: () {
      Navigator.of(context).pushNamed(AddPOIScreen.routeName);
    },
    child: const Icon(Icons.add_location),
  ),
);
  }
}