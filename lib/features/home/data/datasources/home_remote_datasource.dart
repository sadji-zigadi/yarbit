import 'package:cloud_firestore/cloud_firestore.dart';

abstract class HomeRemoteDatasource {
  Future<List<String>> getPictures();
}

class HomeRemoteDatasourceImpl implements HomeRemoteDatasource {
  final FirebaseFirestore _firestore;

  HomeRemoteDatasourceImpl(this._firestore);

  @override
  Future<List<String>> getPictures() async {
    List<String> pictures = [];
    final res = await _firestore
        .collection('pictures')
        .get()
        .then((value) => value.docs);

    for (final data in res) {
      pictures.add(data.data()['picture url']);
    }

    return pictures;
  }
}
