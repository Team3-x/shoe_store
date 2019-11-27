import 'package:flutter/material.dart';
import 'package:shoe_store/home_page.dart';
import 'package:shoe_store/payment_page.dart';

void main() => runApp(MyApp());

// Routes
const String homePage = '/';
const String paymentPage = '/paymentPage';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        onGenerateRoute: _routes(), title: 'Home');
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
        default:
          return null;
      }
      return MaterialPageRoute(builder: (BuildContext contex) => screen);
    };
  }
}
