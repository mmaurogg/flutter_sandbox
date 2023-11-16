import 'package:flavoring_flavorizr/data/data.dart';
import 'package:flavoring_flavorizr/models/preference.dart';
import 'package:flavoring_flavorizr/pages/facebook_sdk.dart';
import 'package:flavoring_flavorizr/pages/form_page.dart';
import 'package:flavoring_flavorizr/ui/liquit_cards_pages.dart';
import 'package:flavoring_flavorizr/ui/path_pages/horizontal_path.dart';
import 'package:flavoring_flavorizr/ui/path_test.dart';
import 'package:flavoring_flavorizr/ui/pick_preferences_dialog.dart';
import 'package:flavoring_flavorizr/ui/custom_path.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;
  List<Preference>? preferencesSelected;

  Future<void> _incrementCounter() async {
    /* setState(() {
      _counter++;
    }); */

    var prefers = DataSheet()
        .data
        .map(
          (e) => e.name,
        )
        .toList();
    print(prefers);

    /*   Navigator.of(context).push(
      PickPreferencesDialog(onPressBotton: (value) {
        preferencesSelected = value;
      }),
    ).then((_) {
      print(preferencesSelected?.length);
    }); */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        //Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body:
          //FormPage()

          FacebookSdk()
      //PathHorizontal()
      //    CustomPath()
      //LiquitCards()
      //PathTest()
      /* Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ) */
      ,
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
