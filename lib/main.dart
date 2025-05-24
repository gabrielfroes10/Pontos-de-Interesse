import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'screens/add_poi_screen.dart';
import 'providers/poi_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => POIProvider(),
      child: MaterialApp(
        title: 'Pontos de Interesse',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        routes: {
          '/': (ctx) => const HomeScreen(),
          AddPOIScreen.routeName: (ctx) => const AddPOIScreen(),
        },
      ),
    );
  }
}