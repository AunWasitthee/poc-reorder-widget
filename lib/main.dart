import 'package:flutter/material.dart';
import 'package:poc_reorder_widget/example_page.dart';
import 'package:poc_reorder_widget/reordeable_ex/reorderables_demo_page.dart';
import 'package:poc_reorder_widget/reorderablelistvie_page.dart';

void main() {
  runApp(const PoCApp());
}

class PoCApp extends StatelessWidget {
  const PoCApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PoC Drag Widget',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: HomePage()

    );
  }
}

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ReorderablesDemoPage()),
                );
              },
              child: const Text(
                'Reorderables Demo',
                style: TextStyle(fontSize: 20),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ExamplePage()),
                );
              },
              child: const Text(
                'Example Page',
                style: TextStyle(fontSize: 20),
              ),
            ),
            ElevatedButton(
              onPressed: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ReorderableListViewPage()),
                );


                // Navigator.of(context).pushNamed('/preview');
              },
              child: const Text(
                'ReorderableListView',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
