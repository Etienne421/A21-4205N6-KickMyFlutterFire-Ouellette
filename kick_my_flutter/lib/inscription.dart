import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kick_my_flutter/accueil.dart';
import 'package:kick_my_flutter/connection.dart';
import 'package:kick_my_flutter/util.dart';
import 'package:loading_overlay/loading_overlay.dart';

import 'http/transfer.dart';
import 'i18n/intl_localization.dart';

class InscriptionPage extends StatefulWidget {
  InscriptionPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _InscriptionPage createState() => _InscriptionPage();
}

class _InscriptionPage extends State<InscriptionPage> {

  final NomController = TextEditingController();
  final PasswordController = TextEditingController();
  final ConfirmationController = TextEditingController();
  bool _saving = false;

  void loadingState() {
    _saving = !_saving;
    setState(() {});
  }

  void signup(SignupRequest req) async{
    try {
      loadingState();
      var response = await SingletonDio.getDio().post(
          urlServer + '/api/id/signup',
          data: req
      ).timeout(const Duration(seconds: 30));
      print(response);
      loadingState();
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AccueilPage(title: Locs.of(context).trans('ACCUEIL')))
      );
      setState(() {});
      // naviguer a ecran accueil

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
                content: Text(Locs.of(context).trans('ERROR_NO_INFORMATION_CONNECTION'))
            )
        );
      } else {
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
                margin: EdgeInsets.only(bottom: 20),
                child: TextField(
                  controller: NomController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    hintText:Locs.of(context).trans('HINT_NAME'),
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
                margin: EdgeInsets.only(bottom: 20),
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
              Container(
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.blueGrey),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                margin: EdgeInsets.only(bottom: 20),
                child: TextField(
                  controller: ConfirmationController,
                  textAlign: TextAlign.center,
                  obscureText: true,
                  cursorColor: Colors.deepPurple,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    hintText:Locs.of(context).trans('HINT_CONFIRMATION'),
                  ),
                ),
              ),
              GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ConnectionPage(title: Locs.of(context).trans('CONNEXION')))
                    );
                  },
                  child: Text(
                    Locs.of(context).trans('CONNEXION'),
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
                      if(0 == PasswordController.text.toString().compareTo(ConfirmationController.text.toString())){
                        SignupRequest req = SignupRequest();
                        req.username = NomController.text.toString();
                        req.password = PasswordController.text.toString();
                        var reponse =  signup(req);
                      }
                      else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(Locs.of(context).trans('ERROR_BAD_CONFIRMATION'))
                            )
                        );
                      }


                    },
                    child: Text(Locs.of(context).trans('INSCRIPTION')),
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