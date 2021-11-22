import 'package:flutter/material.dart';

class InputFieldArea extends StatelessWidget {
  final String hint;
  final bool obscure;
  final IconData icon;
  final validator;
  final onSaved;
  var initialValue;

  InputFieldArea(
      {this.hint, this.obscure, this.icon, this.validator, this.onSaved,this.initialValue});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: new TextFormField(
        validator: validator,
        onSaved: onSaved,
        initialValue: initialValue,
        obscureText: obscure,
        
        // style: const TextStyle(
        //   color: Colors.white
        // ),
        decoration: new InputDecoration(
            icon: icon != null ? Icon(
              icon,
              color: Colors.black,
            ):null,
            enabledBorder: new OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: new BorderSide(color: Colors.grey[300])),
            focusedBorder: new OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: new BorderSide(color: Colors.black)),
            errorStyle: new TextStyle(color: Colors.red),
            errorBorder: new UnderlineInputBorder(
                borderSide: new BorderSide(color: Colors.red)),
            focusedErrorBorder: new UnderlineInputBorder(
                borderSide: new BorderSide(color: Colors.red)),
            hintText: hint,
            hintStyle: const TextStyle(fontSize: 15),
            contentPadding:
                const EdgeInsets.only(top: 15, right: 10, bottom: 20, left: 5)),
      ),
    );
  }
}
