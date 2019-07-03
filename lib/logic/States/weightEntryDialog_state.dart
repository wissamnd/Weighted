import 'package:meta/meta.dart';
import 'package:weighted_app/model/weight_entry.dart';


@immutable
class WeightEntryDialogReduxState {
  final bool isEditMode;
  final WeightEntry activeEntry; //entry to show in detail dialog

  const WeightEntryDialogReduxState({this.isEditMode, this.activeEntry});

  WeightEntryDialogReduxState copyWith({
    bool isEditMode,
    WeightEntry activeEntry,
  }) {
    return new WeightEntryDialogReduxState(
        isEditMode: isEditMode ?? this.isEditMode,
        activeEntry: activeEntry ?? this.activeEntry);
  }
}