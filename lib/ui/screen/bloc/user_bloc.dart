

import 'package:expenso_422/ui/screen/bloc/user_event.dart';
import 'package:expenso_422/ui/screen/bloc/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/local/helper/dbHelper.dart';

class UserBloc extends Bloc<UserEvent , UserState>{

DBHelper dbHelper;

UserBloc({required this.dbHelper}) : super(UserInitialState()){

    on<RegisterUserEvent>((event, emit) async {

      emit(UserLoadingState());

      int check = await dbHelper.createUser(newUser:event.mUser);

      if(check == 3){
        emit(UserSuccessState());
      }else if(check == 2){
        emit(UserFailureState(errorMsg:"user alReady exists"));
        }else{
        emit(UserFailureState(errorMsg:"SomeThing went wrong"));
      }


    });

    on<LoginUserEvent>((event, emit)async{

      emit(UserLoadingState());

      int check = await dbHelper.authenticateUser(email:event.email, pass:event.pass);

      if(check==1){
        emit(UserSuccessState());
      }else if(check==3){
        emit(UserFailureState(errorMsg: "password incorrect"));
      }else{
        emit(UserFailureState(errorMsg: "Email invalid!!"));
      }

    });
  }


}