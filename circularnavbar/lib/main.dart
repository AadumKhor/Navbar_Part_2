import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as math;

void main() => runApp(Home());

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navbars',
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  int selectedIndex = 0;
  AnimationController controller;

  @override
  void initState() {
    controller = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 500));
    controller.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CircularNavbar test'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text('I am IronMan'),
      ),
      bottomNavigationBar: CircularNavbar(
        colors: [Colors.blue, Colors.green, Colors.white, Colors.black],
        icons: [Icons.home, Icons.list, Icons.ac_unit, Icons.access_alarm],
        names: ["Home", "List", "AC", "Alerts"],
        bgColor: Colors.red,
        selectedIndex: selectedIndex,
        tapCallback: (int index) {
          selectedIndex = index;
          controller.forward();
          controller.reset();
        },
      ),
    );
  }
}

class CircularNavbar extends StatefulWidget {
  final List<IconData> icons;
  final List<String> names;
  final List<Color> colors;
  final Color bgColor;
  final int selectedIndex;
  final Function tapCallback;

  CircularNavbar(
      {Key key,
      this.colors,
      this.bgColor,
      this.icons,
      this.names,
      this.selectedIndex,
      @required this.tapCallback});
  @override
  _CircularNavbarState createState() =>
      _CircularNavbarState(selectedIndex);
}

class _CircularNavbarState extends State<CircularNavbar>
    with SingleTickerProviderStateMixin {
  int selectedIndex = 0;
  int newIndex = 0;
  double _circleBottomPosition = 52.0;
  Size _size;

  Animation<double> posAnim;
  Animation<double> sinkAnim;
  Animation<double> riseAnim;
  AnimationController controller;

  _CircularNavbarState(selectedIndex);
  @override
  void initState() {
    sinkAnim = new Tween<double>(begin: 0.0, end: _circleBottomPosition)
        .animate(CurvedAnimation(
            parent: controller,
            curve: Interval(0.0, 0.15, curve: Curves.ease)));
    riseAnim = new Tween<double>(begin: _circleBottomPosition, end: 0.0)
        .animate(CurvedAnimation(
            parent: controller, curve: Interval(0.5, 1.0, curve: Curves.ease)));
    controller.addListener(() => setState(() {}));
    controller.addStatusListener((status) {
      if (controller.isCompleted) {
        selectedIndex = newIndex;
        controller.reset();
      }
    });
    posAnim = new Tween<double>(
            begin: selectedIndex * 1.0, end: (selectedIndex + 1) * 1.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.bounceIn));
    controller = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 500));
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  List<Widget> smallIcons() {
    List<Widget> icons = [];
    for (int i = 0; i < widget.icons.length; i++) {
      var a = Expanded(
        child: Container(
          child: InkResponse(
            onTap: () {
              tapped(i, true);
            },
            child: Opacity(
              opacity: getOpacityForIndex(i),
              child: Container(
                height: kBottomNavigationBarHeight * 1.6,
                width: _size.width / 5,
                child: Column(
                  children: <Widget>[
                    Icon(
                      widget.icons[i],
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      getNameOfIcon(),
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
      icons.add(a);
    }
    return icons;
  }

  double getOpacityForIndex(int index) {
    if (controller.isAnimating) {
      var dist = (index - posAnim.value).abs();
      if (dist >= 1) {
        return 1;
      } else {
        return dist;
      }
    } else {
      return selectedIndex == index ? 0 : 1;
    }
  }

  // to check and update teh interactions
  void tapped(int index, bool userInteraction) {
    if (userInteraction) {
      widget.tapCallback(index);
    }
    newIndex = index;
    posAnim = Tween<double>(begin: selectedIndex * 1.0, end: index * 1.0)
        .animate(CurvedAnimation(
      parent: controller,
      curve: Curves.ease,
    ));

    controller.forward();
  }

  //function to update the widget
  @override
  void didUpdateWidget(CircularNavbar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedIndex == widget.selectedIndex) {
      return;
    }
    tapped(widget.selectedIndex, false);
    // function to check if the button is tapped
  }

  // to ensure it is at the poistion we want
  double getCircleYPosition() {
    if (!controller.isAnimating) {
      return 0;
    }

    if (controller.value < 0.5) {
      return sinkAnim.value;
    } else {
      return riseAnim.value;
    }
  }

  // get the selected icon
  Icon getMainIcon() {
    IconData icon;
    if (controller.value < 0.5) {
      icon = widget.icons[selectedIndex];
    } else {
      icon = widget.icons[newIndex];
    }
    return Icon(
      icon,
      color: Colors.white,
    );
  }

  String getNameOfIcon() {
    String name;
    if (controller.value < 0.5) {
      name = widget.names[selectedIndex];
    } else {
      name = widget.names[newIndex];
    }
    return name;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.bgColor,
      child: Stack(
        children: <Widget>[
          Container(
            height: kBottomNavigationBarHeight * 1.5,
            width: double.infinity,
            child: Material(
              color: Colors.white,
              elevation: 4,
              child: Container(
                margin: EdgeInsets.only(top: kBottomNavigationBarHeight * 0.4),
                height: kBottomNavigationBarHeight * 1.2,
                width: _size.width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: smallIcons(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ParabolicClipper extends CustomClipper<Path> {
  final numberOfIcons; // number of icons in the navbar
  final iconHeight = 52.0; // height of icons
  final topPaddingFactor = 0.2; //space to be left from the main page

  final double animatedIndex; // index of animation

  ParabolicClipper(this.animatedIndex, this.numberOfIcons);

  @override
  Path getClip(Size size) {
    final sectionWidth = size.width / numberOfIcons;
    var path = new Path();

    path.moveTo(0.0, 0.0);
    // var controlPoint = sectionWidth/2;

    final curveControlOffset = sectionWidth * 0.45;

    final topPadding = topPaddingFactor * size.height;

    path.lineTo((animatedIndex * sectionWidth) - curveControlOffset, 0);

    final firstControlPoint = Offset((animatedIndex * sectionWidth), 0);

    final secondControlPoint =
        Offset((animatedIndex * sectionWidth), iconHeight);
    final secondEndPoint =
        Offset((animatedIndex * sectionWidth) + curveControlOffset, iconHeight);

    path.cubicTo(
        firstControlPoint.dx,
        firstControlPoint.dy,
        secondControlPoint.dx,
        secondControlPoint.dy,
        secondEndPoint.dx,
        secondEndPoint.dy);

    path = path
        .transform(Matrix4.translation(math.Vector3(0, topPadding, 0)).storage);

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return (oldClipper as ParabolicClipper).animatedIndex != animatedIndex;
  }
}
