import 'package:chappie/Provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
 

class NavBar extends StatefulWidget {
    NavBar({super.key,});
   @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {


  @override
  Widget build(BuildContext context) {
    return  FutureBuilder<DocumentSnapshot<Map<String,dynamic>>>(
      future:FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.email).get(), 
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.blueGrey,),);
          }
          else if(snapshot.data == null){
            return const Center(child: Text('No data found',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),);
          }
          else{
        Map<String, dynamic> data = snapshot.data!.data()!; 
          
          return Consumer<UiProvider>(
            builder: (context,UiProvider notifier,child) {
              return Drawer(
                    child:ListView(
                children: [
                  UserAccountsDrawerHeader(
                    accountName:  Text(data['name']), 
                    accountEmail: Text(FirebaseAuth.instance.currentUser!.email!,style:const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    currentAccountPicture:  CircleAvatar(
                    backgroundImage:NetworkImage(data['imageUrl'])
                    ),
                    decoration:const BoxDecoration(
                      color: Colors.blueGrey
                    ),
                    ),
                    ListTile(
                      leading:const Icon(Icons.person,color: Colors.blueGrey,),
                      title:const Text("Profile",style: TextStyle(color: Colors.blueGrey,fontSize: 18,fontWeight: FontWeight.bold),),
                    onTap: (){
                      Navigator.pushNamed(context, "profile");
                    },
                    ),
                     ListTile(
                      leading:const Icon(Icons.dark_mode,color: Colors.blueGrey,),
                      title:const Text("Dark theme",style: TextStyle(color: Colors.blueGrey,fontSize: 18,fontWeight: FontWeight.bold),),
                      trailing: Switch(
                        value: notifier.isDark, 
                        onChanged: (value)=>notifier.changeTheme()
                        ),
                    ),
                      ListTile(
                      leading:const Icon(Icons.settings,color: Colors.blueGrey,),
                      title:const Text("Settings",style: TextStyle(color: Colors.blueGrey,fontSize: 18,fontWeight: FontWeight.bold),),
                    onTap: (){
                      Navigator.pushNamed(context, "appDetails");
                    },
                    ),
                      ListTile(
                      leading:const Icon(Icons.reviews_outlined,color: Colors.blueGrey,),
                      title:const Text("Ratings",style: TextStyle(color: Colors.blueGrey,fontSize: 18,fontWeight: FontWeight.bold),),
                    onTap: (){
                      Navigator.pushNamed(context, "ratingApp");
                    },
                    ),
                       ListTile(
                      leading:const Icon(Icons.exit_to_app,color: Colors.blueGrey,),
                      title:const Text("Logout",style: TextStyle(color: Colors.blueGrey,fontSize: 18,fontWeight: FontWeight.bold),),
                    onTap: ()async{
                      GoogleSignIn googleSignIn = GoogleSignIn();
                      googleSignIn.disconnect();
                      await FirebaseAuth.instance.signOut();
                     Navigator.pushNamedAndRemoveUntil(context,'login', (route) => false);
                    },
                    ),
              
                ],
              )
              );
            }
          );
            
                }
                 
          }
          );
  }
  }