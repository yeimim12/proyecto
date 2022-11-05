import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
//import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'login.dart';


class Rest extends StatefulWidget {
 // final String location;
  //Rest(this.location);
  @override
  RestD createState() => RestD();
}

class RestD extends State<Rest> {
  TextEditingController id=TextEditingController();
  TextEditingController nombre=TextEditingController();
  TextEditingController telefono=TextEditingController();
  TextEditingController email=TextEditingController();
  var dataHttp='';

  consumirGet(var id) async {
    try {
      http.Response response =
      await http.get(Uri.http('localhost//localhost/WebService/WebService/index.php?id=4'));
      print(response.body);

      Map data = jsonDecode(response.body);

      print(data);
      print(response.statusCode.toString()+ " Código de respuesta");
      nombre.text = '${data[0]['nombre']}';
      telefono.text = '${data[0]['telefono']}';
      email.text = '${data[0]['email']}';
    }

    catch (e) { print("error------"+ e.toString());};
  }

  consumirPost()async{
    http.Response response = await http.post(Uri.http('http://localhost/WebService/WebService/index.php'),

        body: {
          'nombre':'a',
          'telefono':'a',
          'email':'a',
        }
    );
    if (response.statusCode == 200) {
      print("Se envio krnal");
    } else {
      print("No se envio krnal");
    }

    // List data = jsonDecode(response.body);
    // print(data);
    dataHttp= await response.body.toString();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.green),
      home: Scaffold(
      appBar: AppBar(
        title: Text('Consumir servicio'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: id,
                  decoration: InputDecoration(
                    fillColor: Colors.green,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'ID',
                    hintText: 'Digite id de usuario',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () {
                    consumirGet(id.text);
                          //BDDDDD
                  },
                  child: Text('GET'),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () {
                    consumirPost();
                  },
                  child: Text('POST'),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  enabled: false,
                  controller: nombre,
                  decoration: InputDecoration(
                    fillColor: Colors.green,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Nombre',
                    hintText: 'Nombre',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  enabled: false,
                  controller: telefono,
                  decoration: InputDecoration(
                    fillColor: Colors.green,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Teléfono',
                    hintText: 'teléfono',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  enabled: false,
                  controller: email,
                  decoration: InputDecoration(
                    fillColor: Colors.green,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Email',
                    hintText: 'Email',
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(10),
                  child: Text("Datos "+dataHttp))
            ],
          ),
        ),
      ),
    ),
    );
  }
}