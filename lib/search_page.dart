import 'package:flutter/material.dart';
import 'package:floating_search_bar/floating_search_bar.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shoe_store/shop_item.dart';
import 'main.dart';

List<ShopItem> searchItems = new List<ShopItem>();

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String> searchResult = new List<String>();
  final _onTextChanged = PublishSubject<String>();

  String searchTerm="";

  @override
  void initState() {
    super.initState();

    var sub = _onTextChanged
        .distinct()
        .throttleTime(Duration(milliseconds: 500))
        .where((x) => x != "")
        .switchMap<List<String>>((mapper) => _search(mapper));

        _onTextChanged
        .distinct()
        .throttleTime(Duration(milliseconds: 500))
        .where((x) => x != "")
        .listen((x){
          searchTerm=x;
        });

    _onTextChanged
        .distinct()
        .throttleTime(Duration(milliseconds: 500))
        .where((x) => x == "")
        .listen((x) {
      setState(() {
        searchResult.clear();
      });
    });

    sub.listen((x) {
      setState(() {
        searchResult = x;
      });
    });
  }

  Stream<List<String>> _search(String term) async* {
    List<String> r = new List<String>();
    searchItems.clear();
    allItems.forEach((f) {
      if (f.title.contains(term)) {
        setState(() {
          r.add(f.title);
          searchItems.add(f);
        });
      }
    });
    yield r;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FloatingSearchBar.builder(
        itemCount: searchResult.length,
        itemBuilder: (BuildContext context, int index) {
          var text = searchResult[index];
          return ListTile(
            leading: Text(text),
            onTap: () {
              Navigator.pushNamed(context, searchResultPage,
                  arguments: {"searchTerm": text});
            },
          );
        },
        onChanged: _onTextChanged.add,
        onTap: () {},
        trailing: IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            Navigator.pushNamed(context, searchResultPage,
                arguments: {"searchTerm": searchTerm});
          },
        ),
        decoration: InputDecoration.collapsed(
          hintText: "Search...",
        ),
      ),
    );
  }
}
