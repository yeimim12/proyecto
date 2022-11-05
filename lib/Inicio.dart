import "dart:async";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:proyecto/main.dart';
import 'Rest.dart';
//Registrar usuario
class Inicio extends StatefulWidget {
  @override
  InicioApp createState() => InicioApp();

}
class InicioApp extends State<Inicio> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.green),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Página principal"),
        ),
        body: SingleChildScrollView(
          child: Column(
              children: <Widget>[
          Padding(padding: const EdgeInsets.only(top: 68.8),
          child: Center(
            child: Container(
              width: 400, //ancho
              height: 240,  //alto
              child: Image.asset(
                'imgs/frutas.jpg',
                width: 240, //ancho
                height: 100, //alto
                fit: BoxFit.cover,

              ),
              ),

            ),
          ),






    ]),

      ),
    ),
    );
  }

}