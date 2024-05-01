
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key, this.prefixIcon, this.hintText, this.suffixIcon, this.controller, this.validator,  this.obscureText=false, this.onSaved,
  });
 
 final Widget? prefixIcon ;
 final String? hintText;
 final Widget? suffixIcon;
 final TextEditingController? controller;
 final String? Function(String?)? validator;
 final bool obscureText;
 final void Function(String?)? onSaved;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved:onSaved ,
      obscureText:obscureText ,
      controller:controller ,
      validator:validator ,
     decoration: InputDecoration(
       border: OutlineInputBorder(
         borderRadius: BorderRadius.circular(20),
       ),
       hintText: hintText,
       hintStyle: TextStyle(color: Colors.blueGrey.shade400),
       prefixIcon:prefixIcon,
       suffixIcon: suffixIcon,
     ),
    );
  }
}