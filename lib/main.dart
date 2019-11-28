import 'package:flutter/material.dart';
import 'package:shoe_store/account_page.dart';
import 'package:shoe_store/home_page.dart';
import 'package:shoe_store/item_detail_page.dart';
import 'package:shoe_store/payment_page.dart';
import 'package:shoe_store/search_page.dart';
import 'package:shoe_store/search_result_page.dart';
import 'package:shoe_store/shop_item.dart';

void main() => runApp(MyApp());

List<ShopItem> allItems = List<ShopItem>();

// Routes
const String homePage = '/';
const String paymentPage = '/paymentPage';
const String searchPage = '/searchPage';
const String searchResultPage = '/searchResultPage';
const String accountPage = '/accountPage';
const String itemDetailPage = '/itemDetailPage';

BuildContext buildContext;
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    buildContext=context;
    return MaterialApp(
      onGenerateRoute: _routes(),
      title: 'Home',
      theme: ThemeData(
          textTheme: TextTheme(button: TextStyle(color: Colors.black54))),
    );
  }

  RouteFactory _routes() {
    return (settings) {
      final Map<String, dynamic> arg = settings.arguments;
      Widget screen;
      switch (settings.name) {
        case homePage:
          screen = HomePage();
          break;
        case paymentPage:
          screen = PaymentPage();
          break;
        case searchPage:
          screen = SearchPage();
          break;
        case itemDetailPage:
          screen = ItemDetailPage(item: arg["item"]);
          break;
        case searchResultPage:
          screen = SearchResultPage(searchterm: arg["searchTerm"],);
          break;
        case accountPage:
          screen = AccountPage();
          break;
        default:
          return null;
      }
      return MaterialPageRoute(builder: (BuildContext contex) => screen);
    };
  }
}
