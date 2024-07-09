import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/firebase_model.dart';

class FirestoreService {
  final CollectionReference _dbCollection =
      FirebaseFirestore.instance.collection('/AI pal/Device123/Quotes');

  Stream<List<FirebaseModel>> getData() {
    return _dbCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        print("data firebase");
        print(data);
        return FirebaseModel(
          id: doc.id,
          quote: data['quote'],
          word: data['word'],
        );
      }).toList();
    });
  }

  Future<void> addData(FirebaseModel data) {
    return _dbCollection.add({
      'quote': data.quote,
      'word': data.word,
    });
  }

  Future<void> deleteData(String id) {
    return _dbCollection.doc(id).delete();
  }
}
