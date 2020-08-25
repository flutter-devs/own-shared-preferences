import 'package:flutter/material.dart';

Widget textButton(Function function, String label) {
  return FlatButton(
    color: Colors.pink,
    onPressed: () {
      function();
    },
    child: Text(
      label,
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
