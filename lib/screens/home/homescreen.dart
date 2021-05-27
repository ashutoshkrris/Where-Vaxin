import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../data/data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String routeName = '/';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocalData.bottomNavList[_selectedTab]["appBarTitle"]),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        actions: [
          PopupMenuButton<String>(
            onSelected: (v) {
              showAlertDialog(context);
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<String>(
                value: 'item',
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  runSpacing: 20,
                  children: [
                    Icon(
                      Icons.exit_to_app,
                      color: Colors.black,
                    ),
                    Text(' Exit'),
                  ],
                ),
              )
            ],
          )
        ],
      ),
      body: LocalData.bottomNavList[_selectedTab]["screen"],
      bottomNavigationBar: createBottomNav(),
    );
  }

  Widget createBottomNav() {
    return BottomNavigationBar(
      items: LocalData.bottomNavList
          .map(
            (item) => BottomNavigationBarItem(
              icon: Icon(item["icon"]),
              label: item["title"],
            ),
          )
          .toList(),
      selectedItemColor: Colors.deepPurple,
      currentIndex: _selectedTab,
      onTap: (int tabIndex) {
        setState(() {
          _selectedTab = tabIndex;
          print(_selectedTab);
        });
      },
    );
  }

  void showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text('Do you really want to exit?'),
        actions: [
          TextButton(
            child: Text('Yes'),
            onPressed: () => SystemNavigator.pop(),
          ),
          TextButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
      barrierDismissible: false,
    );
  }
}