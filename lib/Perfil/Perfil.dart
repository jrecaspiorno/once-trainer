import 'package:flutter/material.dart';
import 'package:flutterapp/Data/moor_database.dart';
import 'package:flutterapp/DriveBackup/BackupView.dart';
import 'package:flutterapp/DriveBackup/RestoreView.dart';
import 'package:flutterapp/NavigationTools/locator.dart';
import 'package:flutterapp/NavigationTools/navigator_service.dart';
import 'package:flutterapp/Registro/SignUpState.dart';
import 'package:provider/provider.dart';
import 'package:flutterapp/NavigationTools/routes_path.dart' as route;


class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final NavigationService _navigationService = locator<NavigationService>();




  Widget logoutButton() {
    return Column(
      children: <Widget>[
        SizedBox(
          width: 330,
          child: RaisedButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            color: Colors.red,
            child: Text(
              'LogOut',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            padding: EdgeInsets.all(17.0),
            onPressed: () {                
                context.read<LoginState>().logout();
                _navigationService.removeUntilAndPush(route.MainPage);            },
          ),
        )
      ],
    );
  }



  Stream<UsuarioData> watchCurrentsUser(UsuarioDAO usuarioDAO, String id) {
    return usuarioDAO.watchUser(id);
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<AppDatabase>(context);

    var state = context.watch<LoginState>();
    String id = state.getId();
    return Scaffold(
        // Widget con app prediseñada, esquema
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              _navigationService.goBack();
            },
          ),
          title: Text('Perfil'),
          backgroundColor: Colors.indigo,
        ),
        body: StreamBuilder(
          stream: watchCurrentsUser(database.usuarioDAO, id),
          builder: (context, data) {
            if (data.hasData) {
              UsuarioData mainUser = data.data;
              return ListView(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(25),
                  ),
                  MyData(usuarioData: mainUser),
                  Padding(
                    padding: EdgeInsets.all(20),
                  ),
                  MyButtonType(),
                  BackupButton(),
                  Padding(
                    padding: EdgeInsets.all(20),
                  ),
                  RestoreButton(),
                  Padding(
                    padding: EdgeInsets.all(20),
                  ),
                  logoutButton(),
                  
                  Padding(
                    padding: EdgeInsets.all(20),
                  ),
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      
    );
  }
}

class MyButtonType extends StatelessWidget {
  final NavigationService _navigationService = locator<NavigationService>();

  Flex _buildButton( String label, String route, Object args) {
    return Flex(
      direction: Axis.vertical,
      // mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 330,
          child: RaisedButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            onPressed: () {
              if (args != null)
                _navigationService.navigateTo(route, arguments: args);
              else
                _navigationService.navigateTo(route);
            },
            color: Colors.indigo,
            textColor: Colors.white,
            padding: EdgeInsets.all(24.0),
            child: Text(label, style: TextStyle(fontSize: 30)),
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var state = context.watch<LoginState>();
    String id = state.getId();
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(height: 20),
          _buildButton(
              'Historial Actividades', route.HistorialActividadesPage, null),
          _buildButton(
              'Historial Clínico', route.HistorialClinicoPage, null),
          _buildButton('Dolencias', route.DolenciasPage, id),
          _buildButton('Editar F.Nacimiento', route.EditarFechaPage, id)
        ],
      ),
    );
  }
}

class MyData extends StatelessWidget {
  MyData({Key key, @required this.usuarioData}) : super(key: key);

  final UsuarioData usuarioData;

  String dateTimeToString(DateTime _dateTime) {
    String day = _dateTime.day.toString();
    String month = _dateTime.month.toString();
    String year = _dateTime.year.toString();
    return day + "/" + month + "/" + year;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      widthFactor: 15,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(
              usuarioData.photoUrl,
              width: 50,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
          ),
          Flexible(
            child: Text(
              usuarioData.nombre,
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          ),
          Flexible(
            child: Text(
              dateTimeToString(usuarioData.edad),
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          )
        ],
      ),
    );
  }
}
