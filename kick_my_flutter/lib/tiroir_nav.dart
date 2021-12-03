import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kick_my_flutter/accueil.dart';
import 'package:kick_my_flutter/ajouter.dart';
import 'package:kick_my_flutter/connection.dart';
import 'package:kick_my_flutter/consultation.dart';
import 'package:kick_my_flutter/nameSingleton.dart';
import 'package:kick_my_flutter/util.dart';

import 'i18n/intl_localization.dart';

class LeTiroir extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => LeTiroirState();
}

class LeTiroirState extends State<LeTiroir> {


  @override
  Widget build(BuildContext context) {
    var listView = ListView(

      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.deepPurple,
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              (FirebaseAuth.instance.currentUser!.displayName!=null?FirebaseAuth.instance.currentUser!.displayName:Text('')).toString(),
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
        ListTile(
          dense: true,
          leading: Icon(Icons.home),
          title: Text(Locs.of(context).trans('ACCUEIL')),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AccueilPage(title: 'Accueil'),
              ),
            );
          },
        ),
        ListTile(
          dense: true,
          leading: Icon(Icons.add),
          title: Text(Locs.of(context).trans('ADD')),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AjouterPage(title: 'Ajouter'),
              ),
            );
          },
        ),
        ListTile(
          dense: true,
          leading: Icon(Icons.arrow_back),
          title: Text(Locs.of(context).trans('DECONNEXION')),
          onTap: () async{
            await getSignout();
            Navigator.of(context).pop();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ConnectionPage(title: 'Connection'),
              ),
            );
          },
        ),
      ],
    );



    return Drawer(
      child: new Container(
        color: const Color(0xFFFFFFFF),
        child: listView,
      ),
    );
  }

  Future<void> getSignout() async{
    try {

    } catch (e) {
      print(e);
    }
  }
}



