import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:floating_search_bar/floating_search_bar.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shoe_store/shop_item.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ShopItem> items = List<ShopItem>();
  List<ShopItem> allItems = List<ShopItem>();
  Stream<List<String>> search;
  List<String> searchResult = new List<String>();
  final _onTextChanged = PublishSubject<String>();

  @override
  void initState() {
    super.initState();
    loadAsset().then((x) {
      List itemJson = json.decode(x);
      var r = itemJson.map((m) => ShopItem.fromJson(m)).toList();
      setState(() {
        allItems=r;
      });
    });

    var sub = _onTextChanged
        .distinct()
        .throttleTime(Duration(milliseconds: 500))
        .where((x) => x != "")
        .switchMap<List<String>>((mapper) => _search(mapper));

    var nullSub = _onTextChanged
        .distinct()
        .throttleTime(Duration(milliseconds: 500))
        .where((x) => x == "")
        .listen((x) {
      setState(() {
        searchResult.clear();
      });
    });

    search = sub;
    search.listen((x) {
      setState(() {
        searchResult = x;
      });
    });
  }

  Future<String> loadAsset() async {
    return await rootBundle.loadString('assets/inventory.json');
  }

  Stream<List<String>> _search(String term) async* {
    List<String> r = new List<String>();
    allItems.forEach((f) {
      if (f.title.contains(term)) {
        r.add(f.title);
      }
    });
    yield r;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: FloatingSearchBar.builder(
        itemCount: searchResult.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Text(searchResult[index]),
            onTap: () {},
          );
        },
        trailing: CircleAvatar(
          child: Text("RD"),
        ),
        // drawer: Drawer(
        //   child: Container(),
        // ),
        onChanged: _onTextChanged.add,
        onTap: () {},
        decoration: InputDecoration.collapsed(
          hintText: "Search...",
        ),

        body: Container(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Wrap(
                children: <Widget>[]..addAll(_buildItems(width-20)),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildItems(double width) {
    List<Widget> r = new List<Widget>();
    if (allItems.length != 0) {
      allItems.forEach((x) {
        r.add(postWidget(x, width/2));
      });
    }
    print("Length:${r.length}");
    return r;
  }
}

Widget postWidget(ShopItem item, double width) {
  return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(20),
      ),
      height: 300,
      width: 200,
      child: Image(
        image: AssetImage("assets/images/${item.id}.jpg"),
        fit: BoxFit.cover,
      ));
}
