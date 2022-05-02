import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mechanic_finder/models/appUser.dart';

class UserService {

  final String uid;
  UserService({required this.uid});

  final CollectionReference userCollection = FirebaseFirestore.instance.collection("users");

  AppUserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return AppUserData(
        uid: uid,
        name: snapshot.get("name"),
        email: snapshot.get("email"),
    );
  }

  Future updateUserData(String name,String email) async {
    return await userCollection.doc(uid).set({
      'uid':uid,
      'name': name,
      'email': email,
    });
  }

  Stream<AppUserData> get user {
    return userCollection.doc(uid).snapshots().map((snapshot) => _userDataFromSnapshot(snapshot));
  }
}