import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../about/about_screen.dart';
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
        automaticallyImplyLeading: true,
        backgroundColor: Colors.deepPurple,
        actions: [
          PopupMenuButton<String>(
            onSelected: (v) {
              if (v == 'exit')
                showAlertDialog(context);
              else if (v == 'about')
                Navigator.pushReplacementNamed(context, AboutScreen.routeName);
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<String>(
                value: 'about',
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  runSpacing: 20,
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Colors.black,
                    ),
                    Text(' About'),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'exit',
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
