import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chappie/customWidgets/custom_button.dart';
import 'package:chappie/customWidgets/custom_logo.dart';
import 'package:chappie/customWidgets/custom_textFormField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
   
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey();

  bool visible =true;
 
   @override
  void dispose() {
     email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return    Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15,right: 15),
          child: Form(
            key: formkey,
            child: Column(
              children: [
                const CustomLogo(),
                  const Text('Welcome back!',
                           style: TextStyle(color: Colors.blueGrey,fontSize: 50,fontFamily: 'Blackadder ITC',fontWeight: FontWeight.bold),
                           ),
                             Text('Login to your account',style: TextStyle(fontSize: 20,color:Colors.blueGrey.shade200),),
                      const SizedBox(height: 20,),
                      CustomTextFormField(
                        controller: email,
                        hintText: 'Email',
                        prefixIcon:const Icon(Icons.email,color: Colors.blueGrey,),
                        validator: (value){
                            if(value!.isEmpty)
                            {
                              return 'Email must not be empty';
                            } else if (!value.contains('@gmail.com')) {
                                return "Email must contain @gmail.com";
                              } 
                            return null;
                        },
                      ),
                       const SizedBox(height: 15,),
                        CustomTextFormField(
                          obscureText: visible,
                          controller: password,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                                return 'Password can not be empty';
                              } else if (value.length < 8) {
                                return "Password should be less than 8 character";
                              }
                            return null;
                            
                          },
                            prefixIcon: const Icon(Icons.lock,size: 30,color: Colors.blueGrey,),
                            hintText: 'Password',
                            suffixIcon:IconButton(
                                      onPressed:(){
                                        setState(() {
                                          visible =!visible;
                                        });
                                },icon:visible ? const Icon(Icons.visibility_off,color: Colors.blueGrey,):const Icon(Icons.visibility)),
                          
                            ),
                            const SizedBox(height: 15,),
                            InkWell(
                              onTap: () async {
                                if(email.text =="")
                                {
                                   AwesomeDialog(
                                                 context: context,
                                                dialogType: DialogType.error,
                                                animType: AnimType.rightSlide,
                                                title: 'Error',
                                                desc: 'Please write your email then click on forget password',
                                                ).show();
                                }
                               try{
                                  await FirebaseAuth.instance
                                 .sendPasswordResetEmail(email:email.text);
                                  AwesomeDialog(
                                                 context: context,
                                                dialogType: DialogType.success,
                                                animType: AnimType.rightSlide,
                                                title: 'Success',
                                                desc: 'A link has been sent to your email to reset your password',
                                                ).show();

                               }catch(e)
                               {
                                 if(email.text !="")
                                 {
                                   AwesomeDialog(
                                                 context: context,
                                                dialogType: DialogType.error,
                                                animType: AnimType.rightSlide,
                                                title: 'Error',
                                                desc: 'Please make sure that the email you entered is correct and try again',
                                                ).show();
                                 }
                               }
                              },
                              child: Container(
                                alignment: Alignment.bottomRight,
                                child:const Text('Forget Password ?',style: TextStyle(color: Colors.blueGrey,fontSize: 18),),
                              ),
                            ),
                             const SizedBox(height: 20,),
                             CustomButton(
                            text: 'Login',
                            onTap: ()async{
                                if (formkey.currentState!.validate()) {
                                    formkey.currentState!.save();
                              try {
                                    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                                      email: email.text,
                                      password: password.text
                                    );
             
                                    if(credential.user!.emailVerified){
                                     Navigator.pushReplacementNamed(context, 'home');
                                    }
                                    else
                                    {
                                        AwesomeDialog(
                                                 context: context,
                                                dialogType: DialogType.error,
                                                animType: AnimType.rightSlide,
                                                title: 'Error',
                                                desc: 'Please go to your email and click on the email verification link to activate your account',
                                                ).show();
                                    }
                                  } on FirebaseAuthException catch (e) {
                                    if (e.code == 'user-not-found') {
                                      print('No user found for that email.');
                
                                         AwesomeDialog(
                                                 context: context,
                                                dialogType: DialogType.error,
                                                animType: AnimType.rightSlide,
                                                title: 'Error',
                                                desc: 'No user found for that email.',
                                                ).show();
                
                                      
                                    } else if (e.code == 'wrong-password') {
                                      print('Wrong password provided for that user.');
                
                                       AwesomeDialog(
                                      width: 100,
                                                context: context,
                                                dialogType: DialogType.error,
                                                animType: AnimType.rightSlide,
                                                title: 'Error',
                                                desc: 'Wrong password provided for that user.',
                                                ).show();
                                    }
                                  }
                                }
                            },
                            
                           ),
                       
                        const SizedBox(height: 10,),
                         Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                           const Text('Don\'t have an account?',style: TextStyle(color: Colors.blueGrey,fontSize: 18),),
                            GestureDetector(
                              onTap: (){
                                Navigator.pushNamed(context,'register');
                              },
                              child:const Text(' Register',style: TextStyle(color: Colors.blueGrey,fontSize: 18,fontWeight: FontWeight.bold),)),
              ],
            ),
              ],
          ),
          ),
        
        ),
      ) ,
    );
  }
}
