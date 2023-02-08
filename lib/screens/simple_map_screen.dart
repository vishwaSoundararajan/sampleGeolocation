import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'
    '';
class SimpleMapScreen extends StatefulWidget {
  const SimpleMapScreen({Key? key}) : super(key: key);

  @override
  State<SimpleMapScreen> createState() => _SimpleMapScreenState();
}

class _SimpleMapScreenState extends State<SimpleMapScreen> {
  Completer<GoogleMapController> _controller= Completer();

  static const CameraPosition initialPosition= CameraPosition(target :LatLng(13.0473,80.0945), zoom:14.0);
  static const CameraPosition targetPosition= CameraPosition(target: LatLng(13.061140,80.282480),zoom:14.0,bearing:192.0,tilt:60);
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text("Simple Google Map"),
        centerTitle: true,
      ),
      body:GoogleMap(
        initialCameraPosition: initialPosition,
        mapType:MapType.normal,
        onMapCreated:(GoogleMapController controller){
          _controller.complete(controller);
        }
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed:(){
            goToLake();
          },
          label: const Text("To the Lake !"),
          icon:const Icon(Icons.directions_boat),
      ),
    );
  }
  Future<void> goToLake() async{
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(targetPosition));
  }
}
