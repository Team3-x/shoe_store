import 'package:flutter/material.dart';
import 'package:shoe_store/home_page.dart';
import 'package:shoe_store/shop_item.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ItemDetailPage extends StatefulWidget {
  final ShopItem item;

  ItemDetailPage({@required this.item});

  @override
  _ItemDetailPageState createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SlidingUpPanel(
          maxHeight: 500,
          minHeight: 100,
          backdropEnabled: true,
          panel: Container(
            margin: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "￥ ${widget.item.price.toString()}",
                  style: TextStyle(color: Colors.red, fontSize: 40),
                ),
                Text(
                  "${widget.item.title}",
                  style: TextStyle(color: Colors.black87, fontSize: 20),
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.favorite),
                      onPressed: () {
                        accountInfo.addFavourite(widget.item.id);
                        dao.updateUser(accountInfo);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.add_shopping_cart),
                      onPressed: () {
                        accountInfo.addCart(widget.item.id);
                        dao.updateUser(accountInfo);
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
          body: Container(
            alignment: Alignment.topCenter,
            child: Image(
              image: AssetImage("assets/images/${widget.item.id}.jpg"),
            ),
          ),
        ),
      ),
    );
  }
}
