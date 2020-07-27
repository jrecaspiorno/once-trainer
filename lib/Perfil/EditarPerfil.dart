import 'package:flutter/material.dart';
import 'package:flutterapp/Alertas/Alertas.dart';
import 'package:flutterapp/Data/moor_database.dart';
import 'package:flutterapp/NavigationTools/locator.dart';
import 'package:flutterapp/NavigationTools/navigator_service.dart';
import 'package:flutterapp/Registro/SignUpState.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  EditProfile({@required this.id});

  String id;

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final NavigationService _navigationService = locator<NavigationService>();

  DateTime _dateTime;

  Future<void> setDate(UsuarioDAO dao) async {
    UsuarioData user = await dao.getUser(widget.id);
    //UsuarioData(id: user.id, nombre: user., edad: null, photoUrl: null, email: null)
  }

  Widget dateSel() {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      color: Colors.indigo,
      padding: EdgeInsets.all(13.0),
      autofocus: true,
      child: Text(
        'Introducir fecha de nacimiento',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 30,
        ),
      ),
      onPressed: () {
        showDatePicker(
                builder: (context, child) => Theme(
                      child: child,
                      data: ThemeData.light().copyWith(
                        primaryColor: Colors.indigo,
                        accentColor: Colors.indigo,
                        colorScheme:
                            ColorScheme.light(primary: const Color(0xFF3F51B5)),
                        buttonTheme:
                            ButtonThemeData(textTheme: ButtonTextTheme.primary),
                      ),
                    ),
                initialEntryMode: DatePickerEntryMode.input,
                helpText: "Introduzca su fecha de nacimiento",
                fieldLabelText: "Fecha",
                fieldHintText: "dd/mm/aaaa",
                errorFormatText: "Formato no válido",
                errorInvalidText: "El valor mínimo de la fecha es 1900",
                context: context,
                initialDate: _dateTime == null ? DateTime.now() : _dateTime,
                firstDate: DateTime(1900),
                lastDate: DateTime.now())
            .then((date) {
          setState(() {
            _dateTime = date;
          });
        });
      },
    );
  }

  Widget cambiarF(UsuarioDAO dao) {
    return RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        color: Colors.indigo,
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
          if (_dateTime != null) {
            dao.updateEdad(widget.id, _dateTime);
            var state = context.read<LoginState>();
            state.setDate(_dateTime);
            print(state.getFNacimiento());
            debugPrint(state.getFecha().toString());
            _navigationService.goBack();
          } else {
            Alerts alert = Alerts(
              context: context,
              firstButtonText: "Ok",
              fun1: () => _navigationService.goBack(),
              title: "Alerta",
              message: "Seleccione su fecha de nacimiento",
            );
            alert.showAlertDialog();
          }
        });
  }

  Widget actualSelDate() {
    return Center(
      child: Text(
        _dateTime == null
            ? 'Todavía no has eligido fecha'
            : dateTimeToString(_dateTime),
        style: TextStyle(fontSize: 30, color: Colors.indigo),
        textAlign: TextAlign.center,
      ),
    );
  }

  String dateTimeToString(DateTime _dateTime) {
    String day = _dateTime.day.toString();
    String month = _dateTime.month.toString();
    String year = _dateTime.year.toString();
    return day + "/" + month + "/" + year;
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<AppDatabase>(context);
    //setDate(database.usuarioDAO);
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            _navigationService.goBack();
          },
        ),
        title: Text('Cambio de Fecha de Nacimiento'),
        backgroundColor: Colors.indigo,
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(20.0),
          children: <Widget>[
            dateSel(),
            Padding(
              padding: EdgeInsets.all(40),
            ),
            actualSelDate(),
            Padding(
              padding: EdgeInsets.all(40),
            ),
            cambiarF(database.usuarioDAO)
          ],
        ),
      ),
    );
  }
}
