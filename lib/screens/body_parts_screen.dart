import 'package:flutter/material.dart';

class BodyPartsScreen extends StatelessWidget {
  const BodyPartsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: AppBar(
        title: const Text('Body Parts',style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.blueGrey,
      ),
      body:Padding(
        padding: const EdgeInsets.only(top: 20,left: 15,right: 15),
        child: GridView(
          gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio:1.5,crossAxisSpacing: 15,mainAxisSpacing: 7),
           children: [
             item('Hand', 'assets/images/hand.jpg'),
             item("Face", 'assets/images/face.jpg'),
           ],
           ),
      ) ,
    );
  }
}

item(String text,String image)
{
  return  Container(
                  height: 150,
                       decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            offset:const Offset(0, 5),
                            color: Colors.blueGrey.withOpacity(.2),
                            spreadRadius: 2,
                            blurRadius: 10,
                          )
                        ]
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15,right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(text,style:const TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
                            CircleAvatar(
                              radius: 70,
                              backgroundImage: AssetImage(image),
                            )
                          ],),
                      ), 
            );
}