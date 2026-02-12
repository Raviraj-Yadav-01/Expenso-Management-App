import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../../../domain/constants/app_contants.dart';
import '../model/expense_model.dart';
import '../model/user_model.dart';

class DBHelper {

  DBHelper._();

  static  DBHelper getInstance() => DBHelper._();

  Database? mDB;

  Future<Database> initDB() async {
    mDB ??= await openDB();
    return mDB!;
  }

  Future<Database> openDB() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String dbPath = join(appDocDir.path, AppConstants.dbName);
    return await openDatabase(dbPath, version: 2, onCreate: (db, version) {
      db.execute("create Table ${AppConstants.userTable} ( ${AppConstants.columnUserId} integer primary key autoincrement, ${AppConstants.columnUserName} text,${AppConstants.columnUserEmail} text,${AppConstants.columnUserMobNo} text,${AppConstants.columnUserPassword} text)");

      db.execute("create table ${AppConstants.expenseTable} ("
          "${AppConstants.columnExpId} integer primary key autoincrement,"
          "${AppConstants.columnExpTitle} text,"
          "${AppConstants.columnExpDesc} text , "
          "${AppConstants.columnUserId} integer, "
          "${AppConstants.columnExpAmt} real, "
          "${AppConstants.columnExpBal} real , "
          "${AppConstants.columnExpType} num , "
          "${AppConstants.columnExpCatId} integer , "
          "${AppConstants.columnExpCreatedAt} text)"
      );
    });
  }
  ///Register user Queries
  /// 1 some error occur
  /// 2 user already exist
  /// 3 user created
  Future<int> createUser({required UserModel newUser}) async {
    var db = await initDB();

    if (!await checkIfUserAlreadyExists(email: newUser.email)) {
      int rowEffected = await db.insert(
          AppConstants.userTable, newUser.toMap());
      return rowEffected > 0 ? 3 : 1;
    } else {
      return 2;
    }
  }

  Future<bool> checkIfUserAlreadyExists({required String email}) async {
    var db = await initDB();
    List<Map<String, dynamic>> users = await db.query(AppConstants.userTable,
      where: "${AppConstants.columnUserEmail} = ?",
      whereArgs: [email],
    );
    return users.isNotEmpty;
  }


   ///User Authentication Queries
  /// 1 login success
  /// 2 invalid email
  /// 3 invalid password
  Future<int> authenticateUser({required String email, required String pass}) async {
    var db = await initDB();

    if (await checkIfUserAlreadyExists(email: email)) {
      List<Map<String, dynamic>> users = await db.query(AppConstants.userTable,
        where: "${AppConstants.columnUserEmail} = ? AND ${AppConstants.columnUserPassword} = ?",
        whereArgs: [email, pass],
      );

      if (users.isNotEmpty) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setInt(
            AppConstants.prefs_user_id, users[0][AppConstants.columnUserId]);
        return 1;
      } else {
        return 3;
      }
    } else {
      //invalid email
      return 2;
    }
  }


  //// expense add Query
  Future<bool> addExpense({required ExpenseModel newModel}) async {
    var db = await initDB();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    int uId = prefs.getInt(AppConstants.prefs_user_id) ?? 0;
    newModel.userId = uId;

    int rowEffected = await db.insert(
        AppConstants.expenseTable, newModel.toMap());
    return rowEffected > 0;
  }


  //// expense add Query
  Future<List<ExpenseModel>> getAllExpenses() async {
    var db = await initDB();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int uId = prefs.getInt(AppConstants.prefs_user_id) ?? 0;

    var allExpMap = await db.query(AppConstants.expenseTable,
        where: "${AppConstants.columnUserId} = ?", whereArgs: ["$uId"]);

    List<ExpenseModel> allExpensesModel = [];

    for(Map<String, dynamic> eachExp in allExpMap){
      allExpensesModel.add(ExpenseModel.fromMap(eachExp));
    }
    return allExpensesModel;
  }


}