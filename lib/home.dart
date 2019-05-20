import 'package:flutter/material.dart';
import 'package:navbar2/navbar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  
  List<Color> colors = [Colors.blue ,Colors.red , Colors.orange , Colors.yellow];

  AnimationController controller;
  int selectedIndex = 0;

  @override
  void initState() {
    controller = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 500));
    controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(color: colors[selectedIndex],),
      bottomNavigationBar: NavBar(
        selectedIndex: selectedIndex,
        bgColor: colors[selectedIndex],
        touchCallback: (int index) {
          controller.reset();
          controller.forward();
          selectedIndex = index;
        },
        names: ['Home' , 'Card' , 'Lock' , 'Profile'],
        icons: [
          Icons.home,
          Icons.shopping_cart,
          Icons.lock_outline,
          Icons.person_add
        ],
      ),
    );
  }
}
