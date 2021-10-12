import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImplicitAnimationScreen extends StatefulWidget {
  const ImplicitAnimationScreen({
    Key? key,
  }) : super(key: key);

  @override
  _ImplicitAnimationScreenState createState() =>
      _ImplicitAnimationScreenState();
}

class _ImplicitAnimationScreenState extends State<ImplicitAnimationScreen> {
  Alignment _alignment = Alignment.topLeft;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Implicit Animations Demo'),
      ),
      body: AnimatedAlign(
        duration: const Duration(seconds: 1),
        alignment: _alignment,
        child: const CircleAvatar(
          radius: 48.0,
          child: Text(
            '1',
            style: TextStyle(
              fontSize: 36.0,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.touch_app),
        onPressed: () {
          setState(() {
            _alignment = _alignment == Alignment.topLeft
                ? Alignment.center
                : Alignment.topLeft;
          });
        },
      ),
    );
  }
}
