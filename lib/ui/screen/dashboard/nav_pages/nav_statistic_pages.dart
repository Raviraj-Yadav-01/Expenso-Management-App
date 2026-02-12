import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/Material.dart';

import '../../../../data/local/model/fliter_expense_model.dart';

class StatisticPage extends StatelessWidget {
  StatisticPage({super.key});

  List<FilterExpenseModel> dummyData = [
    FilterExpenseModel(title: "jan", balance: 20000, eachTitleExp: []),
    FilterExpenseModel(title: "feb", balance: 25000, eachTitleExp: []),
    FilterExpenseModel(title: "mar", balance: 40000, eachTitleExp: []),
    FilterExpenseModel(title: "Apr", balance: 60000, eachTitleExp: []),
    FilterExpenseModel(title: "May", balance: 30000, eachTitleExp: []),
    FilterExpenseModel(title: "Jun", balance: 50000, eachTitleExp: []),
    FilterExpenseModel(title: "July", balance: 10000, eachTitleExp: []),
    FilterExpenseModel(title: "Aug", balance: 25000, eachTitleExp: []),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar:AppBar(

          title:Text("Fl chart",style: TextStyle(color:Colors.white),),
          centerTitle: true,
          backgroundColor:Color(0xff100f1f),
          actions:[
            IconButton(onPressed:(){},icon:Icon(Icons.search),color:Colors.white),
          ]
      ),

     // backgroundColor: Color(0xff100f1f),
      body: Container(
        padding: EdgeInsets.only(top: 21),
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(/*color: Color(0xff100f1f)*/),
        child: BarChart(
          BarChartData(

            backgroundColor: Color(0xff100f1f),
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (index, _) {
                    return Text(
                      dummyData[index.toInt()].title,
                      style: TextStyle(color: Colors.white),
                    );
                  },
                ),
              ),
            ),
            maxY: 100000,
            barGroups: List.generate(dummyData.length, (index) {
              return BarChartGroupData(x: index,
                barRods: [ BarChartRodData(toY: dummyData[index].balance.toDouble(),color: Colors.blue.shade200),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
