import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:meta/meta.dart';
import '../logic/actions.dart';
import '../logic/States/redux_state.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

@immutable
class SettingsPageViewModel {
  final FirebaseUser user;
  final String unit;
  final double target;
  final Function(String) onUnitChanged;
  final Function(double) onTargetChanged;
  final Function() logout;

  SettingsPageViewModel(
      {@required this.user,
      this.unit,
      this.target,
      this.onUnitChanged,
      this.onTargetChanged,
      @required this.logout});
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<ReduxState, SettingsPageViewModel>(
        converter: (store) {
      return new SettingsPageViewModel(
        user: store.state.firebaseState.firebaseUser,
        unit: store.state.unit,
        target: store.state.target,
        onUnitChanged: (newUnit) => store.dispatch(new SetUnitAction(newUnit)),
        onTargetChanged: (newTarget) =>
            store.dispatch(new SetTargetAction(newTarget)),
        logout: () {
          store.dispatch(LogoutAction());
        },
      );
    }, builder: (context, viewModel) {
      // viewModel.onTargetChanged(2.0);
      return Column(
        children: <Widget>[
          new Padding(padding: EdgeInsets.all(20)),
          _unitView(context, viewModel),
          new Padding(padding: EdgeInsets.all(20)),
          _themeView(context),
        ],
      );
    });
  }

  ListTile _unitView(BuildContext context, SettingsPageViewModel viewModel) {
    return ListTile(
      leading: Icon(Icons.edit),
      title: Text("Unit"),
      trailing: DropdownButtonHideUnderline(
        child: new DropdownButton<String>(
          key: const Key('UnitDropdown'),
          value: (viewModel.unit == "kg") ? "Kilograms" : "Pounds",
          items: <String>["Kilograms", "Pounds"].map((String value) {
            return new DropdownMenuItem<String>(
              value: value,
              child: new Text(value, style: Theme.of(context).textTheme.body1),
            );
          }).toList(),
          onChanged: (newUnit) => {
            if (newUnit == "Kilograms")
              {viewModel.onUnitChanged("kg")}
            else
              {viewModel.onUnitChanged("lb")}
          },
        ),
      ),
    );
  }

  ListTile _themeView(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.format_paint),
      title: Text("Theme"),
      trailing: DropdownButtonHideUnderline(
        child: new DropdownButton<String>(
          key: const Key('UnitDropdown'),
          value: (Theme.of(context).brightness == Brightness.light)
              ? "Light"
              : "Dark",
          items: <String>["Light", "Dark"].map((String value) {
            return new DropdownMenuItem<String>(
              value: value,
              child: new Text(value, style: Theme.of(context).textTheme.body1),
            );
          }).toList(),
          onChanged: (newTheme) => {
            if (newTheme == "Light")
              {DynamicTheme.of(context).setBrightness(Brightness.light)}
            else
              {DynamicTheme.of(context).setBrightness(Brightness.dark)}
          },
        ),
      ),
    );
  }
}
