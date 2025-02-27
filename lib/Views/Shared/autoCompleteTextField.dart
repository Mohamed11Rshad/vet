import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Models/Constants.dart';

class AutoCompleteTextField extends StatelessWidget {
  final String labelText;
  final String? initialValue;
  final Function(String)? onChanged;
  final Function()? onEditeComplete;
  final bool obscureText;
  final TextEditingController? controller;
   List<String> list=[];

   AutoCompleteTextField({
    Key? key,
    required this.labelText,
    this.initialValue,
    this.onChanged,
    required this.obscureText,
    this.controller,
    this.onEditeComplete,
    required this.list
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller?.text=initialValue!;
    return EasyAutocomplete(
                    suggestions:list,
      cursorColor: appDesign.colorPrimary,
      onChanged: onChanged,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
        focusColor: appDesign.colorPrimary ,
        labelText: labelText,
        labelStyle: TextStyle(
          fontSize: 15,
          color: Colors.grey[350],
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.0),
          borderSide: BorderSide(color: appDesign.colorPrimary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.0),
          borderSide: BorderSide(color: appDesign.colorPrimary), // Set the focused border color
        ),
      ),
      controller: controller ,
    );
  }
}



class AuthTextFieldDisabled extends StatelessWidget {
  final String labelText;
  final String? initialValue;
  final Function(String)? onChanged;
  final Function()? onEditeComplete;
  final bool obscureText;
  final TextEditingController? controller;

  const AuthTextFieldDisabled({
    Key? key,
    required this.labelText,
    this.initialValue,
    this.onChanged,
    required this.obscureText,
    this.controller,
    this.onEditeComplete
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      onEditingComplete: onEditeComplete,
      cursorColor: appDesign.colorPrimary,
      onChanged: onChanged,
      obscureText: obscureText,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
        focusColor: appDesign.colorPrimary ,
        labelText: labelText,
        labelStyle: TextStyle(
          fontSize: 15,
          color: Colors.black,
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.0),
          borderSide: BorderSide(color: appDesign.colorPrimary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.0),
          borderSide: BorderSide(color: appDesign.colorPrimary), // Set the focused border color
        ),
      ),
      controller: controller ,
    );
  }
}