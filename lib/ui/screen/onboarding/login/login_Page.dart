import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/constants/app_routes.dart';
import '../../../custom_widgets/app_rounded_button.dart';
import '../../../custom_widgets/uiHelper.dart';
import 'bloc/user_bloc.dart';
import 'bloc/user_event.dart';
import 'bloc/user_state.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool isPasswordVisible = false;

  GlobalKey<FormState> mKey = GlobalKey();

  bool isLoading = false;
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff100f1f),
      body: Form(
        key: mKey,
        child: Padding(
          padding: const EdgeInsets.all(11.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hi, Welcome Back",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              SizedBox(height: 11),

              TextFormField(
                style: TextStyle(color: Colors.white, fontSize: 16),
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
                decoration: myFieldDecoration(
                  hint: "Enter your email...",
                  sHint: TextStyle(color: Colors.white),
                  label: "Email",
                  sLabel: TextStyle(color: Colors.white),
                ),
              ),

              SizedBox(height: 11),

              StatefulBuilder(
                builder: (context, ss) {
                  return TextFormField(
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please enter your password";
                      } else {
                        return null;
                      }
                    },
                    controller: passwordController,
                    obscureText: !isPasswordVisible,
                    decoration: myFieldDecoration(
                      hint: "Enter your password...",
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

              SizedBox(height: 21),

              BlocConsumer<UserBloc, UserState>(
                listenWhen: (prev, curr) {
                  return isLogin;
                },

                buildWhen: (prev, curr) {
                  return !isLogin;
                },

                listener: (_, state) {
                  if (state is UserLoadingState) {
                    isLoading = true;
                  }

                  if (state is UserFailureState) {
                    isLoading = false;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.errorMsg),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }

                  if (state is UserSuccessState) {
                    isLoading = false;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Logged in SuccessFully!!"),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Navigator.pushReplacementNamed(
                      context,
                      AppRoutes.dashboard,
                    );
                  }
                },

                builder: (context, state) {
                  return AppRoundedButton(
                    onTap: () {
                      if (mKey.currentState!.validate()) {
                        context.read<UserBloc>().add(
                          LoginUserEvent(
                            email: emailController.text,
                            pass: passwordController.text,
                          ),
                        );
                      }
                    },
                    title: "Login",
                    myChild: isLoading
                        ? Row(
                            children: [
                              CircularProgressIndicator(color: Colors.white),
                              SizedBox(width: 11),
                              Text(
                                'Loading',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          )
                        : null,
                    bgColor: Color(0xffff3952),
                  );
                },
              ),

              SizedBox(height: 11),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, AppRoutes.signup);
                    },
                    child: Text(
                      "Create now...",
                      style: TextStyle(
                        fontFamily: "regular",
                        color: Color(0xffff3952),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
