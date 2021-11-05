import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:intl/intl.dart';

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


Future<List<HomeItemResponse>> listAccueil() async{
  try {
    var response = await SingletonDio.getDio().get(urlServer + '/api/home');
    //var response = await SingletonDio.getDio().get('http://10.0.2.2:8080/api/home');
    print(response);
    var listeJSON = response.data as List;
    var listVar = listeJSON.map(
        (e) {
          return HomeItemResponse.fromJson(e);
        }
    ).toList();
    return listVar;

  } catch (e) {
    print(e);
    throw(e);
  }
}

Future<SigninResponse> signin(SignupRequest req) async{
  try {
    var response = await SingletonDio.getDio().post(
        urlServer + '/api/id/signin',
        data: req
    );
    print(response);
    return SigninResponse.fromJson(response.data);
  } catch (e) {
    print(e);
    throw(e);
  }
}

Future<SigninResponse> signup(SignupRequest req) async{
  try {
    var response = await SingletonDio.getDio().post(
        urlServer + '/api/id/signup',
        data: req
    );
    print(response);
    return SigninResponse.fromJson(response.data);
  } catch (e) {
    print(e);
    throw(e);
  }
}

Future<void> ajouter(AddTaskRequest req) async{
  try {
    var response = await SingletonDio.getDio().post(
        urlServer + '/api/add',
        data: req
    );
    print(response);
  } catch (e) {
    print(e);
    throw(e);
  }
}

Future<TaskDetailResponse> detail(int id) async{
  try {
    var response = await SingletonDio.getDio().get(
        urlServer + '/api/detail/' + id.toString()
    );
    print(response);
    return TaskDetailResponse.fromJson(response.data);
  } catch (e) {
    print(e);
    throw(e);
  }
}

Future<void> progress(int id, int valeur) async{
  try {
    var response = await SingletonDio.getDio().get(
        urlServer + '/api/progress/' + id.toString() + '/' + valeur.toString()
    );
    print(response);
  } catch (e) {
    print(e);
    throw(e);
  }
}

Future<void> signout() async{
  try {
    var response = await SingletonDio.getDio().post(
        urlServer + '/api/id/signout'
    );
    print(response);
  } catch (e) {
    print(e);
    throw(e);
  }
}

Future<String> sendPicture(int babyID, File file) async {
  try {
    FormData formData = FormData.fromMap({
      // TODO on peut ajouter d'autres champs que le fichier d'ou le nom multipart
      "babyID": babyID,
      // TODO on peut mettre le nom du fichier d'origine si necessaire
      "file" : await MultipartFile.fromFile(file.path ,filename: "image.jpg")
    });
    // TODO changer la base de l'url pour l'endroit ou roule ton serveur
    var url = urlServer + "/file";
    var response = await SingletonDio.getDio().post(url, data: formData);
    print('picture send :'+response.data);
    return "";
  } catch (e) {
    print(e);
    throw(e);
  }
}
