import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:openai_app/features/local_storage.dart';
import '../model/firebase_model.dart';

class FirestoreService {
  // final collectionName = PreferenceHelper.getString('deviceId');
  late CollectionReference _dbCollection;

  FirestoreService() {
    final collectionName = PreferenceHelper.getString('deviceId');
    _dbCollection =
        FirebaseFirestore.instance.collection('/AI pal/$collectionName/Quotes');
  }

  Stream<List<FirebaseModel>> getData() {
    return _dbCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return FirebaseModel(
          id: doc.id,
          text: data['text'],
          word: data['word'],
        );
      }).toList();
    });
  }

  Future<void> addData(FirebaseModel data) {
    return _dbCollection.add({
      'text': data.text,
      'word': data.word,
    });
  }

  Future<void> deleteData(String id) {
    return _dbCollection.doc(id).delete();
  }

  dynamic generateDocumentId() {
    return _dbCollection.doc();
  }
}
