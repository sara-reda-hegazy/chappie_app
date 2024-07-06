import 'package:flutter/material.dart';

class AppDetails extends StatelessWidget {
  const AppDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: AppBar(
       // automaticallyImplyLeading: false,
        backgroundColor: Colors.blueGrey,
        title:const Text('Information',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
      ),
      body:Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Center(child: Text("Welcome to Chappie!",style: TextStyle(color: Colors.blueGrey,fontSize: 20,fontWeight: FontWeight.bold),)),
              const SizedBox(height:10),
              Image.asset('assets/images/info.PNG'),
              const SizedBox(height:10),
              const Text("Hello and welcome to an exciting journey with Chappie,your friendly and intelligent robot companion. Designed with cutting-edge technology,Chappie is here to assist and inspire you every step of the way. whether it's learning new concepts,understanding and expressing emotions,or just having a fun and interactive time, Chappie is ready to be your guide.",
              style: TextStyle(color: Colors.blueGrey,fontSize: 18),),
              const SizedBox(height: 5,),
             const Text("Together, we'll explore the wonders of the world, boost your communication skills, and make every learning experience enjoyable. Chappie is not just a robot; he's a friend who understands and responds to your emotions, helping you to grow and learn in a supportive environment.",style: TextStyle(color: Colors.blueGrey,fontSize: 18,),),
             const Text("So, let's embark on this adventure together, unlocking new potentials and creating unforgettable memories. With Chappie by your side, learning has never been more fun and engaging!",style: TextStyle(color: Colors.blueGrey,fontSize: 18),),
            ],
          ),
        ),
      )
    );
  }
}