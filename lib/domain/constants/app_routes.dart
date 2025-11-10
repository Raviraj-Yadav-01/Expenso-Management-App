
import 'package:flutter/material.dart';

import '../../ui/screen/dashboard/dashboard_page.dart';
import '../../ui/screen/login/login_Page.dart';
import '../../ui/screen/sinup/sinup_page.dart';
import '../../ui/screen/splash/splash_page.dart';

class AppRoutes{

  static const String splash ="/splash_p";
  static const String login ="/login";
  static const String signup ="/signup";
  static const String dashboard ="/dashboard";
  static const String addExpense ="/addExpense";
  static const String stats ="/stats";





 static  Map<String, WidgetBuilder > mRoutes = {
     splash : (context) => SplashPage(),
     login : (context) => LoginPage(),
     signup : (context) => SignUpPage(),
     dashboard : (context) => DashBoardPage(),
    // addExpense : (context) => AddExpense(),

 };

}