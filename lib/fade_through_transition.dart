import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class FadeThroughTransitionScreen extends StatefulWidget {
  const FadeThroughTransitionScreen({
    Key? key,
  }) : super(key: key);

  @override
  _FadeThroughTransitionScreenState createState() =>
      _FadeThroughTransitionScreenState();
}

class _FadeThroughTransitionScreenState
    extends State<FadeThroughTransitionScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fade Through Transition Demo'),
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
        child: Center(
          key: Key(_currentIndex.toString()),
          child: CircleAvatar(
            radius: 48.0,
            child: Text(
              '${_currentIndex + 1}',
              style: const TextStyle(
                fontSize: 36.0,
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.open_in_new),
            label: 'Tab 1',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.last_page),
            label: 'Tab 2',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.blur_on),
            label: 'Tab 3',
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
}
