
import 'package:expenso_422/ui/screen/add_expense/bloc/expense_bloc.dart';
import 'package:expenso_422/ui/screen/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/local/helper/dbHelper.dart';
import 'domain/constants/app_routes.dart';

void main(){
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => UserBloc(dbHelper: DBHelper.getInstance())),
      BlocProvider(create: (context) => ExpenseBloc(dbHelper: DBHelper.getInstance())),
    ], child: MyApp(),

  )
      );
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
 Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      theme : ThemeData(
        colorScheme:ColorScheme.fromSeed(seedColor:Colors.deepPurple),
    ),
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.mRoutes,
    );
  }
}
