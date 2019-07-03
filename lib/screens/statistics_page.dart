import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../logic/actions.dart';
import '../logic/constants.dart';
import '../logic/States/redux_state.dart';
import '../model/weight_entry.dart';
import '../screens/weight_entry_dialog.dart';


import 'graph_page.dart';
class _StatisticsPageViewModel {
  final double totalProgress;
  final double currentWeight;
  final double last7daysProgress;
  final double last30daysProgress;
  final List<WeightEntry> entries;
  final String unit;
  final double target;
  final Function() openAddEntryDialog;

  _StatisticsPageViewModel({
    this.last7daysProgress,
    this.last30daysProgress,
    this.totalProgress,
    this.currentWeight,
    this.entries,
    this.unit,
    this.target,
    this.openAddEntryDialog,
  });
}

class StatisticsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:new StoreConnector<ReduxState, _StatisticsPageViewModel>(
        converter: (store) {
          String unit = store.state.unit;
          double target = store.state.target;
          List<WeightEntry> entries = new List();
          store.state.entries.forEach((entry) {
            if (unit == "kg") {
              entries.add(entry);
            } else {
              entries.add(entry.copyWith(weight: entry.weight * KG_LBS_RATIO));
            }
          });
          List<WeightEntry> last7daysEntries = entries
              .where((entry) =>
              entry.dateTime
                  .isAfter(new DateTime.now().subtract(new Duration(days: 7))))
              .toList();
          List<WeightEntry> last30daysEntries = entries
              .where((entry) =>
              entry.dateTime
                  .isAfter(new DateTime.now().subtract(new Duration(days: 30))))
              .toList();
          List<WeightEntry> entriesRecordedSixHoursAgo = entries
              .where((entry) =>
              entry.dateTime
                  .isAfter(new DateTime.now().subtract(new Duration(hours: 6))))
              .toList();
          return new _StatisticsPageViewModel(
            totalProgress: entries.isEmpty
                ? 0.0
                : (entries.first.weight - entries.last.weight),
            currentWeight: entries.isEmpty ? 0.0 : entries.first.weight,
            last7daysProgress: last7daysEntries.isEmpty
                ? 0.0
                : (last7daysEntries.first.weight - last7daysEntries.last.weight),
            last30daysProgress: last30daysEntries.isEmpty
                ? 0.0
                : (last30daysEntries.first.weight -
                last30daysEntries.last.weight),
            entries: entries,
            unit: unit,
            target: target,
            openAddEntryDialog: () {
                if(entriesRecordedSixHoursAgo.isEmpty){
                  store.dispatch(new OpenAddEntryDialog());
                  Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) {
                    return new WeightEntryDialog();
                  },
                  fullscreenDialog: true,
                ));
                }
            },
          );
        },
        builder: (context, viewModel) {
          return new ListView(

            padding: EdgeInsets.all(15),
            children: <Widget>[
              new Padding(padding: EdgeInsets.all(30)),
              new InkWell(
                onTap: ()=>{
                  viewModel.openAddEntryDialog()
                },
                child:  new _StatisticCard(
                  title: "Current weight",
                  value: viewModel.currentWeight,
                  unit: viewModel.unit,
                ),
              ),
              InkWell(
                onTap: ()=>{
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>GraphPage()),
                    )
                },
                child: new _StatisticCard(
                  title: "Progress done",
                  value: viewModel.totalProgress,
                  processNumberSymbol: true,
                  unit: viewModel.unit,
                ),
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new Expanded(
                    child: new _StatisticCard(
                      title: "Last week",
                      value: viewModel.last7daysProgress,
                      textSizeFactor: 0.8,
                      processNumberSymbol: true,
                      unit: viewModel.unit,
                    ),
                  ),
                  new Expanded(
                    child: new _StatisticCard(
                      title: "Last month",
                      value: viewModel.last30daysProgress,
                      textSizeFactor: 0.8,
                      processNumberSymbol: true,
                      unit: viewModel.unit,
                    ),
                  ),
                ],
              ),
              (!(viewModel.target == 0.0) && !(viewModel.currentWeight == 0.0)&&!(viewModel.target == null))?
              Tooltip(
                message: viewModel.target.toString() +" "+viewModel.unit.toString() ,
                child: Card(
                elevation: 10.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                                children: [
                                  Text(
                                      (((100)/viewModel.currentWeight) * viewModel.target).round().toString(),
                                      style: Theme.of(context).textTheme.display2.apply(
                                        color: ((((100)/viewModel.currentWeight) * viewModel.target).round()== 100)?Colors.green:Theme.of(context).accentColor
                                        ),
                                  ),
                                  new Padding(
                                      padding: new EdgeInsets.only(left: 5.0),
                                      child: new Text("%")),
                                ],
                                mainAxisAlignment: MainAxisAlignment.start,
                              ),
                            AnimatedContainer(
                            width: ((MediaQuery.of(context).size.width * 1 )/viewModel.currentWeight) * viewModel.target,
                            height: 20,
                            decoration: new BoxDecoration(
                              color: ((((100)/viewModel.currentWeight) * viewModel.target).round()== 100)?Colors.green:Theme.of(context).accentColor,
                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),topRight: Radius.circular(10))
                            ),
                            
                            duration: new Duration(seconds: 5),
                          ),
                          
                          new Padding(
                                child: new Text("Progress toward goal"),
                                padding: new EdgeInsets.all(10.0),
                            ),
                        ],
                        ),
                ),
              ),
              ):Container()
            ],
          );
        },
      ) ,
    );
  }
}

class _StatisticCardWrapper extends StatelessWidget {
  final double height;
  final Widget child;

  _StatisticCardWrapper({this.height = 120.0, this.child});

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: [
        new Expanded(
          child: new Container(
            height: height,
            child: new Card(
              elevation: 10.0,
              child: child),
          ),
        ),
      ],
    );
  }
}

class _StatisticCard extends StatelessWidget {
  final String title;
  final num value;
  final bool processNumberSymbol;
  final double textSizeFactor;
  final String unit;

  _StatisticCard({this.title,
    this.value,
    this.unit,
    this.processNumberSymbol = false,
    this.textSizeFactor = 1.0});

  @override
  Widget build(BuildContext context) {
    Color numberColor =
        (processNumberSymbol && value > 0) ? Colors.red : Theme.of(context).accentColor;
    String numberSymbol = processNumberSymbol && value > 0 ? "+" : "";
    return new _StatisticCardWrapper(
      child: new Column(
        children: <Widget>[
          new Expanded(
            child: new Row(
              children: [
                new Text(
                  numberSymbol + value.toStringAsFixed(1),
                  textScaleFactor: textSizeFactor,
                  style: Theme
                      .of(context)
                      .textTheme
                      .display2
                      .copyWith(color: numberColor),
                ),
                new Padding(
                    padding: new EdgeInsets.only(left: 5.0),
                    child: new Text(unit)),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ),
          new Padding(
            child: new Text(title),
            padding: new EdgeInsets.only(bottom: 8.0),
          ),
        ],
      ),
    );
  }
}
