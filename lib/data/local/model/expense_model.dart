class ExpenseModel {
  int id;
  int userId;
  String title;
  String desc;
  num amt;
  num bal;
  int expType;
  int catId;
  int createdAt;

  ExpenseModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.desc,
    required this.amt,
    required this.bal,
    required this.expType,
    ///1=> Debit , 3=> Credit
    required this.catId,
    required this.createdAt,
  });
}
