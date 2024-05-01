import 'dart:io';
import 'package:chappie/customWidgets/custom_button.dart';
import 'package:chappie/customWidgets/custom_logo.dart';
import 'package:chappie/customWidgets/custom_textFormField.dart';
import 'package:chappie/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

    
class _RegisterScreenState extends State<RegisterScreen> {

      bool visible=true;
   TextEditingController usernameController = TextEditingController();
   TextEditingController passwordController = TextEditingController();
   TextEditingController emailController = TextEditingController();
   TextEditingController phoneController = TextEditingController();
   TextEditingController addressController = TextEditingController();
    GlobalKey<FormState> formkey = GlobalKey<FormState>();
    
    String ? password  ;
    String ? email ;
    String ? userName ;
    int ? phone;
    String ? address;
    String ? imageUrl ;
    XFile? image;

    
       
      Future<void> uploadImage() async{
      String key = UniqueKey().toString();
      await FirebaseStorage.instance.ref().child('users_image/$key').putFile(File(image!.path));
      imageUrl = await FirebaseStorage.instance.ref().child('users_image/$key').getDownloadURL();
    }

   pickimage(bool isCamera) async {
     final ImagePicker picker = ImagePicker();
     image = await picker.pickImage(source:isCamera? ImageSource.camera : ImageSource.gallery);
      if(image == null)
      {
        ScaffoldMessenger.of(context).showSnackBar(  SnackBar(
        content:const Text('Image doesn\'t picked'),
        backgroundColor: Colors.blueGrey.shade400,
    ));
      }else{
        ScaffoldMessenger.of(context).showSnackBar(  SnackBar(
        content:const Text('Image picked successfully'),
        backgroundColor: Colors.blueGrey.shade400,
    ));
      }
  }

  @override
  void dispose() {
     usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15,right: 15,bottom: 30),
          child: Form(
            key: formkey,
            child: Column(
              children: [
                const CustomLogo(),
                 const Text('Welcome!',
                           style: TextStyle(color: Colors.blueGrey,fontSize: 50,fontFamily: 'Blackadder ITC',fontWeight: FontWeight.bold),
                           ),
                           Text('Create your account',style: TextStyle(fontSize: 20,color:Colors.blueGrey.shade200),),
                      const SizedBox(height: 20,),
                       CustomTextFormField(
                        controller: usernameController,
                        validator: (value) {
                          if(value!.isEmpty)
                          {
                            return 'Username must not be empty';
                          }
                          return null;
                          
                        },
                        prefixIcon:const  Icon(Icons.person,size: 30,color: Colors.blueGrey,),
                        hintText: 'Username',
                        onSaved: (value) {
                          userName=value!;
                        },
                       ),
                       const SizedBox(height: 15,),
                        CustomTextFormField(
                        controller: emailController,
                        validator: (value) {
                          if(value!.isEmpty)
                          {
                            return 'Email must not be empty';
                          }  else if (!value.contains('@gmail.com')) {
                              return "Email must contain @gmail.com";
                            }  
                          return null;
                          
                        },
                        prefixIcon:const  Icon(Icons.email,size: 30,color: Colors.blueGrey,),
                        hintText: 'Email',
                        onSaved: (value) {
                          email=value!;
                        },
                       ),
                       const SizedBox(height: 15,),
                          CustomTextFormField(
                            obscureText: visible,
                            controller: passwordController,
                            validator: (value) {
                             if (value == null || value.isEmpty) {
                                  return 'Password can not be empty';
                                } else if (value.length < 8) {
                                  return "Password should be more than 8 character";
                                }
                              return null;
                              
                            },
                              prefixIcon: const Icon(Icons.lock,size: 30,color: Colors.blueGrey,),
                              hintText: 'Password',
                              onSaved: (value) {
                                password=value!;
                              },
                              suffixIcon:IconButton(
                                        onPressed:(){
                                          setState(() {
                                            visible =!visible;
                                          });
                                  },icon:visible ? const Icon(Icons.visibility_off,color: Colors.blueGrey,):const Icon(Icons.visibility)),
                            
                              ),
                               const SizedBox(height: 15,),
                                CustomTextFormField(
                                controller: phoneController,
                                validator: (value) {
                                  if(value!.isEmpty)
                                  {
                                    return 'Phone must not be empty';
                                  }  
                                },
                                prefixIcon:const  Icon(Icons.phone,size: 30,color: Colors.blueGrey,),
                                hintText: 'Phone',
                                onSaved: (value) {
                                  phone=int.parse(value!);
                                },
                              ),
                              const SizedBox(height: 15,),
                                CustomTextFormField(
                                controller: addressController,
                                validator: (value) {
                                  if(value!.isEmpty)
                                  {
                                    return 'address must not be empty';
                                  }  
                                },
                                prefixIcon:const  Icon(Icons.location_city,size: 30,color: Colors.blueGrey,),
                                hintText: 'Address',
                                onSaved: (value) {
                                  address=value!;
                                },
                              ),
                        const SizedBox(height: 10,),
                        MaterialButton(onPressed:(){

                           showDialog(
                            context: context,
                            builder: (_)=> AlertDialog(
                              title: const Text('Pick Image',textAlign: TextAlign.center,),
                              content: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  TextButton(onPressed: (){
                                    pickimage(true);
                                  },
                                      child: const Text('Camera'),
                                  ),
                                  const SizedBox(width: 10,),
                                  TextButton(onPressed: (){
                                    pickimage(false);
                                  },
                                    child: const Text('Gallary'),
                                  ),
                                ],
                              ),
                            ),
                        );
                        },
                        color: Colors.blueGrey,
                         child:const Text('Pick Image',style: TextStyle(color: Colors.white,fontSize: 15,),),),
                        const SizedBox(height: 15,),
                          CustomButton(
                        text: 'Register',
                        onTap: ()async{
                                      if (formkey.currentState!.validate()) {
                                          formkey.currentState!.save();
                                  try {
                                       await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      );
                                        if(image == null){
                                          ScaffoldMessenger.of(context).showSnackBar(  SnackBar(
                                              content:const Text('please pick your personal image'),
                                            backgroundColor:Colors.blueGrey.shade400));
                                           }
                                        FirebaseAuth.instance.currentUser!.sendEmailVerification();
                                         uploadImage().then((value) async {
                                           //addUser();
                                              final docUser = FirebaseFirestore.instance.collection("users").doc(email); 
                                              final user = UserModel(
                                                name: userName,
                                                phone: phone,
                                                email: email,
                                                address: address,
                                                imageUrl: imageUrl
                                              );
                                              final json = user.toJson();
                                              await docUser.set(json);
                                                });
                                        
                                        Navigator.of(context).pushReplacementNamed('login');  
                                    } on FirebaseAuthException catch (e) {
                                      if (e.code == 'weak-password') {
                                        print('The password provided is too weak.');
                                      } else if (e.code == 'email-already-in-use') {
                                        print('The account already exists for that email.');
                                      }
                                    } catch (e) {
                                      print(e);
                                    }
                                      }
                        },
                       ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}