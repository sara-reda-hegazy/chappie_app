import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
 
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title:const Text("My Profile",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
      ),
      body: FutureBuilder<DocumentSnapshot<Map<String,dynamic>>>(
        future: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.email).get(),
        builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(),);
          }
            if(snapshot.data == null){
            return const Center(child: Text('No data found',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),);
          }else {
            Map<String,dynamic> data = snapshot.data!.data()!; 
            return Padding(
          padding:const  EdgeInsets.only(top: 20),
          child:  Column(
            children: [
               CircleAvatar(
                radius: 71,
                backgroundColor:Colors.blueGrey,
                child: CircleAvatar(
                  radius: 70,
                   backgroundImage: NetworkImage(data['imageUrl']),
                ),
              ),
 
                const SizedBox(height: 20,),
              itemProfile("Name",data['name'],Icons.person),
              const SizedBox(height: 10,),
               itemProfile("Phone",data['phone'].toString(),Icons.phone),
               const SizedBox(height: 10,),
               itemProfile("Address",data['address'],Icons.location_city),
               const SizedBox(height: 10,),
               itemProfile("Email",data['email'],Icons.email),
               const SizedBox(height: 10,),
            ],
          ),   
        );
          }
        },
      ),
    );
  }
}

         
            
itemProfile(String title,String subtitle ,IconData iconData){
  return   Padding(
              padding: const EdgeInsets.only(left: 16,right: 16),
              child:Container(
                decoration: BoxDecoration(
                  color: Colors.white,
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
                child:  ListTile(
                  title: Text(title,style:const TextStyle(color: Colors.blueGrey,fontSize: 18,fontWeight: FontWeight.bold),),
                  subtitle: Text(subtitle,style:const TextStyle(color: Colors.blueGrey,fontSize: 18,)),
                  leading: Icon(iconData,color:Colors.blueGrey,),
                ),
              ),
              );
}

