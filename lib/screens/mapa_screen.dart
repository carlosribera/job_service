import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import '../widgets/widgets.dart';

import 'package:location/location.dart';

class MapaScreen extends StatefulWidget {
  const MapaScreen({super.key});

  @override
  State<MapaScreen> createState() => _MapaScreenState();
}

class _MapaScreenState extends State<MapaScreen> {
  late UserProvider? userProvider;

  // Locations
  Location location = Location();
  late StreamSubscription<LocationData> listen;
  double? latitude;
  double? longitude;

  // Maps
  GoogleMapController? _controller;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  late Marker userMarker;

  @override
  void initState() {
    configLocation();
    super.initState();
  }

  configLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    location.enableBackgroundMode(enable: true);

    _locationData = await location.getLocation();
    latitude = _locationData.latitude;
    longitude = _locationData.longitude;

    listen = location.onLocationChanged.listen((LocationData currentLocation) {
      latitude = _locationData.latitude;
      longitude = _locationData.longitude;
      if (userProvider != null) {
        userProvider!.setUserLocation(latitude!, longitude!);
      }
      final latLng = LatLng(latitude!, longitude!);
      if (_controller != null) {
        _controller!.animateCamera(CameraUpdate.newLatLngZoom(latLng, 17));
      }

      markers[const MarkerId('userMarker')] =
          Marker(markerId: const MarkerId('userMarker'), position: latLng);
      setState(() {});
    });
    listen.resume();
  }

  @override
  void dispose() {
    if(userProvider!=null){
      userProvider!.updateUsuario(userProvider!.user.toJson());
    }
    listen.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context);
    final user = userProvider!.user;

    return Scaffold(
      drawer: const AppDrawer(),
      appBar: getAppBar(context, 'Mapa', userProvider!.user),
      // body: Center(child: Text('Bienvenid@ $name a la aplicacion.')),
      body: GoogleMap(
        markers: Set<Marker>.of(markers.values),
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
        initialCameraPosition: CameraPosition(target: LatLng(user.latitude!, user.longitude!)),
      ),
    );
  }
}
