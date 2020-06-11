import 'package:flutter/material.dart';
import 'package:projecttiga/Home_Page.dart';
import 'package:projecttiga/Login_Page.dart';
import 'package:projecttiga/annc_detail.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings){

    final args = settings.arguments;
    bool authed = false;

    switch(settings.name){
      case '/home' :
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/login' :
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/anncDetail' :
        return MaterialPageRoute(builder: (_) => AnncDetail(tag: args));

    }

  }
}