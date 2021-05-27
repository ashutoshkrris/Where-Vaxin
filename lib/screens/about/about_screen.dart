import 'package:flutter/material.dart';
import 'body.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);
  static String routeName = '/about';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
        centerTitle: true,
        foregroundColor: Colors.deepPurple,
      ),
      body: AboutBody(),
    );
  }
}
