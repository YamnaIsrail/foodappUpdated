import 'package:flutter/material.dart';
import 'package:foodapp/config/colors.dart';

void main()=> runApp(Welcome());

class Welcome extends StatelessWidget {

  List img= [
    "food_bg.jpg",
    "background1.jpg",
    "background2.jpg"

  ];
  //const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: img.length,
            itemBuilder: (_, index){
              return Container(
                // width: double.maxFinite,
                // height: double.maxFinite,
                decoration: BoxDecoration(
                    image: DecorationImage(

                        image: AssetImage('assets/images/'+ img[index]),
                        fit: BoxFit.cover

                    )
                ),
                child: Container(
                  margin: const EdgeInsets.only(top: 150, right:20 , left:20 ),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
             // color: Colors.grey.withOpacity(0.1),
              ),
                  child: Row(

                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Food', style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.w900, fontFamily: 'VarelaRound'),),
                          Text('Flows', style: TextStyle(color: Colors.grey, fontSize: 30, fontWeight: FontWeight.bold),),
                          Container(
                            width: 250,
                            child: Text("\nFood App Landing Page. Inspirational designs, ",
                              style: TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.bold),),
                          ),
                          SizedBox(height: 10,),
                          Container(
                            height: 50,
                            width: 150,
                            child: TextButton(
                              onPressed: () {
                                // Your button click logic goes here
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: Color(0xfffce99a),
                                backgroundColor: Color(0xfffce99a)// Text color
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 28.0),
                                child: Row(
                                  children: [
                                    Text("Buy", style: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic, color: Colors.black, fontSize: 17),),
                                    SizedBox(width: 10,),
                                    Icon(Icons.format_indent_increase_sharp, color: Colors.black, size: 30,),
                                  ],
                                ),
                              ),
                            ),
                          )




                        ],
                      ),




                    ],
                  ),
                ),
              );
            }
            ),
      ),
    );
  }
}
