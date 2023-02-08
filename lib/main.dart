import 'package:flutter/material.dart';
import 'package:geolocation/screens/current_location_screen.dart';
import 'package:geolocation/screens/learning.dart';
import 'package:geolocation/screens/search_places_screen.dart';
import 'package:geolocation/screens/simple_map_screen.dart';

void main() {
  runApp(const Learning());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(

          title: const Text("Flutter Google Maps"),
        ),
        body: SizedBox(
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: Column(
              children: [
                ElevatedButton(
                    onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder:(BuildContext context){
                   return const SimpleMapScreen();
                    }));
                    },
                    child: const Text("Simple Map")
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder:(BuildContext context){
                        return const CurrentLocationScreen();
                      }));
                    },
                    child: const Text("Current Location")
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder:(BuildContext context){
                        return const SearchPlacesScreen();
                      }));
                    },
                    child: const Text("Search PLaces")
                )
              ],
            )
        )
    );
  }
}