import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingApp extends StatefulWidget {
  const RatingApp({super.key});
  @override
  State<RatingApp> createState() => _RatingAppState();
}
class _RatingAppState extends State<RatingApp> {
  String rating="";
  double _currentRating =0.0;
 Future<void> saveRating(double _rating)async{
    if(_rating==1){rating="very_dissatisfied";setState(() {});}
                        else if(_rating==2){rating="dissatisfied";setState(() {});}
                        else if(_rating==3){rating="neutral";setState(() {});}
                        else if(_rating==4){rating="satisfied";setState(() {});}
                        else if(_rating==5){rating="very_satisfied";setState(() {});}
                        else{this.rating="";setState(() {});}
  final ratingDocRef = FirebaseFirestore.instance.collection('ratings').doc(FirebaseAuth.instance.currentUser!.email);
  await ratingDocRef.set({
    'rating':rating,
    'userId':FirebaseAuth.instance.currentUser?.uid,
  }).then((value) =>   ScaffoldMessenger.of(context).showSnackBar(  SnackBar(
                content:const Text('Thank You! .Your rating has been recorded.'),
                backgroundColor:Colors.blueGrey.shade400)))
          .catchError((error) =>   ScaffoldMessenger.of(context).showSnackBar(  SnackBar(
                content:const Text('Failed to add your rating.'),
                backgroundColor:Colors.blueGrey.shade400)));
}
        
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
       appBar: AppBar(
        title: const Text('Rating Chappie',style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.blueGrey,
      ),
      body: FutureBuilder<DocumentSnapshot<Map<String,dynamic>>>(
 future:FirebaseFirestore.instance.collection("ratings").doc(FirebaseAuth.instance.currentUser!.email).get(),   
       builder: (context, snapshot) {
         if(snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.blueGrey,),);
          }
          else if(snapshot.data == null){
            return const Center(child: Text('No data found',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),);
          }
          else{
        Map<String, dynamic> data = snapshot.data!.data()!; 
           return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                children:[
               const Text('Tap to set your rating.',style: TextStyle(fontSize: 20,color: Colors.blueGrey),),
                const SizedBox(height: 20,),
                 RatingBar.builder(
                      initialRating: _currentRating,
                      direction: Axis.horizontal,
                      itemCount: 5,
                      itemSize: 50,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                      updateOnDrag: true,
                      itemBuilder: (context, index){
                        switch (index) {
                            case 0:
                               rating="very_dissatisfied";
                              return const Icon(
                                  Icons.sentiment_very_dissatisfied,
                                  color: Colors.red,
                              );
                              
                            case 1:
                            rating="dissatisfied";
                              return const Icon(
                                  Icons.sentiment_dissatisfied,
                                  color: Colors.redAccent,
                              );
                            case 2:
                            rating="neutral";
                              return const Icon(
                                  Icons.sentiment_neutral,
                                  color: Colors.amber,
                              );
                            case 3:
                              rating="satisfied";
                              return const Icon(
                                  Icons.sentiment_satisfied,
                                  color: Colors.lightGreen,
                              );
                            case 4:
                                rating="very_satisfied";
                                return const Icon(
                                  Icons.sentiment_very_satisfied,
                                  color: Colors.green,
                                );
                            default:
                            return const Text("");
                        }
                        
                      },
                      onRatingUpdate: (rating){
                        setState((){
                          _currentRating=rating;
                        });
                        if(_currentRating==1){this.rating="very_dissatisfied";setState(() {});}
                        else if(_currentRating==2){this.rating="dissatisfied";setState(() {});}
                        else if(_currentRating==3){this.rating="neutral";setState(() {});}
                        else if(_currentRating==4){this.rating="satisfied";setState(() {});}
                        else if(_currentRating==5){this.rating="very_satisfied";setState(() {});}
                        else{this.rating="";setState(() {});}
                          
                        print(rating);
                      },
                   ),
                   const SizedBox(height: 20,),
              Text('Rating: ${data['rating']}',style:const TextStyle(fontSize: 25,color: Colors.blueGrey),),
              const SizedBox(height: 20,),
              TextButton(onPressed: ()async{
                   await saveRating(_currentRating); 
              }, 
              child:const Text("SUBMIT",style: TextStyle(color: Colors.blue,fontSize: 20),))
              ],
            ),
          );
        }
       }
      ),
    );
  }
}
