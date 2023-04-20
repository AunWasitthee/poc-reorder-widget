import 'dart:ui';

import 'package:flutter/material.dart';

class ReorderableListViewPage extends StatelessWidget {
  const ReorderableListViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ReorderableListView Sample')),
      body: const ReorderableExample(),
    );
  }
}

class ReorderableExample extends StatefulWidget {
  const ReorderableExample({Key? key}) : super(key: key);

  @override
  State<ReorderableExample> createState() => _ReorderableExampleState();
}

class _ReorderableExampleState extends State<ReorderableExample> {
  final List<List<int>> _items = List<List<int>>.generate(10, (int index) => List<int>.generate(9, (int indexIcon) => indexIcon));
  // final List<int> _itemsIcon =
  //     List<int>.generate(9, (int indexIcon) => indexIcon);
  final ScrollController _scrollController = ScrollController();
  final double _iconSize = 90;

  late List<Widget> _tiles;

  @override
  void initState() {
    _tiles = <Widget>[
      Icon(key:UniqueKey(),Icons.home, size: _iconSize),
      Icon(key:UniqueKey(),Icons.favorite, size: _iconSize),
      Icon(key:UniqueKey(),Icons.event, size: _iconSize),
      Icon(key:UniqueKey(),Icons.paid, size: _iconSize),
      Icon(key:UniqueKey(),Icons.thumb_up, size: _iconSize),
      Icon(key:UniqueKey(),Icons.room, size: _iconSize),
      Icon(key:UniqueKey(),Icons.pets, size: _iconSize),
      Icon(key:UniqueKey(),Icons.work, size: _iconSize),
      Icon(key:UniqueKey(),Icons.star, size: _iconSize),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);
    final Color draggableItemColor = colorScheme.secondary;

    Widget proxyDecorator(
        Widget child, int index, Animation<double> animation) {
      return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? child) {
          final double animValue = Curves.easeInOut.transform(animation.value);
          final double elevation = lerpDouble(0, 6, animValue)!;
          return Material(
            elevation: elevation,
            color: draggableItemColor,
            shadowColor: draggableItemColor,
            child: child,
          );
        },
        child: child,
      );
    }

    return ReorderableListView(
      header: Text('Header'),
      footer: Text('footer'),
      // buildDefaultDragHandles: false,
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 40),
      // proxyDecorator: proxyDecorator,
      children: <Widget>[
        for (int index = 0; index < _items.length; index += 1)

          index==0?  GestureDetector(
            onLongPress: () {},
            key: UniqueKey(),
            child: Column(
              key: UniqueKey(),
              children: [
                ListTile(
                  // key: UniqueKey(),
                  tileColor: evenItemColor,
                  // _items[index].isOdd ? oddItemColor : evenItemColor,
                  title: Text('Item ${_items[index]} \n  Can not Reorder'),
                  leading: ReorderableDragStartListener(
                    key: ValueKey<int>(index),
                    index: index,
                    child: const Icon(Icons.drag_handle),
                  ),
                ),
                SizedBox(
                  height: _iconSize,
                  child: ReorderableListView(
                    key: Key('$index ReorderableListView'),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    scrollController: _scrollController,
                    proxyDecorator: proxyDecorator,
                    children: <Widget>[
                      for (int indexIcon = 0; indexIcon < _items[index].length; indexIcon += 1)
                        _tiles[_items[index][indexIcon]]
                      // Icon(key: Key('$index Icon'), Icons.home, size: _iconSize),
                    ],
                    onReorder: (int oldIndex, int newIndex) {
                      setState(() {
                        if (oldIndex < newIndex) {
                          newIndex -= 1;
                        }
                        final int item = _items[index].removeAt(oldIndex);
                        _items[index].insert(newIndex, item);
                      });
                    },
                  ),
                ),
              ],
            ),
          ):
          Column(
            key: UniqueKey(),
            children: [
              ListTile(
                // key: UniqueKey(),
                tileColor: evenItemColor,
                // _items[index].isOdd ? oddItemColor : evenItemColor,
                title: Text('Item ${_items[index]} '),
                leading: ReorderableDragStartListener(
                  key: ValueKey<int>(index),
                  index: index,
                  child: const Icon(Icons.drag_handle),
                ),
              ),
              SizedBox(
                height: _iconSize,
                child: ReorderableListView(
                  key: Key('$index ReorderableListView'),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  scrollController: _scrollController,
                  proxyDecorator: proxyDecorator,
                  children: <Widget>[
                    for (int indexIcon = 0; indexIcon < _items[index].length; indexIcon += 1)
                      _tiles[_items[index][indexIcon]]
                      // Icon(key: Key('$index Icon'), Icons.home, size: _iconSize),
                  ],
                  onReorder: (int oldIndex, int newIndex) {
                    setState(() {
                      if (oldIndex < newIndex) {
                        newIndex -= 1;
                      }
                      final int item = _items[index].removeAt(oldIndex);
                      _items[index].insert(newIndex, item);
                    });
                  },
                ),
              ),
            ],
          )
      ],
      onReorder: (int oldIndex, int newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final List<int> item = _items.removeAt(oldIndex);
          _items.insert(newIndex, item);
        });
      },
    );
  }
}
