import 'package:flutter/material.dart';

class RangeOption {
  final int days;
  final String text;
  RangeOption(this.days, this.text);
}

class ProgressChartDropdown extends StatelessWidget {
  final int daysToShow;
  final Function(DateTime) onStartSelected;

  final List<RangeOption> rangeOptions = [
    RangeOption(31, "month"),
    RangeOption(91, "3 months"),
    RangeOption(182, "6 months"),
    RangeOption(365, "year"),
  ];

  ProgressChartDropdown({Key key, this.daysToShow, this.onStartSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildLabel(),
        _buildDropdown(_getSelectedOption(),context),
      ],
    );
  }

  RangeOption _getSelectedOption() {
    return rangeOptions.singleWhere(
      (option) => option.days == daysToShow,
      orElse: () => null,
    );
  }

  Container _buildDropdown(RangeOption selectedOption,BuildContext context) {

    return Container(
      padding: EdgeInsets.all(5),
      height: 30,
      decoration: new BoxDecoration(
        color: Theme.of(context).splashColor,
        borderRadius: new BorderRadius.all(Radius.circular(10.0))
      ),
      
      child: DropdownButtonHideUnderline(
        child: DropdownButton<RangeOption>(
        hint: Text("$daysToShow days"),
        value: selectedOption,
        items: rangeOptions.map(_optionToDropdownItem).toList(),
        onChanged: (option) {
          onStartSelected(
              DateTime.now().subtract(Duration(days: option.days - 1)));
        },
      ),
      ),
    );
  }

  DropdownMenuItem<RangeOption> _optionToDropdownItem(option) {
    return DropdownMenuItem<RangeOption>(
      child: Text(option.text),
      value: option,
    );
  }

  Padding _buildLabel() {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, bottom: 10.0),
      child: Text(
        "Show entries from last",
        style: TextStyle(color: Colors.grey[500]),
      ),
    );
  }
}
