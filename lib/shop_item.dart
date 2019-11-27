class ShopItem{
  String id;
  double price;
  String title;

  ShopItem.fromJson(Map<String, dynamic> json)
  :id=json["id"],
    price=json["price"],
    title=json["title"];
}