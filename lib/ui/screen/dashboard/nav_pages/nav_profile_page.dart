import 'package:flutter/Material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../domain/constants/app_contants.dart';
import '../../../../domain/constants/app_routes.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar:AppBar(

          title:Text("Profile",style: TextStyle(color:Colors.white),),
          centerTitle: true,
          backgroundColor:Color(0xff100f1f),
          actions:[
            IconButton(onPressed:(){},icon:Icon(Icons.search),color:Colors.white),
            IconButton(onPressed:()async{
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setInt(AppConstants.prefs_user_id, 0);
              Navigator.pushReplacementNamed(context ,AppRoutes.login);
            },icon:Icon(Icons.logout_outlined),color:Colors.white),
          ]
      ),

      backgroundColor:Color(0xff100f1f),

      body: Padding(
        padding: const EdgeInsets.only(top:15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: CircleAvatar(
                  radius: 70,
                 // backgroundImage: AssetImage("asset/image/1695133307094.jpg"),
                  backgroundImage: NetworkImage(
                    "https://media.licdn.com/dms/image/v2/D4E03AQGkILvxp79lbA/profile-displayphoto-scale_400_400/B4EZp23bstJgAg-/0/1762930836059?e=1766016000&v=beta&t=FcgwDIpatKXWkcC7l8QbseCElGL7dZr6j9ot2ZeqBIw",
                  ),
          
                ),
              ),
              SizedBox(height: 11),

              Text("RaviRaj",style:TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color:Colors.grey)),
              SizedBox(height:5),
          
              Text("ravirajkumar758@mail.com",style:TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color:Colors.grey)),
              SizedBox(height:20),
          
              TextField(
                decoration: InputDecoration(
                  hintText: "UserId",
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.supervised_user_circle,color:Colors.grey),
                  suffixIcon: Icon(Icons.arrow_forward_ios_sharp,size:17,color: Colors.grey)
                )
          
              ),
              SizedBox(height:20),
          
              TextField(
                decoration: InputDecoration(
                  hintText: "Security",
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.verified_user_outlined,color:Colors.grey),
                  suffixIcon: Icon(Icons.arrow_forward_ios_sharp,size:17,color: Colors.grey)
                )
          
              ),
              SizedBox(height:20),
          
              TextField(
                decoration: InputDecoration(
                  hintText: "Wallet",
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.wallet,color:Colors.grey),
                  suffixIcon: Icon(Icons.arrow_forward_ios_sharp,size:17,color:Colors.grey)
                )
              ),
              SizedBox(height:20),

              TextField(
                decoration: InputDecoration(
                  hintText: "Notifications",
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.notifications_none_outlined,color:Colors.grey),
                  suffixIcon: Icon(Icons.arrow_forward_ios_sharp,size:17,color:Colors.grey)
                )
              ),
              SizedBox(height:20),

              TextField(
          
                decoration: InputDecoration(
                  hintText: "Feedback",
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.feed_outlined,color:Colors.grey),
                  suffixIcon: Icon(Icons.arrow_forward_ios_sharp,size:17,color: Colors.grey)
                )
              ),
              SizedBox(height:20),
            ],
          ),
        ),
      ),
    );
  }
}
