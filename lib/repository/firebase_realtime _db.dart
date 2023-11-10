import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';

class FirebaseRealTimeDatabase {
  final DatabaseReference _database = FirebaseDatabase.instance.ref('Notes');
  var uuid = Uuid();

  Future creatUserInRTDB(
    context,
    userId
  ) async {
    _database.child(userId).set({
      "uid": userId,
      "UserNotes": {},
    });
  }

  Future setNotes(
    context,
    userId,
    notesType,
    data,
  ) async {
    final id = uuid.v4();
    _database.child(userId).child("UserNotes").update({
      id: {"uid": id, "notesType": notesType, "data": data}
    });
  }

  Future updateNotes(
    context,
    userId,
    uid,
    notesType,
    data,
  ) async {
    _database.child(userId).child("UserNotes").update({
      uid: {"uid": uid, "notesType": notesType, "data": data}
    });
  }

  Stream<DatabaseEvent> getNotes(context ,userId) {
    var data = _database
        .child(userId)
        .child("UserNotes")
        .onValue;
    return data;
  }

  Future deletNotes(context ,userId , uid) async {
    var data = _database
        .child(userId)
        .child("UserNotes")
        .child(uid)
        .remove();
    return data;
  }
}
