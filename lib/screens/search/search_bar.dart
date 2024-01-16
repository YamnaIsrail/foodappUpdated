import 'package:flutter/material.dart';
import 'package:foodapp/config/size_config.dart';
import 'package:foodapp/screens/search/search.dart';
import 'package:foodapp/screens/home_screen/homescreen.dart';
import 'package:provider/provider.dart';

import '../../providers/product_provider.dart';
import '../../providers/user_provider.dart';
class MySearchBar extends StatelessWidget {
  final String query;
  final ValueChanged<String> onChanged;

  MySearchBar({
    required this.query,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    UserProvider userProvider = Provider.of(context);
    userProvider.getUserData();


    return  Padding(
      padding: EdgeInsets.fromLTRB(
        20,8,20,8             /// 8.0
      ),
      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => Search(search: productProvider.productsDataList,)));
          print("hello");
        },
        child: Container(
            height: 45,         /// 50.0
            width: 385,         /// 385.0
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 4),
                    blurRadius: 6,
                    color: Colors.black.withOpacity(0.3),
                  )
                ]
            ),
            child:Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Icon(Icons.search, color: Colors.black26,),
                ),
                Text("Search", style: TextStyle(color: Colors.black26, fontSize: 16))     /// 16
              ],
            )
        ),
      ),
    );  }
}
