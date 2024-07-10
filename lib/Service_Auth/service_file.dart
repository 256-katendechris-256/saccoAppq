
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


  Future<bool> add_Sacco({
    required String sacco_name,
    required String saccor_id,
    required String saccO_manageer_name,
    required String location_district,
    required num last_number,
    required num registration_number,
    required String registration_date,
}) async{
    try{
      String userId = _auth.currentUser!.uid;
     await  _db.collection("sacco").doc(saccor_id).set({
        "user_id": userId,
        "sacco_name": sacco_name,
        "saccor_id": saccor_id,
        "saccO_manageer_name": saccO_manageer_name,
        "location_district": location_district,
        "last_number": last_number,
        "registration_number": registration_number,
        "registration_date": registration_date,
      });
      return true;
    }catch(e){
      print(e);
      return false;
    }
  }


  Future<bool> addMember({
    required String saccoId,
    required String memberName,
    required String memberId,
    required String memberPhone,
    required String memberEmail,
    required String gender,
    required num current_savings,
    required num share_percentage,
    required num current_share_amount,
    required num net_worth,
    required String nin,
    required String village,
    required String parish,
    required String business,
    required num passbook_number,
  }) async {
    try {
      await _db.collection("sacco").doc(saccoId).collection("members").doc(memberId).set({
        "member_name": memberName,
        "member_id": memberId,
        "member_phone": memberPhone,
        "member_email": memberEmail,
        "gender" : gender,
        "current_savings": current_savings,
        "share_percentage": share_percentage,
        "current_share_amount": current_share_amount,
        "net_worth": net_worth,
        "nin": nin,
        "village": village,
        "parish": parish,
        "business": business,
        "passbook_number": passbook_number,


      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> take_Survey({
    required String respondent_id,
    required String respondent_name,
    required String survey_id,
    required String date,
    required String start_time,
    required String end_time,
    required num score,
    required String status,
    required num total_score,
    required String score_percentage,
})async{
    try{
      String userId = _auth.currentUser!.uid;
      await _db.collection("survey").doc(survey_id).set({
        "user_id": userId,
        "respondent_id": respondent_id,
        "respondent_name": respondent_name,
        "survey_id": survey_id,
        "date": date,
        "start_time": start_time,
        "end_time": end_time,
        "score": score,
        "status": status,
        "total_score": total_score,
        "score_percentage": score_percentage,
      });
      return true;
    }
    catch(e){
      print(e);
      return false;
    }
}

Future<bool> logOut() async {
    try{
      await _auth.signOut();
      return true;
    }catch(e){
      print(e);
      return false;
    }
}



}