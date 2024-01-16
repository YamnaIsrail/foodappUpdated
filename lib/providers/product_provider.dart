import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:foodapp/model/product_model.dart';

class ProductProvider with ChangeNotifier {

late ProductModel productModel;

List<ProductModel> search=[];

//function of productModel
 productModels(QueryDocumentSnapshot element){
   productModel= ProductModel(
      productImage: element.get("productImage") ,
      productName: element.get("productName"),
      productPrice: element.get("productPrice"),
      productId: element.get("productId"),
      productQuantity: element.get("productQuantity"),


   );
   search.add(productModel);

 }

 List<ProductModel> _productList = [];
 List<ProductModel> _freshproductList = [];
 List<ProductModel> _rootproductList = [];


 // This method is used to fetch product data from Firebase Firestore.
 //***********************   Herbs Product *********************************************************************
 Future<void> fetchProductData() async {
  try {
   List<ProductModel> newList = [];
   final QuerySnapshot value = await FirebaseFirestore.instance.collection("HerbsProduct").get();

   // Clear the existing list before adding new data.
   _productList.clear();

   value.docs.forEach((element) {
    productModels(element);

    _productList.add(productModel);
   });

   notifyListeners(); // Notify listeners after data is updated.
  } catch (error) {
   // Handle any potential errors here, such as network issues or Firestore errors.
   print("Error fetching product data: $error");
  }
 }

 // Getter to provide access to the product list.
 List<ProductModel> get productsDataList {
  return _productList;
 }


//***********************   Fresh Product  *********************************************************************
 Future<void> fetchFreshProductData() async {
  try {
   List<ProductModel> newList = [];
   final QuerySnapshot value = await FirebaseFirestore.instance.collection("FreshProduct").get();

   // Clear the existing list before adding new data.

   _freshproductList.clear();

   value.docs.forEach((element) {
    productModels(element);


    _freshproductList.add(productModel);
   });

   notifyListeners(); // Notify listeners after data is updated.
  } catch (error) {
   // Handle any potential errors here, such as network issues or Firestore errors.
   print("Error fetching product data: $error");
  }
 }

 // Getter to provide access to the product list.
 List<ProductModel> get freshProductDataList {
  return _freshproductList;
 }

 //***********************   Fresh Product  *********************************************************************
 Future<void> fetchRootProductData() async {
  try {
   List<ProductModel> newList = [];
   final QuerySnapshot value = await FirebaseFirestore.instance.collection("RootProduct").get();

   // Clear the existing list before adding new data.
   _rootproductList.clear();

   value.docs.forEach((element) {
    productModels(element);

    // final productModel = ProductModel(
    //  productImage: element.get("productImage"),
    //  productName: element.get("productName"),
    //  productPrice: element.get("productPrice"),
    // );

    _rootproductList.add(productModel);
   });

   notifyListeners(); // Notify listeners after data is updated.
  } catch (error) {
   // Handle any potential errors here, such as network issues or Firestore errors.
   print("Error fetching product data: $error");
  }
 }

 // Getter to provide access to the product list.
 List<ProductModel> get RootDataList {
  return _rootproductList;
 }


 /////       Search Return         ////////////
   List<ProductModel> get getAllProductSearch {
    return search;
  }

}
