class ProductModel{
  String productName;
  String productImage;
  String productId;
  int productPrice;
  int productQuantity;
  //List<dynamic>productUnit;

  ProductModel(
      {
        required this.productImage,
        required this.productQuantity,
        required this.productId,
        required this.productName,
       // required this.productUnit,
        required this.productPrice});

}