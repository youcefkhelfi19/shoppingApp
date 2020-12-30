import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pubdz_shopping/constants.dart';

class CustomInput extends StatelessWidget {
  final String hintText;
  final Function(String) onChange;
  final Function(String) onSubmitted;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final bool isObscured;
  const CustomInput({Key key,this.isObscured, this.hintText,this.textInputAction,this.focusNode,this.onSubmitted,this.onChange}) : super(key: key);
  @override
  Widget build(BuildContext context) {
       bool _isObscured=isObscured??false;
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 24,
      ),
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12)
      ),
      child: TextField(
        obscureText: _isObscured,
        focusNode: focusNode,
        onChanged: onChange,
        onSubmitted: onSubmitted,
        textInputAction: textInputAction,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText??'hintText',
         contentPadding: EdgeInsets.symmetric(horizontal: 24,vertical: 8)
        ),
        style: Constants.regularDarkText,
      ),
    );
  }
}
