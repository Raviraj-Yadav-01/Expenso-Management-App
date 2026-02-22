
import '../../../../data/local/model/expense_model.dart';
import '../../../../data/local/model/fliter_expense_model.dart';

abstract class ExpenseState{}


class ExpInitialState extends ExpenseState{}

class   ExpLoadingState extends ExpenseState{}

class   ExpLoadedState extends ExpenseState{
 List<FilterExpenseModel> allExp;
 num mainBalance;
 ExpLoadedState({required this.allExp, required this.mainBalance});
}


class ExpErrorState extends ExpenseState{
  String errorMsg;
  ExpErrorState({required this.errorMsg});
}
