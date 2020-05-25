import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Registro/SignUpState.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: Center(
       child: Consumer<LoginState>(
         builder: (BuildContext context, LoginState value, Widget child){
           if(value.isLoading()){
             return CircularProgressIndicator();
           }else{
             return child;
           }
         },
         child: RaisedButton(
           child: Text("Registro"),
           onPressed: (){
             context.read<LoginState>().login();
           },
         ),
       ),
     ),
   );
  }


}