import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class FadeScaleTransitionScreen extends StatefulWidget {
  const FadeScaleTransitionScreen({
    Key? key,
  }) : super(key: key);

  @override
  _FadeScaleTransitionScreenState createState() =>
      _FadeScaleTransitionScreenState();
}

class _FadeScaleTransitionScreenState extends State<FadeScaleTransitionScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      value: 0.0,
      duration: const Duration(milliseconds: 500),
      reverseDuration: const Duration(milliseconds: 500),
      vsync: this,
    )..addStatusListener((AnimationStatus status) => setState(() {}));
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
        title: const Text('Fade Scale Transition Demo'),
      ),
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                final forward = _controller.status == AnimationStatus.dismissed;
                forward ? _controller.forward() : _controller.reverse();
              },
              child: const Text('TOGGLE MODAL BUTTON'),
            ),
            AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget? child) {
                return FadeScaleTransition(
                  animation: _controller,
                  child: child,
                );
              },
              child: Opacity(
                opacity:
                    _controller.status != AnimationStatus.dismissed ? 1 : 0,
                child: ElevatedButton(
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
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('CANCEL'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
