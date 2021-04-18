import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaPage extends StatefulWidget {
  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {

  // https://pub.dev/packages/google_maps_flutter/versions/1.0.6
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {

    final ScanModel scan = ModalRoute.of(context).settings.arguments;

    final CameraPosition _puntoInicial = CameraPosition(
        target: scan.getLatLng(),
        zoom: 17,
      );

    return Scaffold(
      appBar: AppBar(title: Text('Mapa'),),
      body:  GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _puntoInicial,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
