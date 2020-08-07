import 'package:flutter/material.dart';

class InfoActivity extends StatelessWidget {
  TextStyle titles = TextStyle(fontSize: 28.0, fontFamily: "Open Sans");

  TextStyle data = TextStyle(fontSize: 18.0, fontFamily: "Open Sans");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("About"),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10),
                Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(children: [
                      Image(
                        image: AssetImage('lib/img/newton.png'),
                        width: 128,
                        height: 128,
                      ),
                      Text("Height Calculator", style: titles),
                    ])),
                SizedBox(height: 20),
                Padding(
                    padding: EdgeInsets.all(24),
                    child: Column(children: [
                      Text(
                        '''How this app works ? Well, it's simple. It's all about high school physics ! Basically what we do is exploiting Newton's Second Law to estimate height given time (our stopwatch).\n
                The equation is the following :\n\n                 ''',
                        style: data,
                      ),
                      Image(image: AssetImage('lib/img/eq.png')),
                      SizedBox(height: 30),
                      Text(
                        "License GNU GPL v3",
                        style: data,
                      ),
                      SizedBox(height: 30),
                      Text("Made by doc_dev\nhttps://github.com/doc-dev/Height-Calculator"),
                    ]))
              ],
            ),
          ),
        ));
  }
}
