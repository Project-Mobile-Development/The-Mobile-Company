import 'package:flutter/material.dart';

//NOT USED ANY MORE
const kTextInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueGrey, width: 0.5),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
  ),
);

const kFloatingButtonTextStyle =
    TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);

const kBoatCardImportantTextStyle =
    TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);

const kBoatCardNonImportantTextStyle = TextStyle(
    fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.blueGrey);

const kErrorSignInTextStyle =
    TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.red);

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
