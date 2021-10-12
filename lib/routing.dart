import 'package:flutter/material.dart';

typedef AppRouteBuilder = Widget Function(BuildContext context);

@immutable
class AppRoute {
  final String path;
  final String title;
  final AppRouteBuilder builder;

  const AppRoute({
    required this.path,
    required this.title,
    required this.builder,
  });
}
