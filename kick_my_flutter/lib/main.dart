
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kick_my_flutter/accueil.dart';
import 'package:kick_my_flutter/inscription.dart';

import 'connection.dart';
import 'i18n/intl_delegate.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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

class App extends StatefulWidget {
  // Create the initialization Future outside of `build`:
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  /// The future is part of the state of our widget. We should not call `initializeApp`
  /// directly inside [build].
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Container(
            height: 100,
            width: 100,
            color: Colors.red,
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MyApp();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Container(
          height: 100,
          width: 100,
          color: Colors.green,
        );
      },
    );
  }
}