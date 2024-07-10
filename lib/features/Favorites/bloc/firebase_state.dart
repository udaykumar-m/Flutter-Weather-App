part of 'firebase_bloc.dart';

@immutable
sealed class FirebaseState {}

final class FirebaseInitial extends FirebaseState {}

class FirebaseLoading extends FirebaseState {}

class FirebaseLoaded extends FirebaseState {
  final List<FirebaseModel> data;

  FirebaseLoaded(this.data);
}

class FirebaseError extends FirebaseState {
  final String message;

  FirebaseError(this.message);
}

class FirebaseSuccess extends FirebaseState {
  final String message;

  FirebaseSuccess(this.message);
}

class FirebaseDeleteSuccess extends FirebaseState {
  final String message;

  FirebaseDeleteSuccess(this.message);
}
