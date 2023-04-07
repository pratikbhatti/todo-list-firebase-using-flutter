import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseHelper {
  FirebaseHelper._();
  static FirebaseHelper firebaseHelper = FirebaseHelper._();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  /// insert data (status code 0 is pendding task)
  Future<void> addData({
    required String task_name,
    required String status,
  }) async {
    await firebaseFirestore.collection("todo_list").add({
      "task_name": task_name,
      "status": status,
    });
  }

  /// read data
  Stream<QuerySnapshot<Map<String, dynamic>>> readData() {
    return firebaseFirestore.collection("todo_list").snapshots();
  }

  /// update status
  void updateStatus({required String id, required String status}) {
    firebaseFirestore.collection("todo_list").doc(id).update({
      "status": status,
    });
  }

  /// update data
  void updateData({required String id, required String task_name}) {
    firebaseFirestore.collection("todo_list").doc(id).update({
      "task_name": task_name,
    });
  }

  /// delete data
  void deleteData({required String id}) {
    firebaseFirestore.collection("todo_list").doc(id).delete();
  }
}
