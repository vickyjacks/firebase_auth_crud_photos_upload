import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:myapp/view/login/authController.dart';

import '../../comman_dailog.dart';
import '../product/productModel.dart';

class DataController extends GetxController {
  AuthController authController = Get.put(AuthController());
  final firebaseInstance = FirebaseFirestore.instance;
  Map userProfileData = {"username": "", "joindate": "", "phone": ""};

  List<Product> loginUserData = [];
  List<Product> allProduct = [];

  void onReady() {
    super.onReady();
    getUserProfileData();
    getAllProduct();
  }

  Future<void> getUserProfileData() async {
    print("user id::  ${authController.userId}");
    print("222222222222222222222222222" + authController.usernames);
    try {
      var response = await firebaseInstance
          .collection('userlist')
          .where('user_id', isEqualTo: authController.userId)
          .get();
      // response.docs.forEach((result) {
      //   print(result.data());
      // });

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
        'user_Id': authController.userId,
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
          .where('user_Id', isEqualTo: authController.userId)
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
          .where('user_Id', isNotEqualTo: authController.userId)
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
