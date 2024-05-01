 import 'package:chappie/screens/app_details.dart';
import 'package:chappie/screens/body_parts_screen.dart';
import 'package:chappie/screens/home.dart';
import 'package:chappie/screens/letters_screen.dart';
import 'package:chappie/screens/login.dart';
import 'package:chappie/screens/numbers_screen.dart';
import 'package:chappie/screens/profile_screen.dart';
import 'package:chappie/screens/register.dart';
import 'package:chappie/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

 Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
   runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
      FirebaseAuth.instance
  .authStateChanges()
  .listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User is signed in!');
    }
  });
    return MaterialApp(
      debugShowCheckedModeBanner: false,
       theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:const SplashScreen(),
      routes:{
        'login':(context) =>const LoginScreen(),
        'register':(context) => const RegisterScreen(),
        'home':(context) => const HomeScreen(),
        "appDetails":(context) => const AppDetails(),
        "profile":(context) => const ProfilePage(),
        "bodyParts":(context) => const BodyPartsScreen(),
        "letters":(context) => const LettersScreen(),
        'numbers':(context) => const NumbersScreen(),
      },
      
    );
  }
}
 