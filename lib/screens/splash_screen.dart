 import 'package:awesome_ripple_animation/awesome_ripple_animation.dart';
 import 'package:flutter/material.dart';
 import 'package:firebase_auth/firebase_auth.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
         children:[
            Center(
              child: InkWell(
                onTap: (){
                  (FirebaseAuth.instance.currentUser !=null && FirebaseAuth.instance.currentUser!.emailVerified) ?Navigator.pushNamed(context, 'home')
                  :Navigator.pushNamed(context, 'login');
                 },
                child: RippleAnimation(
                  size:const Size(200, 200),
                  repeat: true,
                  color: Colors.blueGrey,
                  minRadius: 90,
                  ripplesCount: 6,
                  child:const CircleAvatar(
                    radius: 300,
                    backgroundImage:AssetImage('assets/images/hi.PNG') ,
                  ),
                ),
              ),
            ),
                 const SizedBox(height: 10,),
                 const Text('Chappie',style: TextStyle(fontSize: 40,color: Colors.blueGrey,fontFamily: 'Blackadder ITC',fontWeight: FontWeight.bold),),
       ],
      )
 
    );
  }
}

// AnimatedSplashScreen(
//         splash: Column(
//           children: [
//             const Text('Welome To Chappie app',style: TextStyle(fontSize: 18),),
//             const SizedBox(height: 20,),
//             Image.asset('assets/images/hi.PNG'),
//           ],
//         ),
//         nextScreen: const LoginScreen() ,
//         splashTransition: SplashTransition.scaleTransition,
//         duration: 5000,
//       )