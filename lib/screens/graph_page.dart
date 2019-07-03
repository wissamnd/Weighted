import 'package:flutter/material.dart';
import '../widgets/progress_chart.dart';
class GraphPage extends StatefulWidget {
  @override
  _GraphPageState createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Progress Chart"),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 40),
      children: <Widget>[
         new _StatisticCardWrapper(
                child: new Padding(
                    padding: new EdgeInsets.all(8.0),
                    child: new ProgressChart()),
                height: 400.0,
              ),
      ],        

      ),
      );
  }
}
class _StatisticCardWrapper extends StatelessWidget {
  final double height;
  final Widget child;

  _StatisticCardWrapper({this.height = 400, this.child});

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: [
        new Expanded(
          child: new Container(
            height: this.height,
            child: child,
          ),
        ),
      ],
    );
  }
}