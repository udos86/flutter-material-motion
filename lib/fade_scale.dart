import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class FadeScaleWidget extends StatefulWidget {
  @override
  _FadeScaleWidgetState createState() => _FadeScaleWidgetState();
}

class _FadeScaleWidgetState extends State<FadeScaleWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      value: 0.0,
      duration: const Duration(milliseconds: 500),
      reverseDuration: const Duration(milliseconds: 500),
      vsync: this,
    )..addStatusListener((AnimationStatus status) {
        setState(() {});
      });
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
          RaisedButton(
            onPressed: () {
              final forward = _controller.status == AnimationStatus.dismissed;
              forward ? _controller.forward() : _controller.reverse();
            },
            child: const Text('TOGGLE MODAL BUTTON'),
          ),
          AnimatedBuilder(
            animation: _controller,
            builder: (BuildContext context, Widget child) {
              return FadeScaleTransition(
                animation: _controller,
                child: child,
              );
            },
            child: Opacity(
              opacity: _controller.status != AnimationStatus.dismissed ? 1 : 0,
              child: RaisedButton(
                child: const Text('SHOW MODAL'),
                onPressed: () {
                  showModal<void>(
                    context: context,
                    builder: (BuildContext context) => _AlertDialog(),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AlertDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: const Text('Alert Dialog'),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('CANCEL'),
        ),
        FlatButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('DISCARD'),
        ),
      ],
    );
  }
}
