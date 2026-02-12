
import 'dart:math';

import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../data/local/model/expense_model.dart';
import '../../../../domain/constants/app_contants.dart';
import '../../add_expense/bloc/expense_bloc.dart';
import '../../add_expense/bloc/expense_event.dart';
import '../../add_expense/bloc/expense_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateFormat tf = DateFormat.jms();
  List<String> mType = [
    "Date-wise",
    "Month-wise",
    "Year-wise",
    "Category-wise",
  ];
  int selectedType = 1;

  @override
  void initState() {
    super.initState();
    context.read<ExpenseBloc>().add(FetchInitialExpenseEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor:Color(0xff100f1f),

      body: Padding(
        padding: const EdgeInsets.only( top:40,left:8,right:8),
        child: Column(
          children: [
            headerLay(),
            SizedBox(height: 7),
            mainLay(),
          ],
        ),
      ),
    );
  }

  Widget headerLay(){
    return Row(
      children: [
        CircleAvatar(
          radius: 22,
          backgroundColor: Colors.amber.shade400,
          backgroundImage: NetworkImage(
            "https://media.licdn.com/dms/image/v2/D4E03AQGkILvxp79lbA/profile-displayphoto-scale_400_400/B4EZp23bstJgAg-/0/1762930836059?e=1766016000&v=beta&t=FcgwDIpatKXWkcC7l8QbseCElGL7dZr6j9ot2ZeqBIw",
          ),
        ),
        SizedBox(width: 11),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Morning',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'RaviRaj Yadav',
                style: TextStyle(
                  fontFamily: "Poppins",
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 11),

        Container(
          padding: EdgeInsets.symmetric(horizontal: 11),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(21),
            //border: Border.all(color: Colors.blue.shade100),
          ),
          child: DropdownButton(
            focusColor:Colors.amber,
            elevation: 8,
            value: selectedType,
            dropdownColor:Colors.white,

            items: List.generate(mType.length, (i) {
              return DropdownMenuItem(
                value: i+1,
                child: Text(mType[i]),
              );
            }),
            onChanged: (value) {
              selectedType = value!;
              context.read<ExpenseBloc>().add(FetchInitialExpenseEvent(filterFlag: value));
              setState(() {});
            },
          ),
        ),
      ],
    );
  }

  Widget mainLay(){
    return Expanded(
      child: BlocBuilder<ExpenseBloc, ExpenseState>(
        builder: (context, state) {
          if (state is ExpLoadingState) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is ExpErrorState) {
            return Center(child: Text(state.errorMsg));
          }

          if (state is ExpLoadedState) {
            return state.allExp.isNotEmpty
                ? Column(
                crossAxisAlignment:CrossAxisAlignment.start ,
                children: [
                Text('ExpenseList',
                  style: TextStyle(color:Colors.white,fontSize: 16, fontWeight: FontWeight.bold,),),

                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.allExp.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Container(
                          //margin: EdgeInsets.symmetric(vertical:11),
                          decoration: BoxDecoration(
                            color: Colors.red.shade200,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.amber),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(state.allExp[index].title, style: TextStyle(fontSize: 16),),
                                    Text(state.allExp[index].balance.toString(), style: TextStyle(fontSize: 16),),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Container(
                                  height: 1,
                                  width: double.infinity,
                                  color: Colors.grey.shade400,
                                ),
                                SizedBox(height: 5),
                        
                                ListView.builder(
                                  physics:
                                  NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: state.allExp[index].eachTitleExp.length,
                                  itemBuilder: (_, childIndex) {
                                    ExpenseModel eachExp = state.allExp[index].eachTitleExp[childIndex];
                        
                                    String imgPath = AppConstants.allCat.firstWhere((element) {
                                      return element.id == eachExp.catId;
                                    }).imgPath;
                                    DateTime eachExpDate = DateTime.fromMillisecondsSinceEpoch(eachExp.createdAt,
                                    );
                        
                                    return ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      leading: Container(padding: EdgeInsets.all(5), height: 40, width: 40,
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(7),
                                          color:
                                          Colors
                                              .primaries[Random().nextInt(Colors.primaries.length,)],
                                        ),
                                        child: Image.asset(
                                          imgPath,
                                          width: 20,
                                          height: 20,
                                        ),
                                      ),
                                      title: Text(eachExp.title),
                                      subtitle: Text(eachExp.desc),
                                      trailing: Column(
                                        children: [
                                          Text( tf.format(eachExpDate)),
                                          Text( eachExp.amt.toString()),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                 ],
                 ) : Center(child: Text("no Expenses Yet!!"));
          } return Container();
        },
      ),
    );
  }
}
