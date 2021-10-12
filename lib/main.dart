import 'package:flutter/material.dart';
import 'package:flutter_material_motion/explicit_animation.dart';
import 'package:flutter_material_motion/fade_scale_transition.dart';
import 'package:flutter_material_motion/implicit_animation.dart';
import 'package:flutter_material_motion/shared_axis_transition.dart';
import 'package:flutter_material_motion/slivers.dart';

import 'container_transform.dart';
import 'fade_through_transition.dart';
import 'routing.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({
    Key? key,
  }) : super(key: key);

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
        '/': (context) => const MainScreen(),
        ...routes.fold({}, (map, route) {
          map.putIfAbsent(route.path, () => route.builder);
          return map;
        }),
      },
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({
    Key? key,
  }) : super(key: key);

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
                  title: Text(route.title),
                  onTap: () => Navigator.pushNamed(context, route.path),
                ),
                const Divider(
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
  AppRoute(
    path: '/implicit-animations',
    title: 'Implicit Animations',
    builder: (context) => const ImplicitAnimationScreen(),
  ),
  AppRoute(
    path: '/explicit-animations',
    title: 'Explicit Animations',
    builder: (context) => const ExplicitAnimationScreen(),
  ),
  AppRoute(
    path: '/container-transform',
    title: 'Container Transform',
    builder: (context) => const ContainerTransformScreen(),
  ),
  AppRoute(
    path: '/shared-axis-transition',
    title: 'Shared Axis Transition',
    builder: (context) => const SharedAxisTransitionScreen(),
  ),
  AppRoute(
    path: '/fade-scale-transition',
    title: 'Fade Scale Transition',
    builder: (context) => const FadeScaleTransitionScreen(),
  ),
  AppRoute(
    path: '/fade-through-transition',
    title: 'Fade Through Transition',
    builder: (context) => const FadeThroughTransitionScreen(),
  ),
  AppRoute(
    path: '/slivers',
    title: 'Slivers',
    builder: (context) => const SliversScreen(),
  ),
];
