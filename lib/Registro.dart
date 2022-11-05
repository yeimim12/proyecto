import "dart:async";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyecto/main.dart';
import 'passRegister.dart';

class Registro extends StatefulWidget {
  @override
  RegistroApp createState() => RegistroApp();
}
class RegistroApp extends State<Registro> {
  DateTime selectedDate = DateTime.now();
  var passwordHide = true;
  var ojo = Icons.visibility;
  TextEditingController User = TextEditingController();
  /*TextEditingController fecha = TextEditingController();*/
  TextEditingController id = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController celular = TextEditingController();
  TextEditingController password = TextEditingController();
  var _currentSelectedDate;
  final firebase = FirebaseFirestore.instance;

  insertDataUser() async {
    try {
      await firebase.collection("Usuario").doc().set({
        "Rol": "Usuario",
        "User": User.text,
        /*"Fecha de nacimiento": fecha.text,*/
        "ID": id.text,
        "email": email.text,
        "cell phone": celular.text,
        "password": password.text,
        "estado": true
      });
    } catch (e) {
      print('Error -->' + e.toString());
    }
  }

/*
  void callDataPcker() async {
    var selectedDate = await getDatePickerWidget();
    setState(() {
      _currentSelectedDate = selectedDate;
      if (selectedDate != null) {
        fecha.text = selectedDate.toString().substring(0, 10);
      }
    }
    );
  }*/

  Future<DateTime?> getDatePickerWidget() {
    return showDatePicker(
        context: context,
        initialDate: DateTime(2022),
        firstDate: DateTime(1930),
        lastDate: DateTime.now(),
        fieldHintText: "DIA/MES/AÑO",
        fieldLabelText: "Día/Mes/Año",
        helpText: "FECHA DE NACIMIENTO",
        errorFormatText: "Ingrese una fecha válida",
        errorInvalidText: "Fecha fuera de rango",
        initialEntryMode: DatePickerEntryMode.input,
        builder: (context, child) {
          return Theme(data: ThemeData.dark(), child: Center(child: child));
        });
  }

  var flag = false;
  Widget build(BuildContext context){
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.green),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Registro de usuario"),
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
                'imgs/reg.png',
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
            controller: User,
            autofocus: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
            ),
              labelText: 'Usuario',
              hintText: 'Digite su nombre y apellido',

            ),


          ),


        ),
/*
        Padding(padding: EdgeInsets.only(left: 15.8,top: 8, right: 15, bottom: 8),
          child: Stack(
              alignment: const Alignment(1.0,1.0 ),
              children: [
                new TextField(
                  enabled: false,
                  controller: fecha,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    labelText: 'Fecha de nacimiento',
                    hintText: 'Digite su fecha de nacimiento',
                  ),

                ),
                new FlatButton(
                    onPressed: (){
                      callDataPcker();
                     // Text("$_currentSelectedDate");
                    },
                    child: new Icon(Icons.date_range_outlined))
              ],
          ),
    ),*/


        Padding(padding: const EdgeInsets.only(
            left: 15.8, top: 8, right: 15, bottom: 8),
          child: TextField(
            controller: id,
            //autofocus: true,
           // controller: password,
           // obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10)
              ),
              labelText: 'ID',
              hintText: 'Digite su identificación',
            ),
          ),
        ),

                Padding(padding: const EdgeInsets.only(
                    left: 15.8, top: 8, right: 15, bottom: 8),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: email,
                    //autofocus: true,
                    //obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      labelText: 'email',
                      hintText: 'Digite correo electronico',
                    ),
                  ),
                ),

                Padding(padding: const EdgeInsets.only(
                    left: 15.8, top: 8, right: 15, bottom: 8),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: celular,
                    //autofocus: true,
                    //obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      labelText: 'cell phone',
                      hintText: 'Digite número de celular',
                    ),
                  ),
                ),

                Padding(padding: EdgeInsets.only(left: 15.8,top: 8, right: 15, bottom: 8),
                  child: Stack(
                    alignment: const Alignment(1.0,1.0 ),
                    children: [
                      new TextField(
                        keyboardType: TextInputType.multiline,
                        obscureText: passwordHide,
                        controller: password,
                        //autofocus: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          labelText: 'password',
                          hintText: 'Digite su contraseña',
                        ),

                      ),
                      new TextButton(

                          onPressed: (){setState(() {
                            if (passwordHide){
                              passwordHide=false;
                              ojo=Icons.visibility;
                            }
                            else{
                              passwordHide=true;
                              ojo=Icons.visibility_off;
                            }
                          }); }
                          , child: new Icon(ojo))
                    ],
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
                insertDataUser();

                Navigator.push(context,
                    MaterialPageRoute(builder: (_) =>
                        passRegister()));

              },



              child: Text(
            'Registrarse',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),



          ),



),


      ]),
        ),


      ),
    );
  }
}

