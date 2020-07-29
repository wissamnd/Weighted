import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:meta/meta.dart';
import '../logic/actions.dart';
import '../logic/States/redux_state.dart';
import 'settings_page.dart';
import 'package:numberpicker/numberpicker.dart';
import '../logic/constants.dart';

@immutable
class ProfilePageViewModel {
  final Function(String) onUnitChanged;
  final Function(double) onTargetChanged;
  final String unit;
  final double target;
  final double currentWeight;

  ProfilePageViewModel({this.unit,this.target,this.onUnitChanged,this.onTargetChanged,this.currentWeight});
}
class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  
    return new StoreConnector<ReduxState, ProfilePageViewModel>(
        converter: (store) {
      return new ProfilePageViewModel(
        currentWeight: store.state.entries.isEmpty ? 0.0 : store.state.entries.first.weight,
        target: store.state.target,
        unit:  store.state.unit,
        onUnitChanged: (newUnit) => store.dispatch(new SetUnitAction(newUnit)),
        onTargetChanged: (newTarget) => store.dispatch(new SetTargetAction(newTarget)),
      );
    }, builder: (context, viewModel) {
      
      return new Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SettingsPage(),
                new Padding(padding: EdgeInsets.all(20)),
                new ListTile(
                    leading: new Image.asset(
                      "assets/scale-bathroom.png",
                      color: Colors.grey[500],
                      height: 24.0,
                      width: 24.0,
                    ),
                    title: (viewModel.target == null)?Text("Not set"):new Text(viewModel.target.toString() +" "+ viewModel.unit),
                    subtitle: (viewModel.target == null)?Text("Set your goal"):Text("Edit your goal"),
                    onTap: () => _showWeightPicker(context, viewModel),
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }
   _showWeightPicker(BuildContext context, ProfilePageViewModel viewModel) {
    showDialog<double>(
      context: context,
      builder: (context) =>
      new NumberPickerDialog.decimal(
      
        minValue: viewModel.unit == "kg"
            ? MIN_KG_VALUE
            : (MIN_KG_VALUE * KG_LBS_RATIO).toInt(),
        maxValue: viewModel.unit == "kg"
            ? MAX_KG_VALUE
            : (MAX_KG_VALUE* KG_LBS_RATIO).toInt(),
        initialDoubleValue: (viewModel.currentWeight < MIN_KG_VALUE)?MIN_KG_VALUE.toDouble():viewModel.currentWeight,
        title: new Text("Enter your goal"),
      ),
    ).then((double value) {
      if (value != null) {
        if (viewModel.unit == "lbs") {
          value = value / KG_LBS_RATIO;
        }
        viewModel.onTargetChanged(value);
      }
    });
  }
}
