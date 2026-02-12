


import '../../../../../data/local/model/user_model.dart';

abstract class UserEvent{}


class RegisterUserEvent extends UserEvent{
  UserModel mUser;
  RegisterUserEvent({required this.mUser});

}


class LoginUserEvent extends UserEvent{
  String email;
  String pass;
  LoginUserEvent({required this.email, required this.pass});

}
