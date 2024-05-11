import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class GasServices {
  final db = FirebaseDatabase.instance;
  final firebaseApp = Firebase.app();
  late final rtdb;

  GasServices() {
    rtdb = FirebaseDatabase.instanceFor(
        app: firebaseApp,
        databaseURL: 'https://iot-project-7d585-default-rtdb.firebaseio.com/');
  }

  // get all
  Future<DatabaseEvent> readAll(int nilai_asap) async {
    return await rtdb.reference().child(nilai_asap).once();
  }

  // get by id
  Future<DatabaseEvent> readById(String id, int nilai_asap) async {
    return await rtdb.reference().child(id).once();
  }

  // post
  Future<void> post(
      String id, int nilai_asap, Map<String, dynamic> data) async {
    return await rtdb.reference().child(id).child(nilai_asap).set(data);
  }
}
