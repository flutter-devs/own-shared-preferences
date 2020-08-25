import 'package:flutter/material.dart';

Widget customField({Function(String) getData, String hintText}) {
  return TextField(
    onChanged: (value) => getData(value),
    cursorColor: Colors.white,
    style: TextStyle(color: Colors.white, fontSize: 30),
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.white54, fontSize: 30),
      filled: true,
      fillColor: Colors.pinkAccent,
    ),
  );
}
