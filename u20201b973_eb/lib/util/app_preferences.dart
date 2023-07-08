import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  SharedPreferences? preferences;
  bool get isPresent => preferences != null;
  String get priceKey => "productsPrice";
  String get stockKey => "productsStock";
  static final instance = AppPreferences._internal();
  AppPreferences._internal() {
    SharedPreferences.getInstance().then((value) {preferences = value;});
  }
  factory AppPreferences() => instance;

  double getProductsPrice() => isPresent ? preferences!.getDouble(priceKey) ?? 0 : 0;
  int getProductsStock() => isPresent ? preferences!.getInt(stockKey) ?? 0 : 0;

  void saveForProducts(double price, int stock) {
    var productPrice = getProductsPrice();
    var productStock = getProductsStock();
    if(isPresent) {
      preferences!.setDouble(priceKey, price + productPrice);
      preferences!.setInt(stockKey, stock + productStock);
    }
  }

  void deleteForPreferences(double price, int stock) {
    var productPrice = getProductsPrice();
    var productStock = getProductsStock();
    if(isPresent) {
      preferences!.setDouble(priceKey, productPrice - price);
      preferences!.setInt(stockKey, productStock - stock);
    }
  }
}