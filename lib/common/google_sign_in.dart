import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mydec/account/models/user.dart';
import 'package:mydec/account/services/user_service.dart';

import 'models/global.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

String getCurrentUser() {
  final User user = _auth.currentUser;
  final uid = user.uid;
  // Similarly we can get email as well
  //final uemail = user.email;
  print("user's uid: $uid");
  print("user's display name: ${user.displayName}");
  //print(uemail);
  return user.email;
}

Future<String> signInWithGoogle() async {
  // await Firebase.initializeApp();

  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final UserCredential authResult = await _auth.signInWithCredential(credential);
  final User user = authResult.user;

  if (user != null) {
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final User currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);

    print('signInWithGoogle succeeded: $user');
    _loadUserInformation(currentUser.email);

    return '${user.email}';
  }

  return null;
}

void _loadUserInformation(String email) {

    UserService.onUserLogin(email);

}


Future<void> signOutGoogle() async {
  await googleSignIn.signOut();

  print("User Signed Out");
}