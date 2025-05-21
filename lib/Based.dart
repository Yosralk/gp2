import 'package:flutter/material.dart';
import 'package:gp2/Error.dart';
import 'LoginScreen.dart';
import 'Register.dart';
import 'Const.dart';
import 'navscreen.dart';
import 'Homepage.dart';
class routeClass{
  static Route generator(RouteSettings setting){
    switch(setting.name) {
      case route0:
      case route1:
        return buiderScreen(Register());
      case route2:
        return buiderScreen(Login());
      case route3:
        return buiderScreen(HomePage());
      case route4:
        return buiderScreen(nanvClass());
      default :
        return MaterialPageRoute(builder: (_)=>ErrorPage());


    }
  }
  static MaterialPageRoute buiderScreen(Widget screen){
    return MaterialPageRoute(builder: (_)=>screen);
  }
}