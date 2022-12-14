import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:proyecto/DTO/UsuariosDTO.dart';

class ListadoUsuariosR extends StatefulWidget {
  @override
  _Usuarios  createState() => _Usuarios();
}

class _Usuarios extends State<ListadoUsuariosR> {
  UsuariosDTO usuarioObjeto = UsuariosDTO();

  TextEditingController usuario = TextEditingController();
  TextEditingController rol = TextEditingController();
  TextEditingController idU = TextEditingController();

  final firebase = FirebaseFirestore.instance;
  DateTime selectedDate = DateTime.now();
  var _currentSelectedDate;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(217, 217, 217, 1.0),
      appBar: AppBar(
        title: Text('Administrar Usuarios'),
        backgroundColor: const Color(0xFFFFD54F),
      ),
      body: Container(
        child: Center(
          child: StreamBuilder(
            stream:
            FirebaseFirestore.instance.collection("Usuario").snapshots(),
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
                                          snapshot.data!.docs[index].get("User"),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: Colors.black
                                          ),
                                        )
                                    ),                                    
                                    /*Text(
                                      'Estado: '+ snapshot.data!.docs[index].get("estado"),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Colors.black
                                      ),
                                    ),*/
                                    Text(
                                      'Rol: '+ snapshot.data!.docs[index].get("Rol"),
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
                                  usuarioObjeto.idUsuario=snapshot.data!.docs[index].id;
                                  usuarioObjeto.nombreUsuario=snapshot.data!.docs[index].get("User");
                                  usuarioObjeto.rolUsuario=snapshot.data!.docs[index].get("Rol");

                                  mensajeEditar(usuarioObjeto.idUsuario,usuarioObjeto.nombreUsuario,usuarioObjeto.rolUsuario);
                                },
                                icon: const Icon(Icons.edit),
                              ),
                              IconButton(
                                onPressed: () {
                                  usuarioObjeto.idUsuario=snapshot.data!.docs[index].id;
                                  usuarioObjeto.nombreUsuario=snapshot.data!.docs[index].get("User");
                                  usuarioObjeto.rolUsuario=snapshot.data!.docs[index].get("Rol");
                                  usuarioObjeto.estadoUsuario=snapshot.data!.docs[index].get("estado");
                                  if(usuarioObjeto.estadoUsuario==true){
                                    usuarioObjeto.estadoUsuario=false;
                                  }else{
                                    usuarioObjeto.estadoUsuario=true;
                                  }
                                  //print(usuarioObjeto.estadoUsuario=snapshot.data!.docs[index].get("estado"));
                                  deleteUser(usuarioObjeto.idUsuario, usuarioObjeto.estadoUsuario, usuarioObjeto.nombreUsuario, usuarioObjeto.rolUsuario);
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

  void mensajeEditar(String idE,String usuarioE, String rolE) {

    usuario.text = usuarioE;
    rol.text = rolE;
    idU.text = idE;

    showDialog(
        context: context,
        builder: (buildcontext) {
          return AlertDialog(
            title: Text('Editar Usuario'),
            content: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: usuario,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      fillColor: Colors.grey,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      labelText: 'Usuario',
                      hintText: 'Nombre del usuario',
                      labelStyle: TextStyle(color: Colors.black),
                      hintStyle: TextStyle(color: Colors.black),
                      prefixIcon: const Icon(
                        Icons.person_add,
                        color: Color(0xFFFFD54F),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFFFC107)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: rol,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      fillColor: Colors.grey,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      labelText: 'Rol',
                      hintText: 'Rol del usuario',
                      labelStyle: TextStyle(color: Colors.black),
                      hintStyle: TextStyle(color: Colors.black),
                      prefixIcon: const Icon(
                        Icons.verified_user_outlined,
                        color: Color(0xFFFFD54F),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFFFC107)),
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
                          editUser(idU.text,  usuario.text, rol.text);
                          Navigator.of(context).pop();
                        },
                        child:
                        Text("Aceptar"),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFFC107),
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
                            backgroundColor: const Color(0xFFFFC107),
                            shadowColor: const Color(0xFFFFD54F),
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

  editUser(String id,String usuario, String rol) async{
    try{
      await firebase
          .collection("Usuario")
          .doc(id)
          .set({
        "User":usuario,
        "Rol":rol,
        "estado": true,
      });
      mensajeGeneral('Editado', 'Se actualiz?? la informaci??n del usuario');
    }catch(e){
      print('ERROR-> '+e.toString());
    }
  }

  deleteUser(String idC, bool estadoC, String usuarioC, String rolC) async{
    try{
      await firebase
          .collection("Usuario")
          .doc(idC)
          .set({
        "User":usuarioC,
        "Rol":rolC,
        "estado": estadoC,
      });
      mensajeGeneral('Estado Editado', 'Se actualiz?? el estado del usuario: '+estadoC.toString());
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
                    usuario.clear();
                    rol.clear();
                  },
                  child:
                  Text("Aceptar"),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFC107),
                      shadowColor: const Color(0xFFFFD54F),
                      elevation: 15,
                      minimumSize: Size(150, 40)
                  )
              )
            ],
          );
        });
  }
}