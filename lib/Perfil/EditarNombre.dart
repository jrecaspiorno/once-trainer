import 'package:flutter/material.dart';
import 'package:flutterapp/Alertas/Alertas.dart';
import 'package:flutterapp/Data/moor_database.dart';
import 'package:flutterapp/NavigationTools/locator.dart';
import 'package:flutterapp/NavigationTools/navigator_service.dart';
import 'package:flutterapp/Registro/SignUpState.dart';
import 'package:provider/provider.dart';


class EditName extends StatefulWidget{

  EditName({@required this.id});
  String id;

  @override
  State<StatefulWidget> createState() => _EditNameState();

}

class _EditNameState extends State<EditName>{
  final NavigationService _navigationService = locator<NavigationService>();
  final nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }
  bool validName(String name){
    if(name == " " || name == "" ) return false;
    else return true;
  }
  Widget cambiarNombre(UsuarioDAO dao) {
    return RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        color: Colors.deepPurple,
        padding: EdgeInsets.all(13.0),
        autofocus: true,
        child: Text(
          'Cambiar',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
        onPressed: () {
          if (validName(nameController.text)) {
            dao.updateNombre(widget.id, nameController.text);
            var state = context.read<LoginState>();
            state.setName(nameController.text);
            print(state.getFNacimiento());
            debugPrint(state.getFecha().toString());
            _navigationService.goBack();
          } else {
            Alerts alert = Alerts(
              context: context,
              firstButtonText: "Ok",
              fun1: () => _navigationService.goBack(),
              title: "Alerta",
              message: "Seleccione su nuevo nombre",
            );
            alert.showAlertDialog();
          }
        });
  }
  Widget nameSel() {
    return Center(
      child: TextField(
        textAlign: TextAlign.center,
        controller: nameController,
        maxLength: 16,
        autocorrect: true,
        style: TextStyle(
          fontSize: 30,
          color: Colors.deepPurple,
        ),
        decoration: InputDecoration(
            alignLabelWithHint: true,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.deepPurple,
                  width: 3.0,
                  style: BorderStyle.solid,
                )),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.deepPurple,
                  width: 3.0,
                  style: BorderStyle.solid,
                )),
            hintText: "Introduzca su nombre"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<AppDatabase>(context);

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            _navigationService.goBack();
          },
        ),
        title: Text('Cambio de Fecha de Nacimiento'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(20.0),
          children: <Widget>[
            nameSel(),
            Padding(
              padding: EdgeInsets.all(40),
            ),
            cambiarNombre(database.usuarioDAO)
          ],
        ),
      ),
    );
  }
  

}