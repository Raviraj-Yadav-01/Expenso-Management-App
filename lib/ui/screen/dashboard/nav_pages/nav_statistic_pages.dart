
import 'package:flutter/Material.dart';

class StatsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Stats"), centerTitle: true),
      backgroundColor:Colors.yellow.shade200,
      body: Center(child: Text("Stats",style:TextStyle(color:Colors.yellow.shade200))),
    );
  }
}