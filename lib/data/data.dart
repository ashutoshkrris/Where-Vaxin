import 'package:flutter/material.dart';
import '../screens/certificate/body.dart';
import '../screens/home/body.dart';

class LocalData {
  static List<Map<String, dynamic>> bottomNavList = [
    {
      'screen': HomeBody(),
      'title': 'Search',
      'appBarTitle': "Where's Vaxin?",
      'icon': Icons.search
    },
    {
      'screen': CertificateBody(),
      'title': 'Certificate',
      'appBarTitle': "Download Certificate",
      'icon': Icons.download
    },
  ];
}
