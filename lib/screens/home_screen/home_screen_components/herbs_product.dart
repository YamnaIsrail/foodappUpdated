import 'package:flutter/material.dart';
import 'package:foodapp/screens/product_overview/product_overview.dart';
import 'package:foodapp/screens/search/search.dart';
import '../../../model/product_model.dart';
import '../single_product.dart';

class HerbsProductComponent extends StatelessWidget {
  final List<ProductModel> products; // Change to non-nullable type

  HerbsProductComponent({required this.products, required BuildContext context});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Herbs Product '),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Search(
                      search: products, // Use the passed products list
                    ),
                  ));
                },
                child: Text('View all', style: TextStyle(color: Colors.grey)),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            child: Row(
              children: products
                  .map((ProductModel productData) {
                return singleProduct(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProductOverview(
                          productId: productData.productId,
                          productQuantity: productData.productQuantity,
                          productImage: productData.productImage,
                          productPrice: 50,
                          productName: productData.productName,
                        ),
                      ),
                    );
                  },
                  productName: productData.productName,
                  productImage: productData.productImage,
                  productPrice: productData.productPrice,
                  productId: productData.productId,
                  productdescription: 'Double cheese',
                  productQuantity: productData.productQuantity,
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
