
import 'package:flutter/material.dart';
import 'domain/constants/app_routes.dart';

void main(){
  runApp(ExpenseApp());
}

class ExpenseApp extends StatelessWidget{
  const ExpenseApp({super.key});

  @override
 Widget build(BuildContext context){
    return MaterialApp(
      title : 'Flutter demo',
      theme : ThemeData(
        colorScheme:ColorScheme.fromSeed(seedColor:Colors.deepPurple),
    ),
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.mRoutes,
    );
  }
}
