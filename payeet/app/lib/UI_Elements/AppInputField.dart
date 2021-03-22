import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppInputField extends StatelessWidget {
  AppInputField({
    Key key,
    this.placeholderText,
    this.controller,
    this.obscureText = false,
    this.autocorrect = false,
    this.inputType = TextInputType.text,
    this.textInputAction,
    this.focusNode,
    this.validator,
  }) : super(key: key);

  final String placeholderText;
  final TextEditingController controller;
  final bool obscureText;
  final bool autocorrect;
  final TextInputType inputType;
  final TextInputAction textInputAction;
  final FocusNode focusNode;
  final Function(String) validator;

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 20.0,
        color: Theme.of(context).highlightColor);

    return TextFormField(
      focusNode: focusNode,
      autocorrect: false,
      controller: controller,
      style: style,
      obscureText: obscureText,
      textInputAction: textInputAction,
      keyboardType: inputType,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
            borderSide: BorderSide(color: Colors.grey, width: 1.0),
          ),
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: placeholderText,
          hintStyle: style,
          border: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Theme.of(context).highlightColor, width: 2.5),
              borderRadius: BorderRadius.circular(32.0))),
      validator: validator,
    );
  }
}
