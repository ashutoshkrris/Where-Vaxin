import 'package:flutter/material.dart';
import '../screens/about/about_screen.dart';
import '../screens/certificate/certificate_screen.dart';
import '../screens/home/homescreen.dart';

// All routes here
final Map<String, WidgetBuilder> routes = {
  HomeScreen.routeName: (context) => HomeScreen(),
  CertificateScreen.routeName: (context) => CertificateScreen(),
  AboutScreen.routeName: (context) => AboutScreen(),
};
