import 'dart:async';

import 'package:flutter/material.dart';

import '../../../domain/constants/app_routes.dart';



class SplashPage extends StatefulWidget{
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds:4,), (){
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    });
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(

      body:Padding(
        padding: const EdgeInsets.only(left:100, right:100),
        child: Column(
          mainAxisAlignment:MainAxisAlignment.center,
          crossAxisAlignment:CrossAxisAlignment.center,
          children:[

                Image.asset( "assets/image/expenses_5501375.png",
                   width:200,
                   height:200
               ),

            SizedBox(height:11),

             Text("Expense", style:TextStyle(fontWeight:FontWeight.bold,fontSize:30))
            ]
        ),
      )

    );
  }
}