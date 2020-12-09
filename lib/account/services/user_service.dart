

import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:mydec/account/models/user.dart';
import 'package:mydec/common/models/global.dart';

class UserService {

  static bool userExists(String uid) {
    print('userExists WITH uid: $uid');
    FirebaseDatabase.instance.reference().child("users").child(uid).once().then((DataSnapshot snapshot) {
      print('userExists: Connected to  database and read ${snapshot.value}');
      return true;
    });

    return false;
  }

  static DecUser getUserByUID(String uid) {
    FirebaseDatabase.instance.reference().child("users").child(uid).once().then((DataSnapshot snapshot) {
      print('getUserByEmail: Connected to  database and read ${snapshot.value}');
      return DecUser.fromJson(snapshot.value);
    });

  }
  static DecUser initUser(String email, String uid) {
    DecUser user = new DecUser();
    user.email = email;
    user.uid = uid;
    user.certifiedMember = false;

    print('initUser: ${user.toJson()}');
    return user;

  }
  static void persistUser(DecUser user) {

    print('will persist ${user.toJson()}');
    FirebaseDatabase.instance.reference().child("users").child(user.uid).set(user.toJson());
  }

  static String encodeUserEmail(String userEmail) {
    return userEmail.replaceAll(".", ",");
  }

  static String _decodeUserEmail(String userEmail) {
    return userEmail.replaceAll(",", ".");
  }

  static Future<void> onUserLogin(String email, String uid) async {

    DataSnapshot snapshot = await FirebaseDatabase.instance.reference().child("users").child(uid).once();

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
        user.uid = uid;
        user.firstName = "";
        user.lastName = "";
        user.certifiedMember = false;
        user.pastoralZone = "";
        user.pastoralGroup = "";
        user.pastoralRole = "";


        print('initUser: ${user.toJson()}');

        FirebaseDatabase.instance.reference().child("users").child(uid).set(user.toJson());
        Global.setCurrentUser(user);

      }
  }
}