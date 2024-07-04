
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Authentication_service {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Map? currentUser;

  Authentication_service();

  Future<bool> loginUser({ required String email, required String password} ) async {

    try {
      UserCredential _userCredentials = await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (_userCredentials.user != null) {
        currentUser = await getUserData(uid: _userCredentials.user!.uid);
        return true;
      } else {
        return false;
      }
    }catch (e) {
      print(e);
      return false;
    }


  }
  Future<Map> getUserData({required String uid}) async {
    DocumentSnapshot _doc= await _db.collection('users').doc(uid).get();
    return _doc.data() as Map;
  }

  Future<bool> registerUser({
    required String name,
    required String password,
    required String email,

  }) async {
    try{
      UserCredential _userCredential =await _auth.createUserWithEmailAndPassword(email: email, password: password);
      String _userId = _userCredential.user!.uid;
      await _db.collection("users").doc(_userId).set({
        "name": name,
        "email": email,
        "password": password,

      });
      return true;
    }catch(e){
      print(e);
      return false;
    }
  }
}