import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final firebaseAuth = FirebaseAuth.instance;
final firebaseFireStoreDataUTypes = FirebaseFirestore.instance.collection('roles');

  class authService {

    Future<String?> signupHataYakalama(String email, String password, String ad,
        String soyad) async {
      String? res;
      try {
        final result = await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,);
        try {
          final resultData = await FirebaseFirestore.instance.collection('users').add({
            'email' : email,
            'name' : ad,
            'surname' : soyad
          });
         // final resultDataUTypes = await firebaseFireStoreDataUTypes.add({
           // 'roleCode' : roleCode,
          //  'roleName' : roleName
         // });
        }
        catch (e) {
          print('$e');
        }
        res = "success";
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case "invalid-email":
            res = "Lütfen dogru email biciminde girin";
            break;
          case "email-already-in-use":
            res = "Bu Email Zaten Kullanımda";
            break;
          case "weak-password":
            res = "Lütfen 8 karakter üstünde bi parola giriniz";
            break;
          default:
            res = 'Failed with error code: ${e.code}';
            break;
        }
      }
      return res;
    }
  }