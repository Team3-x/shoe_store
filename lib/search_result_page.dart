import 'package:flutter/material.dart';
import 'package:shoe_store/main.dart';
import 'package:shoe_store/shop_item.dart';

/// Show the searched result
class SearchResultPage extends StatefulWidget {
  final String searchterm;

  SearchResultPage({this.searchterm});

  @override
  _SearchResultPageState createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Result"),
      ),
      body: Container(
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

  List<Widget> _buildItems(double width) {
    List<Widget> r = new List<Widget>();
    if (allItems.length != 0) {
      allItems.forEach((x) {
        if (x.title.contains(widget.searchterm))
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
        height: 300,
        width: width,
        child: Image(
          image: AssetImage("assets/images/${item.id}.jpg"),
          fit: BoxFit.cover,
        )),
  );
}
