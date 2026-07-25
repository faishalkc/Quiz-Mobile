import 'package:flutter/material.dart';
import 'login.dart';
import 'register.dart';
import 'inpage.dart';
import 'dart:io';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  runApp(
    MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Proyek UAS',
        home: const Login(),
        routes: <String, WidgetBuilder>{
          '/Login': (BuildContext context) => const Login(),
          '/Register': (BuildContext context) => const Register(),
          '/InPage': (BuildContext context) => const InPage(),
        }),
  );
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
}
