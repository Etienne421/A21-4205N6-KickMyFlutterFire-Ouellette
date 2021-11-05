
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kick_my_flutter/accueil.dart';
import 'package:kick_my_flutter/inscription.dart';

import 'connection.dart';
import 'i18n/intl_delegate.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KickMyFlutter',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xffd2b3f1 ),
        primarySwatch: Colors.deepPurple,
      ),
      localizationsDelegates: [
        DemoDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // TODO annoncer les locales qui sont gerees
      supportedLocales: [
        const Locale('en'),
        const Locale('fr'),
      ],

      home: ConnectionPage(title: 'Connection'),
      // home: InscriptionPage(title: 'Inscription',),
      //home: AccueilPage(title: 'Accueil',)
    );
  }
}