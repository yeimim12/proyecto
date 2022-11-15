import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:proyecto/DTO/ProductoDTO.dart';
import 'package:proyecto/DTO/UsuariosDTO.dart';
import 'package:proyecto/Rest.dart';
import 'package:proyecto/main.dart';

class PaginaPrincipal extends StatefulWidget {
  @override
  Pagina_PrincipalApp  createState() => Pagina_PrincipalApp();
}

class Pagina_PrincipalApp extends State<PaginaPrincipal> {
  productoDTO productoObjeto = productoDTO();


  TextEditingController producto = TextEditingController();
  TextEditingController precio= TextEditingController();
  TextEditingController descripcion = TextEditingController();  
  TextEditingController cantidad = TextEditingController();
  TextEditingController id = TextEditingController();

  final firebaseDatabase = FirebaseFirestore.instance;
  DateTime selectedDate = DateTime.now();
  var _currentSelectedDate;
  
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
                    Navigator.push(context, MaterialPageRoute(builder: (_) => Rest()));
                },
              ),
              ListTile(
                title: Text('Tienda'),
                leading: Icon(Icons.shopping_cart_sharp),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_) => PaginaPrincipal()));
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
                                              color: Color(0xFFFFCA28)
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

                              IconButton(
                                onPressed: () {
                                  productoObjeto.idProducto=snapshot.data!.docs[index].id;
                                  productoObjeto.nombreProducto=snapshot.data!.docs[index].get("Producto");
                                  productoObjeto.descripcionProducto=snapshot.data!.docs[index].get("Descripcion");
                                  productoObjeto.precioProducto=snapshot.data!.docs[index].get("Precio");
                                  productoObjeto.cantidadProducto=snapshot.data!.docs[index].get("Cantidad");

                                  mensajeEditar(productoObjeto.idProducto,productoObjeto.nombreProducto,productoObjeto.descripcionProducto,productoObjeto.precioProducto,productoObjeto.cantidadProducto);
                                },
                                icon: const Icon(Icons.edit),
                              ),
                              IconButton(
                                onPressed: () {
                                  productoObjeto.idProducto=snapshot.data!.docs[index].id;
                                  productoObjeto.nombreProducto=snapshot.data!.docs[index].get("Producto");
                                  productoObjeto.descripcionProducto=snapshot.data!.docs[index].get("Descripcion");
                                  productoObjeto.cantidadProducto=snapshot.data!.docs[index].get("Cantidad");
                                  productoObjeto.precioProducto=snapshot.data!.docs[index].get("Precio");
                                  productoObjeto.estadoProducto=snapshot.data!.docs[index].get("Estado");
                                  deleteProduct(productoObjeto.idProducto, productoObjeto.nombreProducto, productoObjeto.precioProducto, productoObjeto.cantidadProducto, productoObjeto.descripcionProducto,productoObjeto.estadoProducto);
                                },
                                icon: const Icon(Icons.delete_rounded),
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
      
    );
  }

   void mensajeEditar(String idE,String productoE, String descripcionE ,String precioE,String cantidadE) {

    producto.text = productoE;
    descripcion.text = descripcionE;
    precio.text = precioE;
    cantidad.text = cantidadE;
    id.text = idE;

    showDialog(
        context: context,
        builder: (buildcontext) {
          return AlertDialog(
            title: Text('Editar Producto'),
            content: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: producto,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      fillColor: Colors.grey,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      labelText: 'Producto',
                      hintText: 'Nombre del producto',
                      labelStyle: TextStyle(color: Colors.black),
                      hintStyle: TextStyle(color: Colors.black),
                      prefixIcon: const Icon(
                        Icons.shopping_bag_outlined,
                        color: Color(0xFFFFD54F),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromRGBO(40, 75, 99, 1.0)),
                      ),
                    ),
                  ),
                ),
                
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: precio,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      fillColor: Colors.grey,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      labelText: 'Precio',
                      hintText: 'Precio del producto',
                      labelStyle: TextStyle(color: Colors.black),
                      hintStyle: TextStyle(color: Colors.black),
                      prefixIcon: const Icon(
                        Icons.monetization_on_outlined,
                        color: Color(0xFFFFD54F),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFFFD54F)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: cantidad,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      fillColor: Colors.grey,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      labelText: 'Cantidad',
                      hintText: 'Unidades del producto',
                      labelStyle: TextStyle(color: Colors.black),
                      hintStyle: TextStyle(color: Colors.black),
                      prefixIcon: const Icon(
                        Icons.add_chart_outlined,
                        color: Color(0xFFFFD54F),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFFFD54F)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: descripcion,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      fillColor: Colors.grey,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      labelText: 'Descripcion',
                      hintText: 'Descripcion del producto',
                      labelStyle: TextStyle(color: Colors.black),
                      hintStyle: TextStyle(color: Colors.black),
                      prefixIcon: const Icon(
                        Icons.edit_attributes,
                        color: Color(0xFFFFD54F),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFFFD54F)),
                      ),
                    ),
                  ),
                ),
                ],
            ),
            actions: <Widget>[
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: ElevatedButton(
                        onPressed: () {
                           editProduct(id.text,  producto.text, precio.text, cantidad.text, descripcion.text);
                          Navigator.of(context).pop();
                        },
                        child:
                        Text("Aceptar"),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFFFCA28),
                            shadowColor: Color(0xFFFFD54F),
                            elevation: 15,
                            minimumSize: Size(100, 40)
                        )
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(left: 30),
                    child:                   ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child:
                        Text("Cerrar"),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFFFCA28),
                            shadowColor: Color(0xFFFFD54F),
                            elevation: 15,
                            minimumSize: Size(100, 40)
                        )
                    ),
                  ),
                ],
              ),
            ],
          );
        });
  }

  editProduct(String id,String producto, String precio, String cantidad, String descripcion) async{
    try{
      await firebaseDatabase
          .collection("ProductosR")
          .doc(id)
          .set({
        "Producto":producto,
        "Descripcion":descripcion,
        "Precio":precio,
        "Cantidad":cantidad,  
        "estado": 'A',
      });
      mensajeGeneral('Editado', 'Se actualizó la información del usuario');
    }catch(e){
      print('ERROR-> '+e.toString());
    }
  }

  deleteProduct(String idC, String productoC, String precioC, String cantidadC, String descripcionC, String estadoC) async{
    try{
      await firebaseDatabase
          .collection("ProductosR")
          .doc(idC)
          .set({
        "Producto":productoC,
        "Precio":precioC,
        "Cantidad":cantidadC,
        "Descripcion":descripcionC,
        "estado": estadoC,
      });
  
    }catch(e){
      print('ERROR-> '+e.toString());
    }
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
                      backgroundColor: Color(0xFFFFCA28),
                      shadowColor: Color(0xFFFFD54F),
                      elevation: 15,
                      minimumSize: Size(150, 40)
                  )
              )
            ],
          );
        });
  }
}