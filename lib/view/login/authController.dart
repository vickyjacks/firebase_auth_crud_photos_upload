import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:myapp/view/login/login.dart';
import '../../comman_dailog.dart';
import '../dashboard/home.dart';

class AuthController extends GetxController {
  var userId;
  var usernames;
  Future<void> signUpController(email, password, username, phone) async {
    print("$email,$password,$username,$phone");
    try {
      CommanDialog.showLoading();
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      print(credential);
      CommanDialog.hideLoading();

      try {
        CommanDialog.showLoading();
        var response =
            await FirebaseFirestore.instance.collection('userlist').add({
          'user_id': credential.user!.uid,
          'user_name': username,
          'phone': phone,
          'password': password,
          'joindate': DateTime.now().millisecondsSinceEpoch,
          'email': email
        });
        print("response:: ${response.toString()}");
        CommanDialog.hideLoading();
        Get.back();
      } catch (execption) {
        CommanDialog.hideLoading();
        print("error saving data ${execption}");
      }

      Get.back();
    } on FirebaseAuthException catch (e) {
      CommanDialog.hideLoading();
      if (e.code == 'weak-password') {
        CommanDialog.showErrorDialog(
            description: "The password provided is too weak.");
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        CommanDialog.showErrorDialog(
            description: "The account already exists for that email.");
        print('The account already exists for that email.');
      }
    } catch (e) {
      CommanDialog.hideLoading();
      CommanDialog.showErrorDialog(description: "something went wrong");
      print(e);
    }
  }

  Future<void> logInController(email, password) async {
    print("$email,$password");
    CommanDialog.showLoading();
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email.trim(), password: password);
      CommanDialog.hideLoading();
      Get.off(() => HomeScreen());
      userId = credential.user!.uid;
      usernames=credential.user!.email;
      print("credential :: 12 ${credential}");
    } on FirebaseAuthException catch (e) {
      CommanDialog.hideLoading();
      if (e.code == 'user-not-found') {
        CommanDialog.showErrorDialog(
            description: "No user found for that email.");
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        CommanDialog.showErrorDialog(
            description: "Wrong password provided for that user.");
        print('Wrong password provided for that user.');
      }
    }
  }
}
