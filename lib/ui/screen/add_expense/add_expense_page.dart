import 'package:flutter/Material.dart';
import '../../../../domain/constants/app_contants.dart';
import '../../../custom_widgets/uiHelper.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  var titleController = TextEditingController();
  var descController = TextEditingController();
  var amountController = TextEditingController();

  String selectedType = "Debit";
  int selectedCatIndex = -1;

  List<String> myType = ["Debit", "Credit" /*,"Loan","Lic"*/];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Expense"), centerTitle: true),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: myFieldDecoration(
                hint: "Enter your title here..",
                label: "Title",
              ),
            ),
            SizedBox(height: 11),

            TextField(
              controller: descController,
              decoration: myFieldDecoration(
                hint: "Enter your desc here..",
                label: "Desc",
              ),
            ),
            SizedBox(height: 11),

            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: myFieldDecoration(
                hint: "Enter your amount here..",
                label: "Amount",
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
              label: Text("Type"),
              initialSelection: selectedType,
              onSelected: (value) {
                selectedType = value!;
                setState(() {});
              },
              dropdownMenuEntries: myType.map((eachType) {
                return DropdownMenuEntry(value: "Credit", label: eachType);
              }).toList(),
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
                showModalBottomSheet(context: context,
                  builder: ((context) {
                    return Container(
                      padding: EdgeInsets.only(top: 11, right: 11, left: 11),
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
              }, child: selectedCatIndex < 0
                  ? Text("add Category")
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(AppConstants.allCat[selectedCatIndex].imgPath,
                          width: 50, height: 50,
                        ),
                        SizedBox(width: 11),
                        Text("- Category ${AppConstants.allCat[selectedCatIndex].title}",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
            ),
            SizedBox(
              height:11
            ),

            ElevatedButton(
              style:ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 60),
                  backgroundColor:Colors.amber,
                foregroundColor:Colors.white,
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(21),)
              ),
              onPressed:(){

            },child:Text("Add Expense"))
          ],
        ),
      ),
    );
  }
}
