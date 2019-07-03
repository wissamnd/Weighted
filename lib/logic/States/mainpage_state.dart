import 'package:meta/meta.dart';
@immutable
class MainPageReduxState {
  final bool hasEntryBeenAdded; //in other words: should scroll to top?

  const MainPageReduxState({this.hasEntryBeenAdded = false});

  MainPageReduxState copyWith({bool hasEntryBeenAdded}) {
    return new MainPageReduxState(
        hasEntryBeenAdded: hasEntryBeenAdded ?? this.hasEntryBeenAdded);
  }
}