import 'package:flutter/material.dart';
import 'package:proyecto/Vista/AgregarProducto.dart';
import 'package:proyecto/Vista/ListadoUsuariosR.dart';
import 'package:proyecto/Vista/PaginaPrincipal.dart';


class Admin extends StatefulWidget {
  MenuAdmin  createState() => MenuAdmin();
}

class MenuAdmin extends State<Admin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido al menu del Administrador '),
        backgroundColor: Colors.amber[300],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10, top: 40, right: 10, bottom: 0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber, minimumSize: Size(400, 50)),
                onPressed: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ListadoUsuariosR())
                  );
                },
                child: Text(
                  'Administrar Usuarios',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 10, top: 40, right: 10, bottom: 0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber, minimumSize: Size(400, 50)),
                onPressed: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AgregarProductos())
                  );
                },
                child: Text(
                  'Agregar Productos',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 10, top: 40, right: 10, bottom: 0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber, minimumSize: Size(400, 50)),
                onPressed: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PaginaPrincipal())
                  );
                },
                child: Text(
                  'Mis utiles escolares',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}