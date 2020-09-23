import 'package:flutter/material.dart';

class ExplicitAnimationWidget extends StatefulWidget {
  @override
  _ExplicitAnimationWidgetState createState() => _ExplicitAnimationWidgetState();
}

class _ExplicitAnimationWidgetState extends State<ExplicitAnimationWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Color> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 7),
      value: 0,
      vsync: this,
    );
    // ..addListener(() => setState(() {})); // unnecessary due to AnimatedBuilder

    _animation =
        ColorTween(begin: Colors.red, end: Colors.green).animate(_controller);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (BuildContext context, Widget child) {
              return CircularProgressIndicator(
                valueColor: _animation,
                value: _controller.value,
              );
            },
          ),
          RaisedButton(
            child: Text('TOGGLE ANIMATION'),
            onPressed: () {
              final forward = _controller.status == AnimationStatus.dismissed ||
                  _controller.status == AnimationStatus.reverse;
              forward ? _controller.forward() : _controller.reverse();
            },
          )
        ],
      ),
    );
  }
}
