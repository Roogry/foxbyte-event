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
    clientId:
        "849850277536-fqpd1ut53uvqpdt5eg40hbcdbecelst4.apps.googleusercontent.com",
    scopes: ["email"],
  );

  checkAuth() async {
    User? user = _auth.currentUser;

    if (user?.email != null) {
      Get.offAll(() => HomePage());
    }
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
    isLoading.value = false;

    return _auth.currentUser;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
