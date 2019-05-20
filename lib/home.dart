import 'package:flutter/material.dart';
import 'package:navbar2/navbar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
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
      bottomNavigationBar: NavBar(
        selectedIndex: selectedIndex,
        bgColor: Colors.black,
        touchCallback: (int index) {
          controller.reset();
          controller.forward();
          selectedIndex = index;
        },
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
