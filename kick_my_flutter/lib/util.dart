import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:kick_my_flutter/http/model.dart';

import 'http/transfer.dart';

//8080


final String urlServer = 'http://10.0.2.2:8080';

class Account {
  late String username;
  late String password;
}

class SingletonConnect {

  static final SingletonConnect _singletonConnect = SingletonConnect();

  factory SingletonConnect() {
    return _singletonConnect;
  }
}

//final String urlServer = 'https://kickmyb-server.herokuapp.com';


String format(DateTime date) {
  final DateTime now = date;
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  final String formatted = formatter.format(now);
  return formatted;
}


//http
class SingletonDio {

  static var cookiemanager = CookieManager(CookieJar());

  static Dio getDio() {
    Dio dio = Dio();
    dio.interceptors.add(cookiemanager);
    return dio;
  }
}

CollectionReference<Tache> generateTacheCollection() {
  return FirebaseFirestore.instance.collection('taches').withConverter(
      fromFirestore: (snapshot, _) => Tache.fromJson(snapshot.data()!),
      toFirestore: (Tache, _) => Tache.toJson()
  );
}

void postTacheFB(Tache req) async{
  CollectionReference<Tache> tacheCollection = generateTacheCollection();
  Tache tacheCourant = req;
  tacheCourant.userId = FirebaseAuth.instance.currentUser!.uid;
  tacheCollection.add(tacheCourant);
}


Future<List<TacheAccueil>> getTachesFB() async {
  CollectionReference<Tache> tacheCollection = generateTacheCollection();
  var results = await tacheCollection.where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid).get();
  var tacheDocs = results.docs;
  List<TacheAccueil> liste = [];
  for(int i = 0; i < tacheDocs.length; i++){
    TacheAccueil tacheCourante = TacheAccueil();
    tacheCourante.id = tacheDocs[i].id;
    tacheCourante.name = tacheDocs[i].data().name;
    tacheCourante.progression = tacheDocs[i].data().progression;
    tacheCourante.deadline = tacheDocs[i].data().deadline;
    tacheCourante.start = tacheDocs[i].data().start;
    tacheCourante.path = tacheDocs[i].data().path;
    tacheCourante.userId = tacheDocs[i].data().userId;
    liste.add(tacheCourante);
  }
  return liste;
}




Future<Tache> getTacheFB(String id) async {
  DocumentSnapshot<Tache> tacheCollection = await generateTacheCollection().doc(id).get();
  Tache tache = tacheCollection.data()!;
  return tache;
}

Future<void> changeProgressionTacheFB(String id, int progression) async {
  await generateTacheCollection().doc(id).update({
    'progression' : progression
  });

}

Future<void> changePathTacheFB(String id, String path) async {
  await generateTacheCollection().doc(id).update({
    'path' : path
  });

}

Future<bool> verifierSiTacheExiste(Tache tache) async {
  CollectionReference<Tache> tacheCollection = generateTacheCollection();
  var results = await tacheCollection.where('name', isEqualTo: tache.name).get();
  var tacheDocs = results.docs;
  if (tacheDocs.length > 0){
    return false;
  } else {
    return true;
  }
}

String differenceBetweenStringDate(String start, String deadline) {
  DateTime dateStart = new DateFormat("yyyy-MM-dd").parse(start);
  DateTime dateEnd = new DateFormat("yyyy-MM-dd").parse(deadline);
  String difference = dateEnd.difference(dateStart).inDays.toString();
  return difference;
}