import 'package:flutter/material.dart';
import 'package:shoe_store/account_page.dart';
import 'package:shoe_store/dao.dart';
import 'package:shoe_store/models/account_info.dart';
import 'package:shoe_store/shop_item.dart';
import 'main.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

DAO dao;
AccountInfo accountInfo; //=AccountInfo(id: 1,userName: "Tom");

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    dao = new DAO();
    loadAsset().then((x) {
      List itemJson = json.decode(x);
      var r = itemJson.map((m) => ShopItem.fromJson(m)).toList();
      setState(() {
        allItems = r;
      });
    });

    Future.delayed(Duration(seconds: 1)).then((x) {
    dao.createDatabase();
    });

    Future.delayed(Duration(seconds: 2)).then((x) {
      accountInfo = new AccountInfo(password: "daw", userName: "Cat");
    });
  }

  Future<String> loadAsset() async {
    return await rootBundle.loadString('assets/inventory.json');
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.pushNamed(context, searchPage);
            },
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, accountPage);
            },
          )
        ],
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(top: 20),
                      alignment: Alignment.centerLeft,
                      child: Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.fromLTRB(15, 0, 0, 10),
                          child: Text(
                            "The Shoe Shop",
                            style:
                                TextStyle(color: Colors.blueGrey, fontSize: 25),
                          ))),
                  _spliter("Account"),
                  _buildDrawerButton((() {
                    Navigator.pushNamed(context, accountPage);
                  }), "Account"),
                  _buildDrawerButton((() {}), "favourite"),
                  _buildDrawerButton((() {}), "Cart"),
                  _spliter("Database"),
                  _buildDrawerButton((() {
                    dao.createDatabase();
                  }), "DB Create"),
                  _buildDrawerButton((() {
                    accountInfo =
                        new AccountInfo(password: "daw", userName: "Cat");
                    dao.addNewUser(accountInfo);
                  }), "DB Add"),
                  _buildDrawerButton((() {
                    dao.getFirstUser();
                    //updateState();
                  }), "DB getFirstUser"),
                  _buildDrawerButton((() {
                    accountInfo.favourite = "a3";
                    dao.updateUser(accountInfo);
                  }), "DB AddFav"),
                ],
              ),
              _spliter("16070021"),
            ],
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: <Widget>[]..addAll(_buildItems(width - 30)),
            ),
          ),
        ),
      ),
    );
  }

  Container _spliter(String text) {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 5, 20, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(
            text,
            style: TextStyle(fontSize: 20, color: Colors.black87),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: Container(
              height: 0.5,
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                color: Colors.black45,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerButton(Function() onPressed, String text) {
    var func = () {
      onPressed();
      setState(() {});
    };
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
      height: 64,
      child: FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30),
                topRight: Radius.circular(30))),
        onPressed: func,
        child: Container(
            alignment: Alignment.centerLeft,
            child: Text(
              text,
              style: TextStyle(color: Colors.black54),
            )),
      ),
    );
  }

  List<Widget> _buildItems(double width) {
    List<Widget> r = new List<Widget>();
    if (allItems.length != 0) {
      allItems.forEach((x) {
        r.add(postWidget(context, x, width / 2));
      });
    }
    return r;
  }
}

Widget postWidget(BuildContext context, ShopItem item, double width) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, itemDetailPage, arguments: {"item": item});
    },
    child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(20),
        ),
        height: 250,
        width: width,
        child: Image(
          image: AssetImage("assets/images/${item.id}.jpg"),
          fit: BoxFit.cover,
        )),
  );
}
