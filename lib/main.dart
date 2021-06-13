import 'package:blocpattern/src/bloc/provider.dart';
import 'package:blocpattern/src/pages/home_page.dart';
import 'package:blocpattern/src/pages/login_page.dart';
import 'package:blocpattern/src/pages/producto_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'home',
      routes: {
        'login': (BuildContext context) => LoginPage(),
        'home': (BuildContext context) => HomePage(),
        'producto': (BuildContext context) => ProductPage(),
      },
    ),
    );
  }
}