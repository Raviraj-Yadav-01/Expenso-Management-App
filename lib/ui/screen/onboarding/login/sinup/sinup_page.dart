import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/local/model/user_model.dart';
import '../../../../../domain/constants/app_routes.dart';
import '../../../../custom_widgets/app_rounded_button.dart';
import '../../../../custom_widgets/uiHelper.dart';
import '../bloc/user_bloc.dart';
import '../bloc/user_event.dart';
import '../bloc/user_state.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var mobNoController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  bool isCreatingAccount = false;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xff100f1f),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.only(left: 11.0, right: 11.0, top:100,bottom:11),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Create Account",
                  style: TextStyle(color:Colors.white,fontSize: 34, fontWeight: FontWeight.bold),
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
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  decoration: myFieldDecoration(
                    hint: "Enter your name...",
                    sHint: TextStyle(color: Colors.white),
                    label: "Name",
                    sLabel: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 11),
            
                TextFormField(
                  onChanged: (value) {},
                  validator: (value) {
                    final bool emailValid = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                    ).hasMatch(value ?? "");
            
                    if (value == null || value.isEmpty) {
                      return "please enter your email";
                    } else if (!emailValid) {
                      return "please enter valid email";
                    } else {
                      return null;
                    }
                  },
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  decoration: myFieldDecoration(
                    hint: "Enter your email...",
                    sHint: TextStyle(color: Colors.white),
                    label: "email",
                    sLabel: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 11),
            
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please enter your mobile number";
                    }
            
                    if (value.length != 10) {
                      return "please enter your 10 digit mobile number";
                    }
            
                    return null;
                  },
                  controller: mobNoController,
                  keyboardType: TextInputType.phone,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  decoration: myFieldDecoration(
                    hint: "Enter your mobile number...",
                    sHint: TextStyle(color: Colors.white),
                    label: "mobile number",
                    sLabel: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 11),
            
                StatefulBuilder(
                  builder: (context, ss) {
                    return TextFormField(
                      validator: (value) {
                        final bool passwordValid = RegExp(
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                        ).hasMatch(value ?? "");
            
                        if (value == null || value.isEmpty) {
                          return "please enter your password";
                        } else if (!passwordValid) {
                          return "please enter a valid password";
                        } else {
                          return null;
                        }
                      },
            
                      controller: passwordController,
                      obscureText: !isPasswordVisible,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                      decoration: myFieldDecoration(
                        hint: "Enter your password here...",
                        sHint: TextStyle(color: Colors.white),
                        label: "Password",
                        sLabel: TextStyle(color: Colors.white),
                        isPassword: true,
                        isPasswordVisible: isPasswordVisible,
                        onPasswordVisibilityTap: () {
                          isPasswordVisible = !isPasswordVisible;
                          ss(() {});
                        },
                      ),
                    );
                  },
                ),
                SizedBox(height: 11),
            
              /*  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Minimum 8 characters, must enter at least 1 uppercase letter (A–Z), at least 1 lowercase letter (a–z), at least 1 number (0–9), at least 1 special character (e.g. @, # , % , & ",
                  ),
                ),*/
            
                SizedBox(height: 11),
            
                StatefulBuilder(
                  builder: (context, ss) {
                    return TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "please retype your password";
                        } else if (passwordController.text != value) {
                          return "password doesn't match ";
                        } else {
                          return null;
                        }
                      },
                      controller: confirmPasswordController,
                      obscureText: !isConfirmPasswordVisible,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                      decoration: myFieldDecoration(
                        hint: "retype your password here...",
                        sHint: TextStyle(color: Colors.white),
                        label: "Confirm password",
                        sLabel: TextStyle(color: Colors.white),
                        isPassword: true,
                        isPasswordVisible: isConfirmPasswordVisible,
                        onPasswordVisibilityTap: () {
                          isConfirmPasswordVisible = !isConfirmPasswordVisible;
                          ss(() {});
                        },
                      ),
                    );
                  },
                ),
                SizedBox(height: 11),
            
                BlocConsumer<UserBloc, UserState>(
                  listener: (context, state) {
                    if (state is UserLoadingState) {
                      isCreatingAccount = true;
                    }
            
                    if (state is UserFailureState) {
                      isCreatingAccount = false;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Something went to Wrong"),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
            
                    if (state is UserSuccessState) {
                      isCreatingAccount = false;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Your Account has been Created SuccessFully!!",
                          ),
                          backgroundColor: Colors.green,
                        ),
                      );
                      Navigator.pushReplacementNamed(context, AppRoutes.login);
                    }
                  },
                  builder: (context, state) {
                    return AppRoundedButton(

                      onTap: isCreatingAccount
                          ? null
                          : () {
                              if (formKey.currentState!.validate()) {
                                context.read<UserBloc>().add(
                                  RegisterUserEvent(
                                    mUser: UserModel(
                                      name: nameController.text,
                                      email: emailController.text,
                                      mobNo: mobNoController.text,
                                      pass: passwordController.text,
                                    ),
                                  ),
                                );
                              }
                            },
                      title: isCreatingAccount ? "Creating Account..." : "Sign Up" /*isIcon: false, mIcon: Icons.login,*/,
                      bgColor: Color(0xffff3952),

                    );
                  },
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
                        style: TextStyle(color:Colors.white,fontWeight: FontWeight.w600),
                      ),
                      SizedBox(width: 3),
                      Text(
                        " login now...",
                        style: TextStyle(
                          color: Color(0xffff3952),
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
      ),
    );
  }
}
