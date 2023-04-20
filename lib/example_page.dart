import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';

class ExamplePage extends StatelessWidget {
  const ExamplePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: const Text("Example Home Page"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: ExampleHomePage());
  }
}

class ExampleHomePage extends StatefulWidget {
  const ExampleHomePage({Key? key}) : super(key: key);

  @override
  State<ExampleHomePage> createState() => _ExampleHomePageState();
}

class _ExampleHomePageState extends State<ExampleHomePage> {
  late List<Widget> _rows;

  final double _iconSize = 55;
  late List<Widget> _tiles;

  @override
  void initState() {
    super.initState();

    _tiles = <Widget>[
      Icon(Icons.home, size: _iconSize),
      Icon(Icons.favorite, size: _iconSize),
      Icon(Icons.event, size: _iconSize),
      Icon(Icons.paid, size: _iconSize),
      Icon(Icons.thumb_up, size: _iconSize),
      Icon(Icons.room, size: _iconSize),
      Icon(Icons.pets, size: _iconSize),
      Icon(Icons.work, size: _iconSize),
      Icon(Icons.star, size: _iconSize),
    ];
    var wrap = ReorderableWrap(
        spacing: 8.0,
        runSpacing: 4.0,
        padding: const EdgeInsets.all(8),
        children: _tiles,
        onReorder: _onReorderMenu,
        onNoReorder: (int index) {
          //this callback is optional
          debugPrint(
              '${DateTime.now().toString().substring(5, 22)} reorder cancelled. index:$index');
        },
        onReorderStarted: (int index) {
          //this callback is optional
          debugPrint(
              '${DateTime.now().toString().substring(5, 22)} reorder started: index:$index');
        });
    _rows =
    // [
    //   ReorderableWidget(
    //       reorderable: true,
    //       key: ValueKey(0),
    //       child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: <Widget>[
    //             Text("123456789098765432"),
    //             wrap
    //           ]))
    // ];

    List<ReorderableWidget>.generate(
        10,
            (int index) =>
            ReorderableWidget(
              reorderable: true,
              key: ValueKey(index),
              child: index == 0 || index == 5
                  ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Tes Test"),
                  wrap])
                  : Container(
                  width: double.infinity,
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('This is row $index', textScaleFactor: 1.5))),
            )

    );
  }

  void _onReorderMenu(int oldIndex, int newIndex) {
    setState(() {
      Widget row = _tiles.removeAt(oldIndex);
      _tiles.insert(newIndex, row);
    });
  }

  void _onReorderSection(int oldIndex, int newIndex) {
    setState(() {
      Widget row = _rows.removeAt(oldIndex);
      _rows.insert(newIndex, row);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: ReorderableColumn(
      header: Text('THIS IS THE HEADER ROW'),
      footer: Text('THIS IS THE FOOTER ROW'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _rows,
      onReorder: _onReorderSection,
      onNoReorder: (int index) {
        //this callback is optional
        debugPrint(
            '${DateTime.now().toString().substring(5, 22)} reorder cancelled. index:$index');
      },
    ));
  }
}
