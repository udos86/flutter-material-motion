import 'dart:math';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class ContainerTransformWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 25,
      separatorBuilder: (BuildContext context, int index) => Divider(
        height: 1,
      ),
      itemBuilder: (context, index) {
        final Color color =
            Colors.primaries[Random().nextInt(Colors.primaries.length)];

        return OpenContainer(
          tappable: false,
          closedShape: const RoundedRectangleBorder(),
          closedElevation: 0.0,
          closedBuilder: (context, openContainer) {
            return ListTile(
              title: Text(_colorToString(color)),
              leading: Container(
                height: 32.0,
                width: 32.0,
                color: color,
              ),
              onTap: openContainer,
            );
          },
          openBuilder: (context, closeContainer) {
            return Scaffold(
              appBar: AppBar(
                title: Text(_colorToString(color)),
              ),
              body: SizedBox.expand(
                child: Container(
                  color: color,
                ),
              ),
            );
          },
        );
      },
    );
  }

  String _colorToString(Color color) => '0x${color.value.toRadixString(16)}';
}
