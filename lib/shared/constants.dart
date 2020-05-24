import 'package:flutter/material.dart';

const kTextInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2.0)),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2.0)),
);

const kFloatingButtonTextStyle =
TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);

const kBoatCardImportantTextStyle =
TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);

const kBoatCardNonImportantTextStyle = TextStyle(
    fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.blueGrey);
