
import 'package:flutter/material.dart';
import 'package:proyecto/main.dart';
import 'package:flutter/cupertino.dart';
import 'Rest.dart';
/*void main(){
  runApp(MaterialApp(
    routes: {
      '/Rest' : (context) => Rest(),
    },
  ));
}*/

class Soporte extends StatefulWidget{
  @override
  soporteT createState () => soporteT();

}
class soporteT extends State<Soporte> {
  //const soporteT({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.green),

      home: Scaffold(
        appBar: AppBar(
          title: const Text("Bienvenido a Agristore"),
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
                  Navigator.push(context, MaterialPageRoute(builder: (_) => Soporte()));
                },
              )
            ],

          ),

        ),
        body:ListView(
          padding: EdgeInsets.all(30),
          children: <Widget> [
            ListTile(
              leading: Image.asset('imgs/mnz.png'), // establecer imagen
              title: Text('Manzana Verde',
                  style: TextStyle(  // Establecer estilo de título
                      fontSize: 23,
                      fontWeight: FontWeight.w500
                  )
              ),
              subtitle: Text('Unidad -> 1.000'),
            ),
            ListTile(
              leading: Image.asset('imgs/mnz2.png'), // establecer imagen
              title: Text('Manzana Roja',
                  style: TextStyle(  // Establecer estilo de título
                      fontSize: 23,
                      fontWeight: FontWeight.w500
                  )
              ),
              subtitle: Text('Unidad -> 1.000'),
            ),
            ListTile(
              leading: Image.asset('imgs/bna.png'), // establecer imagen
              title: Text('Banano',
                  style: TextStyle(  // Establecer estilo de título
                      fontSize: 23,
                      fontWeight: FontWeight.w500
                  )
              ),
              subtitle: Text('Docena -> 5.000'),
            ),
            ListTile(
              leading: Image.asset('imgs/uva.png'), // establecer imagen
              title: Text('Uva',
                  style: TextStyle(  // Establecer estilo de título
                      fontSize: 23,
                      fontWeight: FontWeight.w500
                  )
              ),
              subtitle: Text('Docena -> 2.500'),
            ),
            ListTile(
              leading: Image.asset('imgs/broco.png'), // establecer imagen
              title: Text('Brocoli',
                  style: TextStyle(  // Establecer estilo de título
                      fontSize: 23,
                      fontWeight: FontWeight.w500
                  )
              ),
              subtitle: Text('Unidad -> 2.000'),
            ),
            ListTile(
              leading: Image.asset('imgs/fre.png'), // establecer imagen
              title: Text('Fresa',
                  style: TextStyle(  // Establecer estilo de título
                      fontSize: 23,
                      fontWeight: FontWeight.w500
                  )
              ),
              subtitle: Text('Docena -> 2.000'),
            )
          ],

        ),
        floatingActionButton: const FloatingActionButton(
          child: const Icon(Icons.shopping_cart_sharp),
          onPressed: null,
        ),
      ),
    );


  }
}
