import 'package:flutter/material.dart';

import '../../custom_eidgets/app_rounded_button.dart';
import '../../custom_eidgets/uiHelper.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobNoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key:formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Create Account",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 11),

              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "please enter your name";
                  } else {
                    return null;
                  }
                },
                controller: nameController,
                keyboardType: TextInputType.name,
                decoration: myFieldDecoration(
                  hint: "Enter your name...",
                  label: "Name",
                ),
              ),
              SizedBox(height: 11),

              TextFormField(
                validator: (value) {

                  bool emailValid = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$').hasMatch(value ?? "");

                  if (value == null || value.isNotEmpty) {
                    return "please enter your email";
                  } else if (!emailValid) {
                    return "please enter valid email";
                  } else {
                    return null;
                  }
                },
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: myFieldDecoration(
                  hint: "Enter your email...",
                  label: "email",
                ),
              ),
              SizedBox(height: 11),

              TextFormField(
                validator: (value) {
                  bool mobileValid = RegExp(r'^[0-9]{10}$').hasMatch(value??"");

                  if (value == null || value.isEmpty) {
                    return "please enter your mobile number";
                  }

                  if (value.length != 10) {
                    return "please enter your 10 digit mobile number";
                  } else {
                    return null;
                  }
                },
                controller:mobNoController,
                keyboardType: TextInputType.phone,
                decoration: myFieldDecoration(
                  hint: "Enter your mobile number...",
                  label: "mobile number",
                ),
              ),
              SizedBox(height: 11),

              StatefulBuilder(
                builder: (context,ss) {
                  return TextFormField(
                    validator: (value) {
                      final bool passwordValid = RegExp(
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                          .hasMatch(value ?? "");

                      if (value == null || value.isNotEmpty) {
                        return "please enter your password";
                      } else if (!passwordValid) {
                        return "enter your valid password";
                      }else{
                        return null;
                      }
                    },
                    controller: passwordController,
                    obscureText: !isPasswordVisible,
                    decoration: myFieldDecoration(
                      hint: "Enter your password...",
                      label: "Password",
                      isPassword: true,
                      isPasswordVisible: isPasswordVisible,
                      onPasswordVisibilityTap: (){
                        isPasswordVisible = !isPasswordVisible;
                        ss((){});
                      },
                    ),
                  );
                }
              ),
              SizedBox(height: 11),

              Text("Minimum 8 characters, must enter at least 1 uppercase letter (A–Z), at least 1 lowercase letter (a–z), at least 1 number (0–9), at least 1 special character (e.g. @, # , % , & "),

              SizedBox(height: 11),

              StatefulBuilder(
                builder: (context, ss) {
                  return TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please retype your password";
                      } else if(passwordController.text!=value) {
                        return "password doesn't match ";
                      }else{
                        return null;
                      }
                    },
                    controller:confirmPasswordController,
                    obscureText: !isConfirmPasswordVisible,
                    decoration: myFieldDecoration(
                      hint: "retype your password...",
                      label: "Confirm password",
                      isPassword: true,
                      isPasswordVisible: isConfirmPasswordVisible,
                      onPasswordVisibilityTap: (){
                        isConfirmPasswordVisible = !isConfirmPasswordVisible;
                        ss((){});
                      },
                    ),
                  );
                }
              ),
              SizedBox(height: 11),

              AppRoundedButton(

                onTap: () {
                  if(formKey.currentState!.validate()){
                    //create a user
                  }
                },
                title: "Sign Up",
                isIcon: false,
                mIcon: Icons.login,
              ),
              SizedBox(height: 5),

              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, "/login");
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "if already have an account,",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(width: 3),
                    Text(
                      " login now...",
                      style: TextStyle(
                        color: Colors.amber,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
