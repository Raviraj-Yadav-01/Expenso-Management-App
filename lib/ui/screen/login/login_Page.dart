import 'package:flutter/material.dart';

import '../../../domain/constants/app_routes.dart';


class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(right:11, left:11, top:300, bottom:200),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment:CrossAxisAlignment.start,
          children: [

            Text("Hi, Welcome Back",textAlign:TextAlign.start,style:TextStyle(
                fontSize: 25,fontWeight: FontWeight.bold)),

            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: "Enter your email or mobile number",
                labelText: "Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),

                //prefixIcon: Icon(Icons.email)
              ),
            ),

            SizedBox(height: 11),

            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                hintText: "Enter your password",
                labelText: "password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),

                //prefixIcon: Icon(Icons.email)
              ),
            ),

            SizedBox(height: 11),

            SizedBox(
              width:double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(backgroundColor: Colors.amber,

                ),
                onPressed: () {},
                child: Text("Login", style: TextStyle(color: Colors.white)),
              ),
            ),

            Row(
              mainAxisAlignment:MainAxisAlignment.center,
              children:[
                Text("Don't have an account?",style:TextStyle(fontWeight: FontWeight.w400)),
                TextButton(onPressed: (){
                  Navigator.pushReplacementNamed(context, AppRoutes.signup);
                }, child: Text("Create now..." ,style: TextStyle(color: Colors.amber)
                )
                )
              ]
            )
          ],
        ),
      ),
    );
  }
}
