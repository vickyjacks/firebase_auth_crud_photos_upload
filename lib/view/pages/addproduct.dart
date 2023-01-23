import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/view/dashboard/datafetch.dart';

import 'imageicker.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {

  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> productData = {
    "p_name": "",
    "p_price": "",
    "p_upload_date": DateTime.now().millisecondsSinceEpoch,
    "phone_number": ""
  };
  var _userImageFile;
  final DataController dataController=Get.find();
  void _pickedImage(File image) {
    _userImageFile = image;
    print("Images Got _userImageFile");
    print(_userImageFile);
  }

    addProduct() {
      if (_userImageFile == null) {
        Get.snackbar(
          "Opps",
          "Image Required",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Theme
              .of(context)
              .errorColor,
          colorText: Colors.white,
        );
        return;
      }

    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      print("Form is vaid ");

      print('Data for add product $productData');
      dataController.addNewProduct(productData, _userImageFile);


    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add New Product'),
      ),
      body: Card(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Product Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Product Name Required';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    productData['p_name'] = value!;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Product Price'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Product Price Required';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    productData['p_price'] = value!;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Phone Number'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Phone Number  Required';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    productData['phone_number'] = value!;
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                ImagePickers(_pickedImage),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed:() {
                    addProduct();
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );

  }

}
