import "dart:async";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyecto/main.dart';

class AgregarProductos extends StatefulWidget {
  @override
  ProductoApp createState() => ProductoApp();
}
class ProductoApp extends State<AgregarProductos> {
  DateTime selectedDate = DateTime.now();
  var passwordHide = true;
  var ojo = Icons.visibility;
  TextEditingController producto = TextEditingController();
  TextEditingController precio = TextEditingController();
  TextEditingController cantidad = TextEditingController();
  TextEditingController descripcion = TextEditingController();

  final firebase = FirebaseFirestore.instance;

  insertProduct() async {
    try {
      await firebase.collection("Productos").doc().set({
        "Producto": producto.text,
        "Precio": precio.text,
        "Cantidad": cantidad.text,
        "Descripcion": descripcion.text,
        "estado": 'A'
      });
      mensajeGeneral('Guardado', 'Se agrego el producto correctamente');
    } catch (e) {
      mensajeGeneral('Error', e.toString());
      print('Error -->' + e.toString());
    }
  }

  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Agregar Producto"),
             backgroundColor: Colors.amber[300],
        ),

        body: SingleChildScrollView(
          child: Column(
              children: <Widget>[
                Padding(padding: const EdgeInsets.only(top: 20.8),
                  child: Center(
                    child: Container(
                      width: 200,
                      height: 60,
                      child: Image.asset(
                        'imgs/Regis.png',
                        width: 300, //ancho
                        height: 100, //alto
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                Padding(padding: const EdgeInsets.only(
                    left: 15.8, top: 8, right: 15, bottom: 8),
                  child: TextField(
                    controller: producto,
                    autofocus: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                      labelText: 'Producto',
                      hintText: 'Ingrese nombre del producto',

                    ),
                  ),
                ),

                Padding(padding: const EdgeInsets.only(
                    left: 15.8, top: 8, right: 15, bottom: 8),
                  child: TextField(
                    controller: precio,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      labelText: 'Precio',
                      hintText: 'Agrege el precio',
                    ),
                  ),
                ),

                Padding(padding: const EdgeInsets.only(
                  left: 15.8, top: 8, right: 15, bottom: 8),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: cantidad,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      labelText: 'Cantidad',
                      hintText: 'Agrege la cantidad',
                    ),
                  ),
                ),

                Padding(padding: const EdgeInsets.only(
                  left: 15.8, top: 8, right: 15, bottom: 8),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: descripcion,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                        ),
                        labelText: 'Descripcion',
                        hintText: 'Agrege una pequeña descripcion',
                      ),
                    ),
                  ),

                  Container(
                    height: 55, //alto
                    width: 240, //ancho
                    decoration: BoxDecoration( //boton de registro
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20)),
                      child: TextButton(
                        onPressed: () {
                          insertProduct();
                        },
                        child: Text(
                          'Agregar',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                    ),
                  ),
                ]),
              ),
            ),
          );
        }

void mensajeGeneral(String titulo, String mess) {
    showDialog(
        context: context,
        builder: (buildcontext) {
          return AlertDialog(
            title: Text(titulo),
            content: Text(mess),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    producto.clear();
                    precio.clear();
                    cantidad.clear();
                    descripcion.clear();
                  },
                  child:
                  Text("Aceptar"),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(40, 75, 99, 1.0),
                      shadowColor: const Color.fromRGBO(60, 110, 113, 1.0),
                      elevation: 15,
                      minimumSize: Size(150, 40)
                  )
              )
            ],
          );
        });
  }
}

