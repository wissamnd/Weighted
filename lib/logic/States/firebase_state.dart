import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:meta/meta.dart';
@immutable
class FirebaseState {
  final FirebaseUser firebaseUser;
  final DatabaseReference mainReference;

  const FirebaseState({this.firebaseUser, this.mainReference});

  FirebaseState copyWith({
    FirebaseUser firebaseUser,
    DatabaseReference mainReference,
  }) {
    return new FirebaseState(
        firebaseUser: firebaseUser ?? this.firebaseUser,
        mainReference: mainReference ?? this.mainReference);
  }
}