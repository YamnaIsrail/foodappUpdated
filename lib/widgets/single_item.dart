import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodapp/config/colors.dart';
import 'package:foodapp/providers/review_cart_provider.dart';
import 'package:provider/provider.dart';

class SingleItem extends StatefulWidget {

  //SingleItem({super.key});

  SingleItem(
      {required bool this.isbool,
      required this.productPrice,
      required this.productImage,
      required this.productName,
      required this.productId,
      required this.productQuantity,
      required this.onDelete,



      });

  bool isbool= false;
  String productImage;
  String productName;
  int productPrice;
  String productId;
  int productQuantity;
  final Function() onDelete;

  @override
  State<SingleItem> createState() => _SingleItemState();
}


class _SingleItemState extends State<SingleItem> {
late ReviewCartProvider reviewCartProvider;

late int count;
getCount() {
  setState(() {
    count = widget.productQuantity;
  });
}

@override
Widget build(BuildContext context) {
  getCount();
  reviewCartProvider = Provider.of<ReviewCartProvider>(context);
  reviewCartProvider.getReviewCartData();

  return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Expanded(child: Container(
                child: Image.network(widget.productImage),
                height: 100,
              ),),
              Expanded(child: Container(
                height: 100,
                child: Column(
                  mainAxisAlignment:widget.isbool==false
                      ? MainAxisAlignment.spaceAround
                      : MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Text(widget.productName, style: TextStyle(color: Colors.black),),
                        Text("\n ${widget.productPrice}\$", style: TextStyle(color: text2Color),),
                      ],
                    ),
                    widget.isbool== false
                        ? Container(
                      margin: EdgeInsets.only(right: 15),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      height: 35,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(30)

                      ),

                          child: Row(
                        children: [
                          Expanded(child:
                          Text(
                            "50 Gram",
                            style: TextStyle(
                              color: text2Color,
                              fontSize: 14,
                            ),
                          ),
                          ),
                          Center(
                            child: Icon(
                              Icons.arrow_drop_down,
                              size: 20,
                              color: primaryColor,
                            ),
                          )
                        ],
                      ),
                    )
                        : Text('40 Gram', style: TextStyle(color: Colors.black45),),

                  ],
                ),

              ),
              ),
              Expanded(child: Container(
                height: 100,
                padding: widget.isbool==false
                    ? EdgeInsets.symmetric(horizontal: 15, vertical: 32)
                    : EdgeInsets.only(left: 15, right: 15),
                child: widget.isbool==false
                    ? Container(
                  height: 25,
                  width: 50,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(30)
                  ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add, color: buttonOutline, size: 20,),
                            Text("Add", style: TextStyle(color: buttonOutline),),
                      ],
                    ),
                  ),
                )
                    :Column(
                  children: [
                    InkWell(
                      onTap: widget.onDelete,
                      child: Icon(
                        Icons.delete,
                        size: 30,
                        color: Colors.black54,
                      ),
                    ),

                    SizedBox(height: 5,),
                    Container(
                      height: 25,
                      width: 70,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(30)
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //Icon(Icons.remove, color: primaryColor, size: 12,),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  if (count == 1) {
                                    setState(() {
                                    });

                                    Fluttertoast.showToast(
                                      msg:
                                      "You reach minimum limit",

                                    );
                                  } else if (count > 1) {
                                    count--;
                                  }
                                });
                                reviewCartProvider.updateReviewCartData(
                                  cartId: widget.productId,
                                  cartImage: widget.productImage,
                                  cartName: widget.productName,
                                  cartPrice: widget.productPrice,
                                  cartQuantity: count,
                                );
                              },
                              child: Icon(Icons.remove, size: 14, color: primaryColor),
                            ),
                            Text(widget.productQuantity.toString(), style: TextStyle(color: primaryColor, fontSize: 12),),
                          //  Icon(Icons.add, color: primaryColor, size: 12,),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  count++;
                                });
                                reviewCartProvider.updateReviewCartData(
                                  cartId: widget.productId,
                                  cartImage: widget.productImage,
                                  cartName: widget.productName,
                                  cartPrice: widget.productPrice,
                                  cartQuantity: count,
                                );
                              },
                              child: Icon(Icons.add, size: 14, color: primaryColor  ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),

              ),),

            ],
          ),
        ),
        widget.isbool==false
            ? Container()
            : Divider(height: 1,color: Colors.black45,)
      ],
    );

  }
}
