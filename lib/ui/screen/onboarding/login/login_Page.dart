import 'package:flutter/material.dart';

import '../../../domain/constants/app_routes.dart';
import '../../custom_eidgets/app_rounded_button.dart';
import '../../custom_eidgets/uiHelper.dart';


class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isPasswordVisible = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment:CrossAxisAlignment.start,
          children: [

            Text("Hi, Welcome Back",style:TextStyle(
                fontSize: 25,fontWeight: FontWeight.bold)),


            TextField(
              controller: emailController,
              decoration: myFieldDecoration(
                hint: "Enter your email...",
                label: "Email",
              ),
            ),

            SizedBox(height: 11),

            StatefulBuilder(
              builder: (context, ss) {
                return TextField(
                  controller: passwordController,
                  obscureText: !isPasswordVisible,
                  decoration:myFieldDecoration(
                    hint: "Enter your password...",
                    label: "Password",
                    isPassword: true,
                    onPasswordVisibilityTap: (){
                      isPasswordVisible = !isPasswordVisible;
                      ss((){});
                    },
                  ),
                );
              }
            ),

            SizedBox(height: 11),

           AppRoundedButton(onTap: (){}, title: "Login",isIcon:false, mIcon:Icons.login),

           /* SizedBox(
              width:double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(backgroundColor: Colors.amber,

                ),
                onPressed: () {},
                child: Text("Login", style: TextStyle(color: Colors.white)),
              ),
            ),
*/

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
