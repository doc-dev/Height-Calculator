import 'dart:math';

import 'package:flutter/material.dart';
import 'package:height_calculator/infoactivity.dart';
import 'package:height_calculator/timertext.dart';

void main() {
  runApp(HeightCalculator());
}

class HeightCalculator extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Height Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Height Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Stopwatch stopwatch = new Stopwatch();
  bool stopped = false;
  TextStyle titles = TextStyle(fontSize: 24.0, fontFamily: "Open Sans");

  TextStyle data = TextStyle(fontSize: 20.0, fontFamily: "Open Sans");

  Widget buildFloatingButton(String text, VoidCallback callback, Icon ic, String tag, Color c) {
    TextStyle roundTextStyle = const TextStyle(fontSize: 16.0, color: Colors.white);
    return FloatingActionButton.extended(
      heroTag: tag,
      icon: ic,
      label: new Text(text, style: roundTextStyle),
      onPressed: callback,
      backgroundColor: c,
    );
  }

  void startButtonPressed() {
    stopped = false;
    setState(() {
      if (stopwatch.isRunning) {
        stopwatch.stop();
        stopped = true;
      } else {
        stopwatch.start();
        stopped = false;
      }
    });
  }

  void resetButtonPressed() {
    setState(() {
      if (stopped) {
        stopwatch.stop();
        stopwatch.reset();
      }
      stopped = false;
    });
  }

  double getMetres(int stopwatch) {
    double step1 = 0.0;
    step1 = (16 * (pow((stopwatch / 1000000), 2))) / 3.2808399;
    String step2 = step1.toStringAsFixed(2);

    return double.parse(step2);
  }

  double getTimeElapsed(int stopwatch) {
    double step1 = 0.0;
    step1 = stopwatch / 1000000;
    String step2 = step1.toStringAsFixed(2);
    return double.parse(step2);
  }

  void handleClick(String value) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => InfoActivity()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Height Calculator"),
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: handleClick,
              itemBuilder: (BuildContext context) {
                return {'About'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            SizedBox(height: 40),
            Text(
              "Stopwatch",
              style: titles,
            ),
            Container(
                height: 160.0,
                child: Center(
                  child: TimerText(stopwatch: stopwatch),
                )),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
              buildFloatingButton(stopwatch.isRunning ? "Stop " : "Start ", startButtonPressed,
                  Icon(Icons.timer), "First", Colors.blue),
              buildFloatingButton(
                  "Reset", resetButtonPressed, Icon(Icons.timer_off), "Second", Colors.orange)
            ]),
            SizedBox(height: 50),
            Column(
              children: [
                Text(
                  "Calculations",
                  style: titles,
                ),
                SizedBox(height: 40),
                Text(
                  "Time elapsed:             " +
                      getTimeElapsed(stopwatch.elapsedMicroseconds).toString() +
                      "  s",
                  style: data,
                ),
                SizedBox(height: 40),
                Text(
                  "Estimated Height:        " +
                      getMetres(stopwatch.elapsedMicroseconds).toString() +
                      "  m",
                  style: data,
                )
              ],
            )
          ],
        ));
  }
}
