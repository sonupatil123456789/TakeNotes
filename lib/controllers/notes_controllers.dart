import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:notes/repository/firebase_realtime%20_db.dart';
import 'package:notes/utils/listners_utils.dart';
import 'package:notes/utils/seassion_manager.dart';
import 'package:notes/utils/token_utils.dart';

class NotesControllers extends ChangeNotifier {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  FirebaseRealTimeDatabase firebaseRealTimeDatabase =
      FirebaseRealTimeDatabase();

  late dynamic _notesParagraphText = "";
  dynamic get notesParagraphText => _notesParagraphText;

  late dynamic _notesTitleText = "";
  dynamic get notesTitleText => _notesTitleText;

  late dynamic _downloadFileUrl = "";
  dynamic get downloadFileUrl => _downloadFileUrl;

  late dynamic _seassionData = {};
  dynamic get seassionData => _seassionData;

  bool _loading = false;
  bool get loading => _loading;

  dynamic _getNotesListFromFirebase = null;
  dynamic get getNotesListFromFirebase => _getNotesListFromFirebase;

  setloading(loading) {
    _loading = loading;
  }

  setTitle(title) {
    _notesTitleText = title;
  }

  setParagraph(para) {
    _notesParagraphText = para;
  }

  Future validateUserToken() async {
    dynamic seassion =
        await SeassionManager.getObjectFromSharedPreferences("User");
    _seassionData = await TokenUtils.validateToken(seassion['token']);
    notifyListeners();
    if (kDebugMode) {
      print("_seassionData =>> ${_seassionData}");
    }
  }

  Future uploadNotesControllerData(context, userId, notesType, data) async {
    try {
      await firebaseRealTimeDatabase.setNotes(context, userId, notesType, data);
    } catch (e) {
      ListnersUtils.showFlushbarMessage("Error during adding notes",
          Colors.redAccent, Colors.white, "LogIn failed", Icons.error, context);
    }
  }

  Future editNotesControllerData(context, userId, uid, notesType, data) async {
    try {
      await firebaseRealTimeDatabase.updateNotes(
          context, userId, uid, notesType, data);
      notifyListeners();
    } catch (e) {
      ListnersUtils.showFlushbarMessage("Error during editing notes",
          Colors.redAccent, Colors.white, "LogIn failed", Icons.error, context);
    }
  }

  Future deletNotesControllerData(context, userId, uid) async {
    try {
      await firebaseRealTimeDatabase.deletNotes(context, userId, uid);
    } catch (e) {
      ListnersUtils.showFlushbarMessage("Error during deleting notes",
          Colors.redAccent, Colors.white, "LogIn failed", Icons.error, context);
    }
  }

  Future uploadFiles(context, file, folderName, notesType, userId) async {
    setloading(true);
    try {
      Reference reference =
          _storage.ref().child("files/$folderName/${file.name}");
      dynamic uploadTask = await reference.putFile(File(file.path));
      _downloadFileUrl = await reference.getDownloadURL();

      Map<String, dynamic> data = {
        "title": file.name.toString(),
        "paragraph": _downloadFileUrl.toString()
      };

      await firebaseRealTimeDatabase.setNotes(notesType,  userId, notesType , data );
      setloading(false);
      notifyListeners();
      if (kDebugMode) {
        print("_downloadFileUrl =>> $_downloadFileUrl");
      }
    } catch (e, stack) {
      if (kDebugMode) {
        print("error  =>> $e ==> $stack");
      }
      ListnersUtils.showFlushbarMessage("Error during uploading file",
          Colors.redAccent, Colors.white, "LogIn failed", Icons.error, context);
    }
  }
}
