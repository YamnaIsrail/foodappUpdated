import 'package:flutter/material.dart';
import 'package:foodapp/screens/product_overview/product_overview.dart';
import 'package:foodapp/screens/search/search.dart';
import '../../../model/product_model.dart';
import '../single_product.dart';
class RootProductComponent extends StatelessWidget {
  final List<ProductModel> rootProducts;
  final BuildContext context; // Pass context as a parameter

  RootProductComponent({required this.rootProducts, required this.context});

  @override
  Widget build(BuildContext context) {
    return _buildRootProduct(); // Call the private build method without parameters
  }

  Widget _buildRootProduct() {
    return Column(
      children: [
        const SizedBox(height: 30),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Root Product '),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Search(
                      search: rootProducts,
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
              children: rootProducts
                  .map((ProductModel? productData) {
                if (productData != null) {
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
                }
                return SizedBox(); // Return an empty widget if productData is null.
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
