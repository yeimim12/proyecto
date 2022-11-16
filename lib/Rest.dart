import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';

class ConsumoApi extends StatefulWidget {
  @override
  State<ConsumoApi> createState() => _ConsumoApiState();
}

class _ConsumoApiState extends State<ConsumoApi> {
  final controllerid = TextEditingController();
  final controllernombre = TextEditingController();
  final controllerapellido = TextEditingController();
  final controllergenero = TextEditingController();

  consumirGet(var id) async {
    print(id);
    try {
      Response response =
      await get(Uri.parse('https://49df-2800-484-1389-c224-ccc8-6d95-33a4-ea8d.ngrok.io/api/index.php?id='+id));
      Map data = jsonDecode(response.body);
      //print(data);
      //print(response.statusCode.toString() + " Código de respuesta");
      if (response.statusCode.toString() == '200') {
        controllernombre.text = '${data['0']['nombre']}';
        controllerapellido.text = '${data['0']['apellido']}';
        controllergenero.text = '${data['0']['genero']}';

      }else{

      }

    }catch(e){
      print('ERROR: '+e.toString());

    }

  }

  @override
  Widget build(BuildContext context) {
    const TextField_EdgeInsets = EdgeInsets.only(left: 20, top: 10, right: 20);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar'),
        backgroundColor: Colors.amber[300]
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Imagen
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Center(
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.asset('images/Login.jpg'),
                  // Attribution: "https://www.flaticon.com/free-icons/user" User icons created by Freepik - Flaticon
                ),
              ),
            ),
            // TextField 'ID'
            Padding(
              padding: TextField_EdgeInsets,
              child: TextField(
                controller: controllerid,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Número de documento',
                    hintText: 'Elija su número de documento'),
              ),
            ),
            // Button Consultar
            Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom( //boton huella
                    minimumSize: Size(50, 50),
                    primary: Colors.amber,
                  ),
                  onPressed: () => {consumirGet(controllerid.text)},
                  child: const Text('Registrarse'),
                ),
              ),
            ),
            // TextField 'Nombre'
            Padding(
              padding: TextField_EdgeInsets,
              child: TextField(
                controller: controllernombre,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Nombre',
                    hintText: 'Nombre'),
              ),
            ),
            // TextField 'No'
            Padding(
              padding: TextField_EdgeInsets,
              child: TextField(
                controller: controllerapellido,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Correo',
                    hintText: 'Correo'),
              ),
            ),
            Padding(
              padding: TextField_EdgeInsets,
              child: TextField(
                controller: controllergenero,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Genero',
                    hintText: 'Genero'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}