import 'package:flutter/material.dart';
import 'package:lab2/model/user.dart';
import 'package:lab2/view/tabpage1.dart';
import 'package:lab2/view/tabpage2.dart';
import 'package:lab2/view/tabpage3.dart';

class MainPage extends StatefulWidget {
  final User user;
  const MainPage({Key? key, required this.user}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late List<Widget> tabchildren;
  int _currentIndex = 2;
  String maintitle = "Profile";

  @override
  void initState() {
    super.initState();
    tabchildren = [
      TabPage1(),
      TabPage2(),
      TabPage3(user: widget.user),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Qy Tutor'),
      ),
      body: tabchildren[_currentIndex], //mention!!!!!
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.school
                ,
              ),
              label: "Tutor"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: "Profile")
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      if (_currentIndex == 0) {
        maintitle = "Home";
      }
      if (_currentIndex == 1) {
        maintitle = "Tutor";
      }
      if (_currentIndex == 2) {
        maintitle = "Profile";
      }
    });
  }
}
