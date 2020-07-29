import 'package:meta/meta.dart';
import 'package:weighted_app/model/weight_entry.dart';

@immutable
class RemovedEntryState {
  final WeightEntry lastRemovedEntry;
  final bool hasEntryBeenRemoved; //in other words: should show snackbar?

  const RemovedEntryState(
      {this.lastRemovedEntry, this.hasEntryBeenRemoved = false});

  RemovedEntryState copyWith({
    WeightEntry lastRemovedEntry,
    bool hasEntryBeenRemoved,
  }) {
    return new RemovedEntryState(
        lastRemovedEntry: lastRemovedEntry ?? this.lastRemovedEntry,
        hasEntryBeenRemoved: hasEntryBeenRemoved ?? this.hasEntryBeenRemoved);
  }
}