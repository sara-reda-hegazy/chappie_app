
import 'package:flutter/material.dart';

class CustomLogo extends StatelessWidget {
  const CustomLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
             child: Padding(
               padding: const EdgeInsets.only(top: 70),
               child: CircleAvatar(
                 radius: 71,
                 backgroundColor: Colors.blueGrey,
                 child: CircleAvatar(
                   backgroundColor: Colors.white,
                   radius:70 ,
                   child: Image.asset('assets/images/logo.PNG',scale:2.4 ,)
                   ),
               ),
             ),
           );
  }
}