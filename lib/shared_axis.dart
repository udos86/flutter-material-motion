import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class SharedAxisWidget extends StatefulWidget {
  @override
  _SharedAxisWidgetState createState() => _SharedAxisWidgetState();
}

class _SharedAxisWidgetState extends State<SharedAxisWidget> {
  int _step = 0;
  bool reverse = false;

  @override
  Widget build(BuildContext context) {
    return Column(
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
                transitionType: SharedAxisTransitionType.scaled,
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
              FlatButton(
                onPressed: _step > 0 ? _stepDown : null,
                textColor: Theme.of(context).colorScheme.primary,
                child: const Text('BACK'),
              ),
              RaisedButton(
                onPressed: _stepUp,
                color: Theme.of(context).colorScheme.primary,
                textColor: Theme.of(context).colorScheme.onPrimary,
                child: const Text('NEXT'),
              ),
            ],
          ),
        ),
      ],
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
  StepWidget({
    Key key,
    @required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: CircleAvatar(
              radius: 48.0,
              child: Text(
                '$index',
                style: TextStyle(
                  fontSize: 36.0,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 16.0,
            ),
            child: Center(
              child: Text(
                'Step $index',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
