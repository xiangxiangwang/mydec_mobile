

import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:mydec/account/models/user.dart';
import 'package:mydec/common/models/global.dart';

class UserService {

  static bool userExists(String email) {
    print('userExists WITH EMAIL: $email');
    FirebaseDatabase.instance.reference().child("_encodeUserEmail(email)").once().then((DataSnapshot snapshot) {
      print('userExists: Connected to  database and read ${snapshot.value}');
      return true;
    });

    return false;
  }

  static DecUser getUserByEmail(String email) {
    FirebaseDatabase.instance.reference().child(encodeUserEmail(email)).once().then((DataSnapshot snapshot) {
      print('getUserByEmail: Connected to  database and read ${snapshot.value}');
      return DecUser.fromJson(snapshot.value);
    });

  }
  static DecUser initUser(String email) {
    DecUser user = new DecUser();
    user.email = email;
    user.certifiedMember = false;

    print('initUser: ${user.toJson()}');
    return user;

  }
  static void persistUser(DecUser user) {

    print('will persist ${user.toJson()}');
    FirebaseDatabase.instance.reference().child(encodeUserEmail(user.email)).set(user.toJson());
  }

  static String encodeUserEmail(String userEmail) {
    return userEmail.replaceAll(".", ",");
  }

  static String _decodeUserEmail(String userEmail) {
    return userEmail.replaceAll(",", ".");
  }

  static void onUserLogin(String email){

    FirebaseDatabase.instance.reference().child(encodeUserEmail(email)).once().then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        // we already have the user structrure setup for the email, let's load it

        print('initUser: ${snapshot.value}');
        Global.setCurrentUser(DecUser.fromJson(new Map<String, dynamic>.from(snapshot.value)));
      }
      else {
        // we have'nt setup the user yet. let's create the user structure and save
        // it to the database
        DecUser user = new DecUser();
        user.email = email;
        user.firstName = "";
        user.lastName = "";
        user.certifiedMember = false;
        user.pastoralZone = "";
        user.pastoralGroup = "";
        user.pastoralRole = "";

        print('initUser: ${user.toJson()}');

        FirebaseDatabase.instance.reference().child(encodeUserEmail(user.email)).set(user.toJson());
        Global.setCurrentUser(user);

      }

    });
  }
}