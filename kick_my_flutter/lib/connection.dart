import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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

  void getSignin(SignupRequest req) async{
    try {
      loadingState();
      this.response = await signin(req).timeout(const Duration(seconds: 5));
      nomUtilisateur = response.username;
      loadingState();
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AccueilPage(title: Locs.of(context).trans('ACCUEIL')))
      );
      setState(() {});
      //return  SigninResponse.fromJson(response.data);
    } on TimeoutException catch (e) {
      loadingState();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(Locs.of(context).trans('TIME_OUT'))
          )
      );
    } on DioError catch(e) {
      print(e);
      loadingState();
      String message = e.response!.data;
      if (message == "BadCredentialsException") {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(Locs.of(context).trans('ERROR_INFORMATION_CONNECTION'))
            )
        );
      } else if (message == "InternalAuthenticationServiceException") {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(Locs.of(context).trans('ERROR_NO_INFORMATION_CONNECTION'))
            )
        );
      }  else {
        loadingState();
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(Locs.of(context).trans('ERROR_NETWORK'))
            )
        );
      }
    }

  }

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
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.blueGrey),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                ),

                child: TextField(
                  controller: NomController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    hintText:Locs.of(context).trans('HINT_NAME'),
                    //hintText: Locs.of(context).trans('MESSAGE'),
                  ),
                ),
              ),
              Container(
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.blueGrey),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                margin: EdgeInsets.all(20),
                child: TextField(
                  controller: PasswordController,
                  textAlign: TextAlign.center,
                  obscureText: true,
                  cursorColor: Colors.deepPurple,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    hintText:Locs.of(context).trans('HINT_PASSWORD'),
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => InscriptionPage(title: Locs.of(context).trans('INSCRIPTION')))
                  );
                },
                child: Text(
                  Locs.of(context).trans('CREATE_ACCOUNT'),
                  style: TextStyle(color: Colors.deepPurple),
                )
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: SizedBox(
                  height: 50,
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () {
                      SignupRequest req = SignupRequest();
                      req.username = NomController.text.toString();
                      req.password = PasswordController.text.toString();
                      var reponse =  getSignin(req);
                    },
                    child: Text(Locs.of(context).trans('CONNEXION')),
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