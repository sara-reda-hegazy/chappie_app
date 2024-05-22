import 'package:chappie/customWidgets/custom_button.dart';
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
        child: Column(
          children: [
            Row(
              children: [
                item('Hand', 'assets/images/hand.jpg'),
                const SizedBox(width: 15,),
                button("Robot Hand", () { })
              ],
            ),
            const SizedBox(height: 15,),
             Row(
              children: [
                item("Face", 'assets/images/face.jpg'),
                const SizedBox(width: 15,),
                button("Robot Face", () { })
              ],
            ),
          ],
        ),
      )
      
      /*Padding(
        padding: const EdgeInsets.only(top: 20,left: 15,right: 15),
        child: GridView(
          gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio:1.5,crossAxisSpacing: 15,mainAxisSpacing: 7),
           children: [
             item('Hand', 'assets/images/hand.jpg'),
             item("Face", 'assets/images/face.jpg'),
             
           ],
           ),
      ) ,
      */
    );
  }
}

button(String text,void Function()? onTap)
{
  return GestureDetector(
    onTap: onTap,
    child: Container(
      alignment: Alignment.center,
      height: 60,
      width: 150,
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(text,style:const TextStyle(color: Colors.white,fontSize: 15),),
    ),
  );
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
                            const SizedBox(width: 10,),
                            CircleAvatar(
                              radius: 40,
                              backgroundImage: AssetImage(image),
                            )
                          ],),
                      ), 
            );
}