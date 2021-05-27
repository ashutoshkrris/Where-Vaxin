import 'package:flutter/material.dart';
import 'package:where_vaxin/screens/home/homescreen.dart';
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
        backgroundColor: Colors.deepPurple,
        leading: GestureDetector(
          child: Icon(Icons.home),
          onTap: () => Navigator.pushReplacementNamed(context, HomeScreen.routeName),
        ),
      ),
      body: AboutBody(),
    );
  }
}
