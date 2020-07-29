import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help"),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
        children: <Widget>[
          Center(
              child: Text(
            "Measure Your Weight Accurately",
            style: Theme.of(context).textTheme.headline4,
          )),
          Padding(
            padding: EdgeInsets.all(20),
          ),
          SizedBox(
              width: 60,
              height: 60,
              child: Image.asset('assets/consumerReports.png')),
          Padding(
            padding: EdgeInsets.all(20),
          ),
          Text(
              "Follow these steps to get an accurate daily weigh-in, which will help you make smart choices about what to eat and how much to exercise."),
          Padding(
            padding: EdgeInsets.all(10),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.check_circle),
              ),
              Expanded(
                  child: Text(
                      "Use your scale every morning (the best time to weigh yourself) after you empty your bladder, wearing as little clothing as possible.")),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(10),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.check_circle),
              ),
              Expanded(
                  child: Text(
                      "Place your scale on a hard, even surface—no carpeting. A wobbly or tilted scale can result in an inaccurate reading.")),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(10),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.check_circle),
              ),
              Expanded(
                  child: Text(
                      "Stand still, with your weight distributed evenly on both feet.")),
            ],
          ),
        ],
      ),
    );
  }
}
