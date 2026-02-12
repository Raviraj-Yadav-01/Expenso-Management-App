import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../data/local/helper/dbHelper.dart';
import '../../../../data/local/model/categort_model.dart';
import '../../../../data/local/model/expense_model.dart';
import '../../../../data/local/model/fliter_expense_model.dart';
import '../../../../domain/constants/app_contants.dart';
import 'expense_event.dart';
import 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  DBHelper dbHelper;

  ExpenseBloc({required this.dbHelper}) : super(ExpInitialState()) {


    on<AddExpenseEvent>((event, emit) async {
      emit(ExpLoadingState());

      bool isAdded = await dbHelper.addExpense(newModel: event.newExp);

      if (isAdded) {
        var allExp = await dbHelper.getAllExpenses();
        emit(ExpLoadedState(allExp: filterAllExp(allExp, 1)));
      } else {
        emit(ExpErrorState(errorMsg: "Something went wrong"));
      }
    });

    on<FetchInitialExpenseEvent>((event, emit) async {
      emit(ExpLoadingState());

      var allExp = await dbHelper.getAllExpenses();
      emit(ExpLoadedState(allExp: filterAllExp(allExp, event.filterFlag)));
    });
  }





  List<FilterExpenseModel> filterAllExp( List<ExpenseModel> allExpense, int flag ) {

  List<FilterExpenseModel> filteredExpenses = [];

    ///filter == 1 => date wise
    if (flag<4) {
      DateFormat df = DateFormat.y();
      if (flag==1) {
        df = DateFormat.yMMMMd();
      } else if (flag==2) {
        df = DateFormat.yMMMM();
      }

      ///uniqueDate
      List<String> uniqueDates = [];

      for (ExpenseModel eachExp in allExpense) {
        String eachDate = df.format(
          DateTime.fromMillisecondsSinceEpoch(eachExp.createdAt),
        );
        if (!uniqueDates.contains(eachDate)) {
          uniqueDates.add(eachDate);
        }
      }

      for (String eachUniqueDate in uniqueDates) {
        num totalExp = 0.0;

        List<ExpenseModel> eachDateExp = [];

        for (ExpenseModel eachExp in allExpense) {
          String eachDate = df.format(
            DateTime.fromMillisecondsSinceEpoch(eachExp.createdAt),
          );

          if (eachUniqueDate == eachDate) {
            eachDateExp.add(eachExp);

            if (eachExp.expType == 1) {
              totalExp -= eachExp.amt;
            }else{
              totalExp += eachExp.amt;
            }
          }
        }

        filteredExpenses.add(FilterExpenseModel(
            title: eachUniqueDate,
            balance: totalExp,
            eachTitleExp: eachDateExp,
          ),
        );
      }
    }
    else {
      ///cat wise
      List<CatModel> uniqueCats = AppConstants.allCat;

      for (CatModel eachCat in uniqueCats) {
        num totalExp = 0.0;
        List<ExpenseModel> eachDateExp = [];

        for (ExpenseModel eachExp in allExpense) {
          if (eachExp.catId==eachCat.id) {
            eachDateExp.add(eachExp);

            if (eachExp.expType == 1) {
              totalExp -= eachExp.amt;
            } else {
              totalExp += eachExp.amt;
            }
          }
        }
        filteredExpenses.add(
          FilterExpenseModel(
            title: eachCat.title,
            balance: totalExp,
            eachTitleExp: eachDateExp,
          ),
        );
      }
    }

    return filteredExpenses;
  }
}
