import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_motion/fade_scale.dart';
import 'package:flutter_material_motion/shared_axis.dart';

import 'container_transform.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Material Motion Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(title: 'Flutter Material Motion Demo Page'),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: PageTransitionSwitcher(
        transitionBuilder: (
          Widget child,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) {
          return FadeThroughTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
        child: _getBody(_currentIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.open_in_new),
            title: Text('Container'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.last_page),
            title: Text('Shared Axis'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.blur_on),
            title: Text('Fade Scale'),
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  Widget _getBody(int index) {
    switch (index) {
      case 0:
        return ContainerTransformWidget();
      case 1:
        return SharedAxisWidget();
      case 2:
        return FadeScaleWidget();
      default:
        throw Exception('Invalid index');
    }
  }
}
