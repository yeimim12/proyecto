import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:proyecto/DTO/UsuariosDTO.dart';
import 'package:proyecto/Rest.dart';
import 'package:proyecto/main.dart';

class Soporte extends StatefulWidget {
  const Soporte({Key? key}) : super(key: key);

  @override
  SoporteApp  createState() => SoporteApp();
}

class SoporteApp extends State<Soporte> {

  final firebase = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(217, 217, 217, 1.0),
      appBar: AppBar(
        title: Text('Mis Utiles Escolares'),
        backgroundColor: Color(0xFFFFD54F),
      actions: [
          IconButton(
            onPressed: () async {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => MyApp()));
            },
            icon: const Icon(Icons.exit_to_app_outlined),
          )
        ],
      ),
      drawer: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                  accountName: Text('Bienvenido'),
                  accountEmail: Text('acb@gmail.com'),
              ),
              ListTile(
                title: Text('Servicio rest'),
                leading: Icon(Icons.settings),
                onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_) => ConsumoApi()));
                },
              ),
              ListTile(
                title: Text('Tienda'),
                leading: Icon(Icons.shopping_cart_sharp),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_) => Soporte()));
                },
              )
            ],

          ),

        ),
      body: Container(
        child: Center(
          child: StreamBuilder(
            stream:
            FirebaseFirestore.instance.collection("ProductosR").snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return CircularProgressIndicator();
              return ListView.builder(
                itemCount: snapshot.data!.docs.length, // define las iteraciones
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        padding:
                                        const EdgeInsets.only(bottom: 10),
                                        child: Text(
                                          snapshot.data!.docs[index].get("Producto"),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: Color(0xFFFFC107)
                                          ),
                                        )
                                    ),                                    
                                    Text(
                                      snapshot.data!.docs[index].get("Descripcion"),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Colors.black
                                      ),
                                    ),
                                    Text(
                                      'Precio: '+ snapshot.data!.docs[index].get("Precio"),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Colors.black
                                      ),
                                    ),
                                    Text(
                                      'Cantidad: '+ snapshot.data!.docs[index].get("Cantidad"),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Colors.black
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
      floatingActionButton: const FloatingActionButton(
          child: const Icon(Icons.shopping_cart_sharp),
          backgroundColor: Color(0xFFFFC107),
          onPressed: null,
    )
    );
  }
}