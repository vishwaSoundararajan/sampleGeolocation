import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CurrentLocationScreen extends StatefulWidget {
  const CurrentLocationScreen({Key? key}) : super(key: key);

  @override
  State<CurrentLocationScreen> createState() => _CurrentLocationScreenState();
}

class _CurrentLocationScreenState extends State<CurrentLocationScreen> {
late GoogleMapController googleMapController;
static const CameraPosition initialCameraPosition =CameraPosition(target: LatLng(37.4279613,-122.08574),zoom:14);
Set<Marker> markers={};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User current Location"),
            centerTitle: true,
      ),
      body: GoogleMap(
        initialCameraPosition: initialCameraPosition,
        markers: markers,
        zoomControlsEnabled: false,
        mapType: MapType.normal,
        onMapCreated:(GoogleMapController controller){
          googleMapController = controller;
        }
      ),
    floatingActionButton:FloatingActionButton.extended(
      onPressed: () async{
        Position position = await _determinePosition();
      googleMapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(position.latitude,position.longitude),zoom: 16)));
        markers.clear();
      markers.add(Marker(markerId: MarkerId("current Location"),position: LatLng(position.latitude,position.longitude)));
      },
      label: const Text("current location"),
      icon:const Icon(Icons.location_history),
    )
    );
  }
  Future<Position> _determinePosition() async{
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled=await Geolocator.isLocationServiceEnabled();
    if(!serviceEnabled){
      return Future.error("Loction Service not enaled");
    }
    permission= await Geolocator.checkPermission();
    if(permission==LocationPermission.denied){
      permission=await Geolocator.requestPermission();
      if(permission == LocationPermission.denied){
        return Future.error("Location Permission denied");
      }
    }
    if(permission == LocationPermission.deniedForever){
      return Future.error("Location permission are permenantly denied");
    }
    Position position =await Geolocator.getCurrentPosition();
    return position;
  }
}
