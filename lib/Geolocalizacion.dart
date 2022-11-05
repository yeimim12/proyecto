import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Geolocalizacion extends StatefulWidget {
  final String idUser;
  Geolocalizacion(this.idUser);
  @override
  GeolocalizacionApp createState() => GeolocalizacionApp();
}

class GeolocalizacionApp extends State<Geolocalizacion> {
  @override
  String currentLocation = '';
  late Position position;
  String localizacion = '';
  TextEditingController local = TextEditingController();
  double latitud = 0;
  double longitud = 0;
  String coordenadas = '';
  String nombreUser = '';

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (serviceEnabled) {
    } else {
      await Geolocator.openLocationSettings();
    }
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    print(await Geolocator.getCurrentPosition());

    return await Geolocator.getCurrentPosition();
  }

  buscarUsuario() async {
    try {
      CollectionReference ref = FirebaseFirestore.instance.collection("User");
      print('*----1----');
      QuerySnapshot usuario = await ref.get();
      if (usuario.docs.length != 0) {
        print('*----2----');
        for (var cursor in usuario.docs) {
          if (widget.idUser == cursor.id) {
            nombreUser = await cursor.get('NombreUsuario');
            print('----------------00000  ' + nombreUser);
          }
        }
      }
    } catch (e) {
      //mensajeGeneral('Error', e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    /* setState(() async {
      nombreUser=await widget.idUser;
      buscarUsuario();
    });*/
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Bienvenido ' + nombreUser),
        actions: [
          FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.quiz_outlined),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(color: Colors.teal[50]),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(Icons.location_on),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Location',
                              ),
                              (currentLocation != null)
                                  ? Text(currentLocation)
                                  : Container(),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.purple,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    textStyle: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold)),
                onPressed: () async {
                  local.text = (await _determinePosition()).toString();
                },
                child: Text("Get Location"),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  enabled: false,
                  controller: local,
                  decoration: InputDecoration(
                    fillColor: Colors.green,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Localización',
                    hintText: 'Localización',
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.green[50],
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    textStyle: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold)),
                onPressed: () async {
                  // String _coordenadas = (await _determinePosition()).toString();
                  // print(await (_coordenadas) + "********");
                  // coordenadas = _coordenadas
                  //      .replaceAll("Latidude:", "")
                  //    .replaceAll("Longitude:", "");
                  // print(coordenadas);
                  local.text = (await _determinePosition())
                      .toString()
                      .replaceAll("Latitude: ", "")
                      .replaceAll("Longitude: ", "");

                }, child: null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}