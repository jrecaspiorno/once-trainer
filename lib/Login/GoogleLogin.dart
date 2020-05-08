
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoogleSingUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GoogleSingUpState();
}

class _GoogleSingUpState extends State<GoogleSingUp> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSingIn = GoogleSignIn();

  // bool isLoading = false;
  // bool isLogedIn = false;

  // SharedPreferences prefs;
  // FirebaseUser firebaseUser;

  // void initSate(){
  //   super.initState();
  //   isSingIn();
  // }
  
  // void isSingIn() async{
  //   setState(() {
  //     isLoading=true;
      
  //   });
  //   prefs = await SharedPreferences.getInstance();

  //   isLogedIn = await _googleSingIn.isSignedIn();
  //   if (isLoading) { 
  //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()))
  //   }
  //   setState(() {
  //     isLoading = false;
  //   });
  
  // }

  // Future<Null> handleSingIn() async{
  //     final GoogleSignInAccount googleUser = await _googleSingIn.signIn();
  //     final GoogleSignInAuthentication googleAuth = await googleUser.authentication;


  //     AuthCredential credential = GoogleAuthProvider.getCredential(
  //       idToken: googleAuth.accessToken, 
  //       accessToken: googleAuth.idToken
  //     );
  //     final FirebaseUser firebaseUser = (await _firebaseAuth.signInWithCredential(credential)).user;

  //     if(firebaseUser != null){
  //       final QuerySnapshot result =
  //     }
      
  // }

  Future<FirebaseUser> _singIn(BuildContext context) async{
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('Sing in'),
      ));
    final GoogleSignInAccount googleUser= await _googleSingIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential= GoogleAuthProvider.getCredential(
      idToken: googleAuth.accessToken, 
      accessToken: googleAuth.idToken
    );
    
    FirebaseUser userDetails = (await _firebaseAuth.signInWithCredential(credential)).user;
    ProviderDetails providerInfo = ProviderDetails(userDetails.providerId);
    List<ProviderDetails> providerData = List <ProviderDetails>();
    providerData.add(providerInfo);


    UserData details = UserData(
      providerDetails: userDetails.providerId, 
      userName: userDetails.displayName,
      userEmail: userDetails.email,
      photoUrl: userDetails.photoUrl,
      providerData: providerData);

    return userDetails;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.indigo,
      ),
      body: Builder(
          builder: (context) => Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 250,
                        child: Align(
                          alignment: Alignment.center,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            color: Color(0xffffffff),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Icon(FontAwesomeIcons.google, color: Color(0xffCE107C),),
                                SizedBox(width: 10,),
                                Text('Sing in with Google',
                                  style: TextStyle(color: Colors.black, fontSize: 18),
                                ),
                            
                              ],
                            ),
                            onPressed: () => _singIn(context),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              )),
    );
  }

  
}

class UserData {
    UserData({
      this.providerDetails,
      this.userName,
      this.photoUrl,
      this.userEmail,
      this.providerData,
    });

  final String photoUrl;
  final List<ProviderDetails> providerData;
  final String providerDetails;
  final String userEmail;
  final String userName;
}
  
class ProviderDetails {
  ProviderDetails(this.providerDetails);

  final String providerDetails;
}
