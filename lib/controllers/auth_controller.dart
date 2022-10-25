import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foxbyte_event/pages/auth/sign_in_page.dart';
import 'package:foxbyte_event/pages/home/home_page.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = "".obs;
  Rxn<User> user = Rxn<User>();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: Platform.isIOS?
        "849850277536-fqpd1ut53uvqpdt5eg40hbcdbecelst4.apps.googleusercontent.com" : null,
    serverClientId: Platform.isAndroid? "849850277536-26com1j2l9q858e46qkv7k66f8935b08.apps.googleusercontent.com" : null,
    scopes: ["email"],
  );

  checkAuth() async {
    _googleSignIn.isSignedIn().then((isSignedIn){
      if (isSignedIn) {
        user.value = _auth.currentUser;
        Get.offAll(() => HomePage());  
      }else{
        Get.offAll(() => SignInPage());  
      }
    });
  }

  Future<User?> signInWithGoogle() async {
    isLoading.value = true;

    final GoogleSignInAccount? googleSignInAccount =
        await _googleSignIn.signIn();

    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    await _auth.signInWithCredential(credential);
    await updateUserData(_auth.currentUser);

    isLoading.value = false;

    return _auth.currentUser;
  }

  Future<void> updateUserData(User? user) async {
    if (user == null) return ;

    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final DocumentReference ref = firestore.collection('users').doc(user.uid);

    await ref.get().then((doc) {
        var dateTimeNow = DateTime.now();

        if (!doc.exists) {
          ref.set({
            'created_at': dateTimeNow,
          });
        }

        ref.update({
          'email': user.email,
          'photo_url': user.photoURL,
          'display_name': user.displayName,
          'updated_at': dateTimeNow,
        });
    });
  }

  Future<void> signOut() async {
    _googleSignIn.disconnect();
    await _auth.signOut();
  }
}
