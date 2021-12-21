import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kick_my_flutter/accueil.dart';
import 'package:kick_my_flutter/inscription.dart';
import 'package:kick_my_flutter/nameSingleton.dart';
import 'package:kick_my_flutter/util.dart';
import 'package:loading_overlay/loading_overlay.dart';

import 'http/transfer.dart';
import 'i18n/intl_localization.dart';


class ConnectionPage extends StatefulWidget {
  ConnectionPage({Key? key, required this.title}) : super(key: key);



  final String title;

  @override
  _ConnectionPage createState() => _ConnectionPage();
}

class _ConnectionPage extends State<ConnectionPage> {

  final NomController = TextEditingController();
  final PasswordController = TextEditingController();

  SigninResponse response = new SigninResponse();

  bool _saving = false;

  String utilisateur = "personne";

  @override
  void initState() {
    initFirebase();
  }
  void initFirebase() async {
    await Firebase.initializeApp();
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        this.utilisateur = "personne";
        setState(() {});
        print('User is currently signed out!');
      } else {
        /*Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AccueilPage(title: Locs.of(context).trans('ACCUEIL')))
        );*/
        setState(() {});
        this.utilisateur = user.displayName!;

        setState(() {});
        print('User is signed in!');
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AccueilPage(title: 'Accueil'))
        );
      }
    });
  }



  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if(googleUser != null) {
      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser!.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } else{
      print("user is null");
      throw Error();
    }

  }
//   // Inside your _MyAppState class
//   bool isLoading = false;
//
// // Inside your build method
//   isLoading ? RaisedButton(
//   child: Text('Log in'),
//   onPressed: async(){
//     setState((){
//       isLoading=true;
//     });
//     await _loginn();
//     setState((){
//       isLoading=false;
//     });
//   },
//   )
//       : Center(child:CircularProgressIndicator())

  void loadingState() {
    _saving = !_saving;
    setState(() {});
  }


  static int tacheCounter = 0;


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: LoadingOverlay(
        isLoading: _saving,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(20),
                child: SizedBox(
                  height: 50,
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () {
                      signInWithGoogle();
                    },
                    child: Text("Se connecter avec Google"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}