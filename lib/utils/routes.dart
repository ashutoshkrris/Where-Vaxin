import 'package:flutter/material.dart';
import 'package:where_vaxin/screens/certificate/certificate_screen.dart';
import 'package:where_vaxin/screens/home/homescreen.dart';

// All routes here
final Map<String, WidgetBuilder> routes = {
  HomeScreen.routeName: (context) => HomeScreen(),
  CertificateScreen.routeName: (context) => CertificateScreen(),
};
