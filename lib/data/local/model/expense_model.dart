import '../../../domain/constants/app_contants.dart';

class ExpenseModel {
  int? id;
  int? userId;
  String title;
  String desc;
  num amt;
  num bal;
  int expType;
  ///1=> Debit ,
  ///2=> Credit
  int catId;
  int createdAt;

  ExpenseModel({
    this.id,
    this.userId,
    required this.title,
    required this.desc,
    required this.amt,
    required this.bal,
    required this.expType,
    required this.catId,
    required this.createdAt,
  });

  factory ExpenseModel.fromMap(Map<String, dynamic> map) =>
   ExpenseModel(
     id: map[AppConstants.columnExpId],
       userId: map[AppConstants.columnUserId],
      title: map[AppConstants.columnExpTitle],
      desc: map[AppConstants.columnExpDesc],
      amt: map[AppConstants.columnExpAmt],
      bal: map[AppConstants.columnExpBal],
      expType: map[AppConstants.columnExpType],
      catId : map[AppConstants.columnExpCatId],
      createdAt :int.parse(map[AppConstants.columnExpCreatedAt])
    );



  Map<String, dynamic> toMap() => {
    AppConstants.columnUserId: userId,
    AppConstants.columnExpTitle: title,
    AppConstants.columnExpDesc: desc,
    AppConstants.columnExpAmt: amt,
    AppConstants.columnExpBal: bal,
    AppConstants.columnExpType: expType,
    AppConstants.columnExpCatId: catId,
    AppConstants.columnExpCreatedAt: createdAt.toString(),
  };
}
