import 'package:flutter/material.dart';
import 'package:flutter_material_motion/explicit_animation.dart';
import 'package:flutter_material_motion/fade_scale_transition.dart';
import 'package:flutter_material_motion/implicit_animation.dart';
import 'package:flutter_material_motion/shared_axis_transition.dart';
import 'package:flutter_material_motion/slivers.dart';
import 'container_transform.dart';
import 'fade_through_transition.dart';

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
      initialRoute: '/',
      routes: {
        '/': (context) => MainScreen(),
        ...routes.fold({}, (map, route) {
          map.putIfAbsent(route['path'], () => route['builder']);
          return map;
        }),
      },
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Material Motion Demo'),
      ),
      body: ListView(
        children: [
          for (final route in routes)
            Column(
              children: [
                ListTile(
                  title: Text(route['title']),
                  onTap: () => Navigator.pushNamed(context, route['path']),
                ),
                Divider(
                  thickness: 1.0,
                  height: 1.0,
                ),
              ],
            ),
        ],
      ),
    );
  }
}

final routes = [
  {
    'path': '/implicit-animations',
    'title': 'Implicit Animations',
    'builder': (context) => ImplicitAnimationScreen(),
  },
  {
    'path': '/explicit-animations',
    'title': 'Explicit Animations',
    'builder': (context) => ExplicitAnimationScreen(),
  },
  {
    'path': '/container-transform',
    'title': 'Container Transform',
    'builder': (context) => ContainerTransformScreen(),
  },
  {
    'path': '/shared-axis-transition',
    'title': 'Shared Axis Transition',
    'builder': (context) => SharedAxisTransitionScreen(),
  },
  {
    'path': '/fade-scale-transition',
    'title': 'Fade Scale Transition',
    'builder': (context) => FadeScaleTransitionScreen(),
  },
  {
    'path': '/fade-through-transition',
    'title': 'Fade Through Transition',
    'builder': (context) => FadeThroughTransitionScreen(),
  },
  {
    'path': '/slivers',
    'title': 'Slivers',
    'builder': (context) => SliversScreen(),
  },
];
