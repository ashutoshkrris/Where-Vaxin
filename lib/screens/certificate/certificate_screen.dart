import 'package:flutter/material.dart';
import 'package:where_vaxin/screens/certificate/body.dart';
import 'package:permission_handler/permission_handler.dart';

class CertificateScreen extends StatefulWidget {
  const CertificateScreen({Key? key}) : super(key: key);
  static String routeName = '/download';

  @override
  _CertificateScreenState createState() => _CertificateScreenState();
}

class _CertificateScreenState extends State<CertificateScreen> {
  late Permission permission;

  void _listenForPermissionStatus() async {
    final status = await Permission.storage.status;

    setState(() {});
    switch (status) {
      case PermissionStatus.denied:
        requestPermission();
        break;
      case PermissionStatus.granted:
        break;
      case PermissionStatus.restricted:
        Navigator.pop(context);
        break;
      case PermissionStatus.limited:
        Navigator.pop(context);
        break;
      case PermissionStatus.permanentlyDenied:
        Navigator.pop(context);
        break;
    }
    if (status.isDenied) {}
  }

  @override
  void initState() {
    super.initState();
    _listenForPermissionStatus();
  }

  Future<void> requestPermission() async {
    final status = await Permission.storage.request();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CertificateBody();
  }
}
