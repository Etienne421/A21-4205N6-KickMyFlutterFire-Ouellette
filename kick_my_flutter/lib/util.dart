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

