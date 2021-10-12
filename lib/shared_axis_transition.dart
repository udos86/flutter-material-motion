import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class SharedAxisTransitionScreen extends StatefulWidget {
  const SharedAxisTransitionScreen({
    Key? key,
  }) : super(key: key);

  @override
  _SharedAxisTransitionScreenState createState() =>
      _SharedAxisTransitionScreenState();
}

class _SharedAxisTransitionScreenState
    extends State<SharedAxisTransitionScreen> {
  int _step = 0;
  bool reverse = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shared Axis Transition Demo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageTransitionSwitcher(
              duration: const Duration(milliseconds: 500),
              reverse: reverse,
              transitionBuilder: (
                Widget child,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
              ) {
                return SharedAxisTransition(
                  child: child,
                  animation: animation,
                  secondaryAnimation: secondaryAnimation,
                  transitionType: SharedAxisTransitionType.horizontal,
                );
              },
              child: StepWidget(
                key: Key(_step.toString()),
                index: _step,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    primary: colorScheme.primary,
                  ),
                  onPressed: _step > 0 ? _stepDown : null,
                  child: const Text('BACK'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: colorScheme.primary,
                    onPrimary: colorScheme.onPrimary,
                  ),
                  onPressed: _stepUp,
                  child: const Text('NEXT'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _stepUp() {
    setState(() {
      _step++;
      reverse = false;
    });
  }

  void _stepDown() {
    setState(() {
      _step--;
      reverse = true;
    });
  }
}

class StepWidget extends StatelessWidget {
  const StepWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 48.0,
          child: Text(
            '$index',
            style: const TextStyle(
              fontSize: 36.0,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16.0,
          ),
          child: Center(
            child: Text(
              'Step $index',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
