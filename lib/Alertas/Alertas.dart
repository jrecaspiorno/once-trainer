import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Alerts {
    
   BuildContext context;
   String firstButtonText;
   String secondButtonText;
   GestureTapCallback  fun1;
   GestureTapCallback fun2;
   String title;
   String message;
   Alerts(
     {
        @required this.context,
        @required this.firstButtonText,
        @required this.fun1,
        @required this.title,
        @required this.message,
        this.fun2,
        this.secondButtonText,
     }
   );
  
    showAlertDialog() {

      // set up the buttons
      Widget firstButton = FlatButton(
        child: Text(firstButtonText, style: TextStyle(color:Colors.white, fontSize: 20),),
        onPressed:  () {
          fun1.call();
        },
      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text(title, style: TextStyle(color: Colors.white, fontSize: 30)),
        content: Text(message, style: TextStyle(color: Colors.white, fontSize: 20),),
        backgroundColor: Colors.indigo,
        actions: [
          firstButton,
    
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }


  
  showAlertDialog2() {

      // set up the buttons
      Widget firstButton = FlatButton(
        child: Text(firstButtonText, style: TextStyle(color:Colors.white, fontSize: 20),),
      
        onPressed:fun1,
      );

      Widget secondButton = FlatButton(
        child: Text(secondButtonText, style: TextStyle(color:Colors.white, fontSize: 20),),

        onPressed:  () {
          fun2;
        },
      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text(title, style: TextStyle(color: Colors.white, fontSize: 30)),
        content: Text(message, style: TextStyle(color: Colors.white, fontSize: 20),),
        backgroundColor: Colors.indigo,

        actions: [
          firstButton,
          secondButton,

        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
  


}