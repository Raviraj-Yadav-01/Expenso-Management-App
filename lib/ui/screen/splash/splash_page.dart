import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/constants/app_contants.dart';
import '../../../domain/constants/app_routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 4), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int userId = prefs.getInt(AppConstants.prefs_user_id) ?? 0;

      String nextPage = AppRoutes.login;

      if (userId > 0) {
        nextPage = AppRoutes.dashboard;
      }

      Navigator.pushReplacementNamed(context, nextPage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor:Color(0xffff3952),
      backgroundColor: Color(0xff100f1f),
      body: Padding(
        padding: const EdgeInsets.only(left: 100, right: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(AppConstants.img_app_logo, width: 200, height: 200),

            SizedBox(height: 11),

            Text("Expense",
              style: TextStyle(fontFamily: "Poppins",fontWeight: FontWeight.bold, fontSize: 30,color:Colors.white),
            ),

          ],
        ),
      ),
    );
  }
}
