import 'package:flutter/material.dart';
import 'package:foodapp/config/colors.dart';
import 'package:foodapp/widgets/single_item.dart';

import '../../model/product_model.dart';
import '../../widgets/simple_app_bar_widget.dart';

class Search extends StatefulWidget {

  final List<ProductModel> search;

  Search({required this.search});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {

  String query = "";
  searchItem(String query) {
    List<ProductModel> searchFood = widget.search.where((element) {
      return element.productName.toLowerCase().contains(query);
    }).toList();
    return searchFood;
  }

  @override

  Widget build(BuildContext context) {
    List<ProductModel> _searchItem = searchItem(query);

    return Scaffold(
        appBar:SimpleAppBar(title: "Search",),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              ListTile(
                title: Text('Items'),
              ),
              Container(
                height: 52,
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  onChanged: (value)
                  {
                    setState((){
                      query= value;
                    });
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius:BorderRadius.circular(30),
                          borderSide: BorderSide.none
                      ),
                      fillColor: Color(0xffeae9e9),
                      filled: true,
                      hintText: "Search for item",
                      suffixIcon: Icon(Icons.search)
                  ),


                ),

              ),
              SizedBox(height: 10,),
              Column(
                children: _searchItem.map((data) {
                  return SingleItem(
                    isbool: false,
                    productPrice: data.productPrice,
                    productImage: data.productImage,
                    productName: data.productName,
                    productId: data.productId,
                    productQuantity: 4,
                    onDelete: (){},

                  );
                }).toList(),
              ),
            ],
          ),
        )
    );
  }
}