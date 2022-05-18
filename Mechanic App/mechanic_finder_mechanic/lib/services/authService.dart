import 'package:firebase_auth/firebase_auth.dart';
import 'package:mechanic_finder_mechanic/services/userService.dart';

import '../models/appUser.dart';


class AuthService {

  final FirebaseAuth _auth =  FirebaseAuth.instance;

  //create user object based on User
  AppUser? _userFromUser(User? user){
    return user != null ? AppUser(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<AppUser?> get user {
    return _auth.authStateChanges()
        .map<AppUser?>((event) => _userFromUser(event!));
  }

  //Sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user =  result.user;
      return _userFromUser(user!);
    }catch(e){
      return _userFromUser(null);
    }
  }
  //Sign in with email and password
  Future signInWithEmailAndPassword(String email,String password) async{
    try{
      UserCredential credential =
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user =  credential.user;
      return _userFromUser(user!);
    }catch (e){
      return _userFromUser(null);
    }

  }

  //Register with email and password
  Future registerWithEmailAndPassword(String name, String owner, double latitude,
      double longitude, String email,String password) async{
    try{
      UserCredential credential =
              await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user =  credential.user;
      if (user != null) {
        await UserService(uid:user.uid).updateUserData(name,owner,latitude,longitude,email);
      }
      return _userFromUser(user!);
    }catch (e){
      return _userFromUser(null);
    }

  }

  //Sign out
  Future signOut() async {
    try{
      return await _auth.signOut();
    }catch(e){
      return null;
    }
  }

  final FirebaseAuth auth = FirebaseAuth.instance;

  AppUser? getCurrentUser() {
    return _userFromUser(_auth.currentUser);
  }
}