

import '../../data/local/model/categort_model.dart';

class AppConstants{

  ///img path
  static const String img_coffe = "assets/icons/coffee.png";
  static const String img_fast_food = "assets/icons/fast-food.png";
  static const String img_travel = "assets/icons/travel.png";
  static const String img_snacks = "assets/icons/snack.png";
  static const String img_shoping = "assets/icons/shopping-bag.png";
  static const String img_expense = "assets/icons/expenses_5501375.png";
  static const String img_giftBox = "assets/icons/gift-box.png";
  static const String img_shirt = "assets/icons/hawaiian-shirt.png";
  static const String img_hot_pot = "assets/icons/hot-pot.png";
  static const String img_app_logo = "assets/icons/ic_app_logo.png";
  static const String img_app_outlinr_logo = "assets/icons/ic_app_logo_outline.png";
  static const String img_solid_logo = "assets/icons/ic_app_logo_solid.png";
  static const String img_mekeup_pouch = "assets/icons/makeup-pouch.png";
  static const String img_mobile_transfer = "assets/icons/mobile-transfer.png";
  static const String img_resturant = "assets/icons/restaurant.png";
  static const String img_smartPhone = "assets/icons/smartphone.png";
  static const String img_tools = "assets/icons/tools.png";
  static const String img_vegetables = "assets/icons/vegetables.png";
  static const String img_vehicles = "assets/icons/vehicle.png";
  static const String img_watch = "assets/icons/watch.png";





  ///expense table
  static const String expTable = "e_table";
  static const String columnExpId = "e_id";
  static const String columnExpTitle = "e_desc";
  static const String columnExpDesc = "e_desc";
  static const String columnExpAmt = "e_amt";
  static const String columnExpBal = "e_bal";
  static const String columnExpType = "e_type";
  static const String columnExpCatId = "e_cat_id";
  static const String columnExpCreatedAt = "e_created_at";

///User table
  static const String userTable = "user";
  static const String columnUserId = "u_id";
  static const String columnUserName = "u_name";
  static const String columnUserEmail = "u_email";
  static const String columnUserMobNo = "u_mobNo";


  ///Category table
  static final List<CatModel> allCat = [

    CatModel(id: 1,title: "Coffee", imgPath: img_coffe),
    CatModel(id: 2,title: "Coffee", imgPath: img_fast_food),
    CatModel(id: 3,title: "Coffee", imgPath: img_travel),
    CatModel(id: 4,title: "Coffee", imgPath: img_snacks),
    CatModel(id: 5,title: "Coffee", imgPath: img_shoping),
    CatModel(id: 6,title: "Coffee", imgPath: img_expense),
    CatModel(id: 7,title: "Coffee", imgPath: img_giftBox),
    CatModel(id: 8,title: "Coffee", imgPath: img_shirt),
    CatModel(id: 9,title: "Coffee", imgPath: img_hot_pot),
    CatModel(id: 10,title: "Coffee", imgPath: img_app_logo),
    CatModel(id: 11,title: "Coffee", imgPath: img_app_outlinr_logo),
    CatModel(id: 12,title: "Coffee", imgPath: img_solid_logo),
    CatModel(id: 13,title: "Coffee", imgPath: img_mekeup_pouch),
    CatModel(id: 14,title: "Coffee", imgPath: img_mobile_transfer),
    CatModel(id: 15,title: "Coffee", imgPath: img_resturant),
    CatModel(id: 16,title: "Coffee", imgPath: img_smartPhone),
    CatModel(id: 17,title: "Coffee", imgPath: img_tools),
    CatModel(id: 18,title: "Coffee", imgPath: img_vegetables),
    CatModel(id: 19,title: "Coffee", imgPath: img_vehicles),
    CatModel(id: 20,title: "Coffee", imgPath: img_watch),
  ];




}