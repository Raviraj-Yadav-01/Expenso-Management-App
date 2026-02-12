

import '../../../domain/constants/app_contants.dart';

class UserModel{

 int? id;
 String name;
 String email;
 String mobNo;
 String? pass;

 UserModel({
   this.id,
   required this.name,
   required this.email,
   required this.mobNo,
   this.pass,
  });

 factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
     id: map[AppConstants.columnUserId],
     name: map[AppConstants.columnUserName],
     email: map[AppConstants.columnUserEmail],
     mobNo: map[AppConstants.columnUserMobNo],
     //pass: map[AppConstraints.columnUserPassword]
     );


 Map<String, dynamic> toMap() => {
   AppConstants.columnUserName : name,
   AppConstants.columnUserEmail : email,
   AppConstants.columnUserMobNo : mobNo,
   AppConstants.columnUserPassword : pass,

 };

}

