import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../data/local/model/expense_model.dart';
import '../../../domain/constants/app_contants.dart';
import '../../custom_widgets/uiHelper.dart';
import 'bloc/expense_bloc.dart';
import 'bloc/expense_event.dart';
import 'bloc/expense_state.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});
  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  var titleController = TextEditingController();
  var descController = TextEditingController();
  var amtController = TextEditingController();

  int selectedType = 1;
  List<String> myTypes = ["Debit", "Credit"];

  int selectedCatIndex = -1;
  DateTime? selectedDate;
  DateTime? selectedDateTime;
  TimeOfDay? selectedTime;
  DateFormat df = DateFormat();
  DateFormat tf = DateFormat.jms();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

     appBar: AppBar(
         title: Text("Add Expense",style: TextStyle(color: Colors.white),),
         backgroundColor:Color(0xff100f1f),
         centerTitle: false),

      backgroundColor:Color(0xff100f1f),

      body: Padding(
        padding: const EdgeInsets.only(top:20, left:11, right:11),
        child: SingleChildScrollView(
          child: Column(
            children: [

              TextField(
                controller: titleController,
                style: TextStyle(color: Colors.white),
                decoration: myFieldDecoration(
                  hint: "Enter your title here..",
                  sHint: TextStyle(color: Colors.white),
                  label: "Title",
                  sLabel: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 11),

              TextField(
                controller: descController,
                style: TextStyle(color: Colors.white),
                decoration: myFieldDecoration(
                  hint: "Enter your desc here..",
                  sHint: TextStyle(color: Colors.white),
                  label: "Desc",
                  sLabel: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 11),

              TextField(
                controller: amtController,
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.white),
                decoration: myFieldDecoration(
                  hint: "Enter your amount here..",
                  sHint: TextStyle(color: Colors.white),
                  label: "Amount",
                  sLabel: TextStyle(color: Colors.white),
                ),
              ),


              SizedBox(height: 11),
              /* DropdownButton(
              value : selectedType,
              items:[
                 DropdownMenuItem(value:"Debit", child:Text("Debit")),
                 DropdownMenuItem(value:"Credit", child:Text("Credit")),
               ],
              onChanged:(value){
              selectedType = value!;
              setState((){});
             }),*/
              DropdownMenu(
                width: double.infinity,
                inputDecorationTheme: InputDecorationTheme(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(21),
                  ),
                ),
                label: Text('Type',style: TextStyle(color: Colors.white)),
                initialSelection: selectedType,
                onSelected: (value) {
                  selectedType = value!;
                },
                dropdownMenuEntries: List.generate(myTypes.length, (i){
                  return DropdownMenuEntry(value: i+1, label: myTypes[i]);
                }),
              ),
              SizedBox(height: 11),

              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(21),
                  ),
                ),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: ((context) {
                      return Container(
                        padding: EdgeInsets.only(top: 11, right: 11, left: 11),
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                mainAxisSpacing: 5,
                                crossAxisSpacing: 5,
                              ),
                          itemCount: AppConstants.allCat.length,
                          itemBuilder: (_, index) {
                            return InkWell(
                              onTap: () {
                                selectedCatIndex = index;
                                setState(() {});
                                Navigator.pop(context);
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                    AppConstants.allCat[index].imgPath,
                                    width: 50,
                                    height: 50,
                                  ),
                                  Text(AppConstants.allCat[index].title),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    }),
                  );
                },
                child: selectedCatIndex < 0
                    ? Text("add Category")
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppConstants.allCat[selectedCatIndex].imgPath,
                            width: 50,
                            height: 50,
                          ),
                          SizedBox(width: 11),
                          Text("- Category ${AppConstants.allCat[selectedCatIndex].title}",
                            style: TextStyle(fontSize: 20,color: Colors.white),
                          ),
                        ],
                      ),
              ),

              SizedBox(height: 11),
              //DateTime builder

              StatefulBuilder(
                builder: (context, setState) {
                  return OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size(double.infinity, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(21),
                      ),
                    ),
                    onPressed: () async {
                      selectedDate = await showDatePicker(
                        context: context,
                        firstDate: DateTime.now().subtract(Duration(days: 365)),
                        lastDate: DateTime.now());

                      selectedTime = await showTimePicker( context: context,
                        initialTime: TimeOfDay(hour:DateTime.now().hour,minute:DateTime.now().minute));

                      DateTime userDate = selectedDate ?? DateTime.now();
                      TimeOfDay userTime = selectedTime ?? TimeOfDay.now();
                      selectedDateTime = DateTime(userDate.year, userDate.month, userDate.day, userTime.hour, userTime.minute);

                      setState(() {});
                    },
                    child: Text(df.format(selectedDate ?? DateTime.now()),style: TextStyle(color: Colors.white)),
                  );
                },
              ),

              SizedBox(height: 11),
             /* StatefulBuilder(
                builder: (context, setState) {
                  return OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size(double.infinity, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(21),
                      ),
                    ),
                    onPressed: () async {

                      selectedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay(hour:DateTime.now().hour, minute:DateTime.now().minute),
                      );

                      setState(() {});
                    },
                    child: Text((selectedTime ?? TimeOfDay.now()).format(context)),
                  );
                },
              ),
              SizedBox(height: 11),*/

              BlocListener<ExpenseBloc, ExpenseState>(
                listener: (context, state) {
                  if (state is ExpErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.errorMsg), backgroundColor: Colors.red,
                      ),
                    );
                  }

                  if (state is ExpLoadedState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Expense Added successfully"), backgroundColor: Colors.green,
                      ));
                    Navigator.pop(context);
                  }
                },
                child: ElevatedButton(

                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 60),
                    backgroundColor:Color(0xffff3952),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(21),
                    ),
                  ),
                  onPressed: () {

                    context.read<ExpenseBloc>().add(
                      AddExpenseEvent(
                        newExp: ExpenseModel(
                          title: titleController.text,
                          desc: descController.text,
                          amt: double.parse(amtController.text),
                          bal: 0.0,
                          expType: selectedType,
                          catId: AppConstants.allCat[selectedCatIndex].id,
                          createdAt: (selectedDateTime  ?? DateTime.now()).millisecondsSinceEpoch,
                        ),
                      ),
                    );
                  },
                  child: Text("Add Expense"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
