import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/appUser.dart';

class UserService {

  final String uid;
  UserService({required this.uid});

  final CollectionReference userCollection = FirebaseFirestore.instance.collection("mechanics");

  AppUserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return AppUserData(
      uid,
      snapshot.get("name"),
      snapshot.get("owner"),
      snapshot.get("email"),
      snapshot.get("latitude"),
      snapshot.get("longitude"),
    );
  }

  Future updateUserData(String name, String owner, double latitude,
      double longitude, String email) async {
    return await userCollection.doc(uid).set({
      'uid':uid,
      'name': name,
      'owner': owner,
      'latitude':latitude,
      'longitude':longitude,
      'email': email,
    });
  }

  Stream<AppUserData> get user {
    return userCollection.doc(uid).snapshots().map((snapshot) => _userDataFromSnapshot(snapshot));
  }
}