import 'package:flutter/material.dart';
import 'screens/home/homescreen.dart';
import 'utils/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Muli'
      ),
      initialRoute: HomeScreen.routeName,
      routes: routes,
    );
  }
}
