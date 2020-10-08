import 'dart:math';

import 'package:flutter/material.dart';

class SliversScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: const Text('Slivers Demo')),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            // title: const Text('Sliver App Bar'),
            pinned: true,
            //floating: true,
            //snap: true,
            expandedHeight: 320.0,
            backgroundColor: Colors.grey,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Slivers Demo'),
              centerTitle: true,
              background: FlutterLogo(),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ListTile(
                  title: Text('Sliver List Item $index'),
                );
              },
              childCount: 25,
            ),
          ),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
              childAspectRatio: 2.0,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return GridTile(
                  child: Container(
                    color: index % 2 == 0 ? Colors.red : Colors.blue,
                    child: Center(
                      child: Text('Sliver Grid Item $index'),
                    ),
                  ),
                );
              },
              childCount: 10,
            ),
          )
        ],
      ),
    );
  }
}

class CustomSliverPersistentHeaderDelegate
    extends SliverPersistentHeaderDelegate {
  CustomSliverPersistentHeaderDelegate({
    @required this.child,
    @required this.maxHeight,
    @required this.minHeight,
  });

  final Widget child;
  final double maxHeight;
  final double minHeight;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(CustomSliverPersistentHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

class CustomSliverWidget extends StatefulWidget {
  CustomSliverWidget({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CustomSliverWidgetState createState() => _CustomSliverWidgetState();
}

class _CustomSliverWidgetState extends State<CustomSliverWidget> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  SliverFixedExtentList _buildList(double itemExtent, int count, String title) {
    return SliverFixedExtentList(
      itemExtent: itemExtent,
      delegate: SliverChildListDelegate(
        List.generate(
          count,
          (index) => ListTile(
            title: Text('$title Item $index'),
          ),
        ),
      ),
    );
  }

  SliverPersistentHeader _buildCustomSliverHeader(
      String title, double height, double offset) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: CustomSliverPersistentHeaderDelegate(
        minHeight: height,
        maxHeight: height,
        child: GestureDetector(
          onTap: () {
            _scrollController.animateTo(
              offset,
              duration: Duration(milliseconds: 350),
              curve: Curves.easeOut,
            );
          },
          child: Container(
            color: Colors.green,
            child: Center(
              child: Text(title),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Sliver Header Demo'),
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          _buildCustomSliverHeader('Header 1', 50.0, 0),
          _buildList(100.0, 5, 'List 1'),
          _buildCustomSliverHeader('Header 2', 50.0, 500.0),
          _buildList(100.0, 5, 'List 2'),
          _buildCustomSliverHeader('Header 3', 50.0, 1000.0),
          _buildList(100.0, 5, 'List 3'),
        ],
      ),
    );
  }
}
