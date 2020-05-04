import 'package:flutter/material.dart';
import 'package:lentera_lipuku/ui/login.dart';

void main() {
  runApp(new MaterialApp(
    title: 'Lentera Lipuku',
    home: new Login(),
    theme: ThemeData(fontFamily: 'Raleway'),
    debugShowCheckedModeBanner: false,
  ));
}
