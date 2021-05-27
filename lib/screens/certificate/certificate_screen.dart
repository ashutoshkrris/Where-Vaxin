import 'package:flutter/material.dart';
import 'package:where_vaxin/screens/certificate/body.dart';

class CertificateScreen extends StatelessWidget {
  const CertificateScreen({Key? key}) : super(key: key);
  static String routeName = '/download';

  @override
  Widget build(BuildContext context) {
    return CertificateBody();
  }
}
