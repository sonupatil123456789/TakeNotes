


import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseCloudStoreDataBase {


    CollectionReference userAuthData =
      FirebaseFirestore.instance.collection('UserAuthData');


    Future setAuthDataToFirebase(id, data) async {
    await userAuthData.doc(id).set(data);
  }
  
}