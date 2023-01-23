
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:myapp/view/dashboard/datafetch.dart';
import 'package:myapp/view/product/product_view.dart';


class AppDrawer extends StatelessWidget {
final DataController dataController=Get.find();

  @override
  Widget build(BuildContext context) {
   var username= dataController.userProfileData['username'].toString();
    var phone= dataController.userProfileData['phone'].toString();


   return SafeArea(
      child: Container(
        width: 300,
        child: Drawer(
          child: ListView(
            children: [
              Container(
                decoration:
                BoxDecoration(color: Theme.of(context).primaryColor),
                height: 80,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    (username!='')?  Text(
                      'User : ${dataController.userProfileData['username'].toString()}',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ):Container(),
                    (phone!='')?  Text(
                      'phone : ${phone}',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ):Container(),
                    (phone!='')?  Text(
                      //'',
                      'Join Date : ${DateFormat.yMMMMd().format(DateTime.fromMillisecondsSinceEpoch(dataController.userProfileData['joindate']))} ',

                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ):Container(),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: const Text('Your Product'),
                onTap: () {
                 Get.back();
                  Get.to(ProductViewScreen());
                },
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: const Text('LogOut'),
                onTap: () {

                },
              ),
            ],
          ),
        ),
      ),
    ) ;
  }
}