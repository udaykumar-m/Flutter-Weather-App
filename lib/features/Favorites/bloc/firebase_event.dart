part of 'firebase_bloc.dart';

@immutable
sealed class FirebaseEvent {}

class DataLoading extends FirebaseEvent {}

class AddData extends FirebaseEvent {
  final FirebaseModel data;

  AddData(this.data);
}

class UpdateData extends FirebaseEvent {
  final FirebaseModel data;

  UpdateData(this.data);
}

class DeleteData extends FirebaseEvent {
  final FirebaseModel data;

  DeleteData(this.data);
}
