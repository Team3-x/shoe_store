import 'dart:io';
import 'package:shoe_store/home_page.dart';
import 'package:shoe_store/models/account_info.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

/// Database access object
class DAO {
  String dbPath;
  Database database;

  DAO() {
    getTemporaryDirectory().then((x) {
      dbPath = x.path;
    });
  }

  /// Create db when db is not exist
  createDatabase() async {
    var path = dbPath + "/db.db";

    // Make sure the directory exists
    try {
      await Directory(dbPath).create(recursive: true);

      database = await openDatabase(path, version: 2,
          onCreate: (Database db, int version) async {
        // When creating the db, create the table
        await db.execute(
            'CREATE TABLE User (id INTEGER PRIMARY KEY, user_name TEXT UNIQUE, favourite_items TEXT, cart_items TEXT,hashed_password TEXT)');
      });
    } catch (_) {}
  }

  addNewUser(AccountInfo accountInfo) async {
    await database.transaction((txn) async {
      int id1 = await txn.rawInsert(
          'INSERT INTO User(user_name, hashed_password, favourite_items, cart_items) VALUES("${accountInfo.userName}", "${accountInfo.password}", "${accountInfo.favouriteList}", "${accountInfo.cartList}")');
      print('inserted1: $id1');
    });
  }

  /// Add to favourite
  updateUser(AccountInfo accountInfo) async {
    int count = await database.rawUpdate(
      'UPDATE User SET favourite_items = "${accountInfo.favouriteList}",cart_items="${accountInfo.cartList}",hashed_password="${accountInfo.password}" WHERE id = ${accountInfo.id}',
    );
  }

  getFirstUser() async {
    List<Map> res;
    await database.rawQuery('SELECT * FROM User').then((x) {
      res = x;
    });
    accountInfo =
        new AccountInfo(id: res.first['id'], userName: res.first["user_name"],password: res.first["hashed_password"]);
    accountInfo.favourite=(res.first['favourite_items'] as String).trim();
    accountInfo.cart=(res.first['cart_items'] as String).trim();

    print("${accountInfo.id}${accountInfo.favouriteList}${accountInfo.cartList}${accountInfo.password}");
  }
}
