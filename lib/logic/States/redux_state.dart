import 'package:weighted_app/model/weight_entry.dart';

import 'mainpage_state.dart';
import 'package:meta/meta.dart';
import 'firebase_state.dart';
import 'weightEntryDialog_state.dart';
import 'removedEntry_state.dart';


@immutable
class ReduxState {
  final List<WeightEntry> entries;
  final String unit;
  final double target;
  final RemovedEntryState removedEntryState;
  final WeightEntryDialogReduxState weightEntryDialogState;
  final FirebaseState firebaseState;
  final MainPageReduxState mainPageState;
  final DateTime progressChartStartDate;
  final double weightFromNotes;

  const ReduxState({
    this.firebaseState = const FirebaseState(),
    this.entries = const [],
    this.mainPageState = const MainPageReduxState(),
    this.unit = 'kg',
    this.target,
    this.removedEntryState = const RemovedEntryState(),
    this.weightEntryDialogState = const WeightEntryDialogReduxState(),
    this.progressChartStartDate,
    this.weightFromNotes
  });
}








