// id INTEGER PRIMARY KEY, user_name TEXT,
// favourite_items TEXT,
// cart_items TEXT,hashed_password TEXT
class AccountInfo{
  int id;
  String userName;
  List<String> _favourite;
  List<String> _cart;
  String password;

  AccountInfo({this.id,this.userName,this.password}){
    _favourite=new List<String> ();
    _cart=new List<String> ();
    _favourite.add((""));
    _cart.add((""));
  }

  set favourite(String list){
    _favourite.clear();
    var x=list.split(" ");
    x.forEach((x){
      _favourite.add(x);
    });
  }

  List<String> getFavourite(){
    return _favourite;
  }

  addFavourite(String item){
    _favourite.add(item);
  }
  addCart(String item){
    _cart.add(item);
  }


  set cart(String list){
    _cart.clear();
    list.split(" ").forEach((x){
      _cart.add(x);
    });
  }

  List<String> getCart(){
    return _cart;
  }

  String get favouriteList{
    String result="";
    _favourite.forEach((x){
      result+="$x ";
    });
    return result;
  }

  String get cartList{
    String result="";
    _cart.forEach((x){
      result+="$x ";
    });
    return result;
  }
}