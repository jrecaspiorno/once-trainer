import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Alerts {
    
   BuildContext context;

   String firstButtonText;
   String secondButtonText;
   String thirdButtonText;

   GestureTapCallback  fun1;
   GestureTapCallback fun2;
   GestureTapCallback fun3;

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
        this.fun3,
        this.secondButtonText,
        this.thirdButtonText,
        content,
     }
   );
  
    showAlertDialog() {

      // set up the buttons
      Widget firstButton = FlatButton(
        child: Text(firstButtonText, style: TextStyle(color:Colors.white, fontSize: 20),),
        onPressed:  () {
          fun1();
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
        barrierDismissible: false,
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
      
        onPressed:(){
          fun1();
        },
      );

      Widget secondButton = FlatButton(
        child: Text(secondButtonText, style: TextStyle(color:Colors.white, fontSize: 20),),

        onPressed:  () {
          fun2();
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
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

   showAlertDialog3() {

     // set up the buttons
     Widget firstButton = FlatButton(
       child: Text(firstButtonText, style: TextStyle(color:Colors.white, fontSize: 20),),

       onPressed:(){
         fun1();
       },
     );

     Widget secondButton = FlatButton(
       child: Text(secondButtonText, style: TextStyle(color:Colors.white, fontSize: 20),),

       onPressed:  () {
         fun2();
       },
     );

     Widget thirdButton = FlatButton(
       child: Text(thirdButtonText, style: TextStyle(color:Colors.white, fontSize: 20),),

       onPressed:  () {
         fun3();
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
         thirdButton,
       ],
     );

     // show the dialog
     showDialog(
       barrierDismissible: false,
       context: context,
       builder: (BuildContext context) {
         return alert;
       },
     );
   }


}