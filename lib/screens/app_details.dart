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
        child: Column(
          children: [
            Image.asset('assets/images/info.PNG'),
            const SizedBox(height:10),
            const Text("The project involves the development of a robot designed to assist in the treatment of speech disorders in children. The robot will be controlled through a mobile application , providing a user-friendly and interactive experience for both the child and the speech therapist.",
            style: TextStyle(color: Colors.blueGrey,fontSize: 18),),
            const SizedBox(height: 5,),
           const Text("Features and Functionality :",textAlign: TextAlign.start,style: TextStyle(color: Colors.blueGrey,fontSize: 18,fontWeight: FontWeight.bold),),
           const Text("Speech Assessment-Personalized Treatment Plans-Robot Interaction-Real_time Monitoring",style: TextStyle(color: Colors.blueGrey,fontSize: 18),),
          ],
        ),
      )
    );
  }
}