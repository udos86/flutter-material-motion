import 'package:flutter/material.dart';

class ExplicitAnimationScreen extends StatefulWidget {
  @override
  _ExplicitAnimationScreenState createState() =>
      _ExplicitAnimationScreenState();
}

class _ExplicitAnimationScreenState extends State<ExplicitAnimationScreen>
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explicit Animations Demo'),
      ),
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget child) {
                return SizedBox(
                  width: 72.0,
                  height: 72.0,
                  child: CircularProgressIndicator(
                    valueColor: _animation,
                    value: _controller.value,
                    strokeWidth: 6.0,
                  ),
                );
              },
            ),
            RaisedButton(
              child: Text('TOGGLE ANIMATION'),
              onPressed: () {
                final forward =
                    _controller.status == AnimationStatus.dismissed ||
                        _controller.status == AnimationStatus.reverse;
                forward ? _controller.forward() : _controller.reverse();
              },
            )
          ],
        ),
      ),
    );
  }
}
