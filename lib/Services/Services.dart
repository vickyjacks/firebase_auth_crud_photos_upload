import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

import '../../comman_dailog.dart';
import '../view/dashboard/home.dart';
import '../view/product/productModel.dart';

class Services extends GetxController {
 // AuthController authController = Get.put(AuthController());
  var userId;
  var useremail;
  final firebaseInstance = FirebaseFirestore.instance;
  Map userProfileData = {"username": "", "joindate": "", "phone": ""};

  List<Product> loginUserData = [];
  List<Product> allProduct = [];

  void onReady() {
    super.onReady();
    getUserProfileData();
    getAllProduct();
  }
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
      print("credential ++++++++++++++  ${credential}");
      CommanDialog.hideLoading();
      Get.off(() => HomeScreen());
      userId = credential.user!.uid;
      print("login ++++++ ${userId}");
      useremail=credential.user!.email;
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

  Future<void> getUserProfileData() async {
    try {
      var response = await firebaseInstance
          .collection('userlist')
          .where('user_id', isEqualTo: userId)
          .get();
      // response.docs.forEach((result) {
      //   print(result.data());
      // });
print("++++++++++++++++///////////// Line :: 113"  +response.docs[0]['user_name']);
      if (response.docs.length > 0) {
        userProfileData['username'] = response.docs[0]['user_name'];
        userProfileData['joindate'] = response.docs[0]['joindate'];
        userProfileData['phone'] = response.docs[0]['phone'];
      }
      print("userProfileData :: ${userProfileData}");
    } on FirebaseException catch (e) {
      print(e);
    } catch (error) {
      print(error);
    }
  }

  Future<void> addNewProduct(Map productdata, File image) async {
    var pathimage = image.toString();
    var temp = pathimage.lastIndexOf('/');
    var result = pathimage.substring(temp + 1);
    print(result);
    final ref =
    FirebaseStorage.instance.ref().child('product_images').child(result);
    var response = await ref.putFile(image);
    print("Updated $response");
    var imageUrl = await ref.getDownloadURL();

    try {
      CommanDialog.showLoading();
      var response = await firebaseInstance.collection('productlist').add({
        'product_name': productdata['p_name'],
        'product_price': productdata['p_price'],
        "product_upload_date": productdata['p_upload_date'],
        'product_image': imageUrl,
        'user_Id': userId,
        "phone_number": productdata['phone_number'],
      });
      print("Firebase response1111 $response");
      CommanDialog.hideLoading();
      Get.back();
    } catch (exception) {
      CommanDialog.hideLoading();
      print("Error Saving Data at firestore $exception");
    }
  }

  Future<void> getLoginUserProduct() async {
    print("loginUserData YEs $loginUserData");
    loginUserData = [];
    try {
      CommanDialog.showLoading();
      final List<Product> lodadedProduct = [];
      var response = await firebaseInstance
          .collection('productlist')
          .where('user_Id', isEqualTo: userId)
          .get();

      if (response.docs.length > 0) {
        response.docs.forEach(
              (result) {
            print(result.data());
            print("Product ID  ${result.id}");
            lodadedProduct.add(
              Product(
                  productId: result.id,
                  userId: result['user_Id'],
                  productname: result['product_name'],
                  productprice: double.parse(result['product_price']),
                  productimage: result['product_image'],
                  phonenumber: int.parse(result['phone_number']),
                  productuploaddate: result['product_upload_date'].toString()),
            );
          },
        );
      }
      loginUserData.addAll(lodadedProduct);
      update();
      CommanDialog.hideLoading();

    } on FirebaseException catch (e) {
      CommanDialog.hideLoading();
      print("Error $e");
    } catch (error) {
      CommanDialog.hideLoading();
      print("error $error");
    }
  }

  Future<void> getAllProduct() async {
    allProduct = [];
    try {
      CommanDialog.showLoading();
      final List<Product> lodadedProduct1 = [];
      var response = await firebaseInstance
          .collection('productlist')
          .where('user_Id', isNotEqualTo: userId)
          .get();
      if (response.docs.length > 0) {
        response.docs.forEach(
              (result) {
            print(result.data());
            print(result.id);
            lodadedProduct1.add(
              Product(
                  productId: result.id,
                  userId: result['user_Id'],
                  productname: result['product_name'],
                  productprice: double.parse(result['product_price']),
                  productimage: result['product_image'],
                  phonenumber: int.parse(result['phone_number']),
                  productuploaddate: result['product_upload_date'].toString()),
            );
          },
        );
        allProduct.addAll(lodadedProduct1);
        update();
      }

      CommanDialog.hideLoading();
    } on FirebaseException catch (e) {
      CommanDialog.hideLoading();
      print("Error $e");
    } catch (error) {
      CommanDialog.hideLoading();
      print("error $error");
    }
  }

  Future editProduct(productId, price) async {
    print("Product Id  $productId");
    try {
      CommanDialog.showLoading();
      await firebaseInstance
          .collection("productlist")
          .doc(productId)
          .update({"product_price": price}).then((_) {
        CommanDialog.hideLoading();
        getLoginUserProduct();
      });
    } catch (error) {
      CommanDialog.hideLoading();
      CommanDialog.showErrorDialog();

      print(error);
    }
  }

  Future deleteProduct(String productId) async {
    print("Product Iddd  $productId");
    try {
      CommanDialog.showLoading();
      await firebaseInstance
          .collection("productlist")
          .doc(productId)
          .delete()
          .then((_) {
        CommanDialog.hideLoading();
        getLoginUserProduct();
      });
    } catch (error) {
      CommanDialog.hideLoading();
      CommanDialog.showErrorDialog();
      print(error);
    }
  }

}
