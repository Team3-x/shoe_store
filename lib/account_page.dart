import 'package:flutter/material.dart';
import 'package:shoe_store/home_page.dart';
import 'package:shoe_store/main.dart';
import 'package:shoe_store/models/account_info.dart';
import 'package:shoe_store/shop_item.dart';

Function updateState;

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  _AccountPageState() {
    updateState = _update;
  }
  _update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              _ackAlert(context);
            },
          )
        ],
        title: Text("Account"),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                  alignment: Alignment.centerLeft,
                  child: Icon(
                    Icons.person,
                    size: 200,
                  )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text(
                      accountInfo.userName,
                      style: TextStyle(fontSize: 50, color: Colors.black87),
                    ),
                    alignment: Alignment.topLeft,
                  ),
                  Container(
                    child: Text(
                        "Favourites: ${accountInfo.getFavourite().length}",
                        style: TextStyle(fontSize: 20, color: Colors.black54)),
                    alignment: Alignment.topLeft,
                  ),
                  Container(
                    child: Text("In cart: ${accountInfo.getCart().length}",
                        style: TextStyle(fontSize: 20, color: Colors.black54)),
                    alignment: Alignment.topLeft,
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Text(
                  "Favourites:",
                  style: TextStyle(fontSize: 25),
                ),
                alignment: Alignment.centerLeft,
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    children: <Widget>[]..addAll(_buildFavouriteItems()),
                  ),
                ),
              ),
              // TODO: add favourites
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Text("Cart:", style: TextStyle(fontSize: 25)),
                alignment: Alignment.centerLeft,
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    children: <Widget>[]..addAll(_buildCartItems()),
                  ),
                ),
              ),
              // TODO: add carts
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildFavouriteItems() {
    List<Widget> r = new List<Widget>();
    if (accountInfo.getFavourite().length != 0) {
      var t = accountInfo.getFavourite();
      t.forEach((x) {
        allItems.forEach((f) {
          if (f.id.contains(x)) {
            print(x);
            r.add(postWidget(context, f));
          }
        });
      });
    }
    return r;
  }

  List<Widget> _buildCartItems() {
    List<Widget> r = new List<Widget>();
    if (accountInfo.getCart().length != 0) {
      var t = accountInfo.getCart();
      t.forEach((x) {
        allItems.forEach((f) {
          if (f.id.contains(x)) {
            print(x);
            r.add(postWidget(context, f));
          }
        });
      });
    }
    return r;
  }

  Future<void> _ackAlert(BuildContext context) {
    String pass="";
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Reset Password'),
        content: TextField(
          onSubmitted: (x)=>pass=x,
          onChanged: (x)=>pass=x,
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              accountInfo.password=pass;
              dao.updateUser(accountInfo);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
}

Widget postWidget(BuildContext context, ShopItem item) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, itemDetailPage, arguments: {"item": item});
    },
    child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(20),
        ),
        height: 100,
        width: 100,
        child: Image(
          image: AssetImage("assets/images/${item.id}.jpg"),
          fit: BoxFit.cover,
        )),
  );
}
