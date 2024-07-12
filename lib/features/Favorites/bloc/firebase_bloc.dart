import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../model/firebase_model.dart';
import '../repo/firestore_service.dart';

part 'firebase_event.dart';
part 'firebase_state.dart';

class FirebaseBloc extends Bloc<FirebaseEvent, FirebaseState> {
  final FirestoreService _firestoreService;

  FirebaseBloc(this._firestoreService) : super(FirebaseInitial()) {
    on<DataLoading>((event, emit) async {
      try {
        emit(FirebaseLoading());
        final data = await _firestoreService.getData().first;
        emit(FirebaseLoaded(data));
      } catch (e) {
        emit(FirebaseError('Failed to load Data.'));
      }
    });

    on<AddData>((event, emit) async {
      try {
        emit(FirebaseLoading());
        await _firestoreService.addData(event.data);
        if (!emit.isDone) {
          emit(FirebaseSuccess('Data added successfully'));
        }
      } catch (e) {
        if (!emit.isDone) {
          emit(FirebaseError(e.toString()));
        }
      }
    });

    on<DeleteData>((event, emit) async {
      try {
        emit(FirebaseLoading());
        await _firestoreService.deleteData(event.data.id);
        emit(FirebaseDeleteSuccess('Data deleted successfully'));
        emit(FirebaseLoading());
        final data = await _firestoreService.getData().first;
        emit(FirebaseLoaded(data));
      } catch (e) {
        emit(FirebaseError(e.toString()));
      }
    });
  }
}
