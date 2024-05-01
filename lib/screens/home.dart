 import 'package:chappie/customWidgets/navbar.dart';
  import 'package:flutter/material.dart';
 
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key,});
    @override
  Widget build(BuildContext context) {
    return   Scaffold(
      drawer:  NavBar(),
       appBar: AppBar(
        backgroundColor:Colors.blueGrey,
         leading: Builder(
          builder: (context) {
            return  IconButton(icon:Icon(Icons.menu),color: Colors.white,
            onPressed: (){
              Scaffold.of(context).openDrawer();
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
         ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: Column(
          children: [
          const Padding(
             padding:  EdgeInsets.only(left: 25,right: 25),
             child: Text('Hello 😊, Choose what you want to learn today ?',style: TextStyle(color: Colors.blueGrey,fontSize: 25,fontWeight: FontWeight.bold),),
           ),
           item("Body Parts", 'assets/images/bodyParts.jpg',(){Navigator.pushNamed(context,'bodyParts');}),
           item("Letters", 'assets/images/letters.jpg',(){Navigator.pushNamed(context,'letters');}),
           item("Numbers", 'assets/images/numbers.jpg', () {Navigator.pushNamed(context,'numbers'); })
          ],
        ),
      ),
    );
  }
}

item(String text ,String image,void Function()? onTap)
{
  return  Padding(
            padding: const EdgeInsets.only(top: 50,left: 25,right: 25,),
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                height: 150,
                width: double.infinity,
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
                    child:  Padding(
                      padding: const EdgeInsets.only(left: 15,right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(text,style:const TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
                          CircleAvatar(
                            radius: 70,
                            backgroundImage: AssetImage(image),
                          )
                        ],),
                    )
              ),
            ),
          );
}