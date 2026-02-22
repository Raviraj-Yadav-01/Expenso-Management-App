import 'package:expenso_422/ui/screen/add_expense/expense_bloc/expense_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/constants/app_routes.dart';
import '../add_expense/expense_bloc/expense_bloc.dart';
import '../add_expense/expense_bloc/expense_event.dart';
import 'nav_pages/nav_home_Page.dart';
import 'nav_pages/nav_notification_page.dart';
import 'nav_pages/nav_profile_page.dart';
import 'nav_pages/nav_statistic_pages.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  int selectedIndex = 0;
  num currBal = 0.0;

  List<Widget> mPages = [
    HomePage(),
    StatisticPage(),
    Container(),
    NotificationPage(),
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    context.read<ExpenseBloc>().add(FetchInitialExpenseEvent());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: mPages[selectedIndex],

      bottomNavigationBar: BlocListener<ExpenseBloc, ExpenseState>(
        listener: (context, state){

          if(state is ExpLoadedState){
             currBal = state.mainBalance;
          }

        },child: BottomNavigationBar(
        backgroundColor:Color(0xff100f1f),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xffff3952),
        unselectedItemColor: Color(0xffff3952),
        showUnselectedLabels: false,
        showSelectedLabels: false,
        onTap: (index) {

          if(index == 2){
            Navigator.pushNamed(context, AppRoutes.addExpense, arguments:currBal);
          }else {
            selectedIndex = index;
            setState(() {});
          }
        },
        iconSize: 26,
        currentIndex: selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "home",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_outlined),
            label: "status",
          ),

          BottomNavigationBarItem(
              icon: Container(
                  width:45,
                  height:45,
                  decoration:BoxDecoration(
                      color: Color(0xffff3952),
                      borderRadius: BorderRadius.circular(9)
                  ),
                  child: Icon(Icons.add,color:Colors.white)),label: "Add"),

          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_active_outlined),
            label: "Notification",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: "profile",
          ),
        ],
      )
      ),
    );
  }
}
