import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:myapp/drawer.dart';
import 'package:myapp/view/pages/addproduct.dart';
import 'package:url_launcher/url_launcher.dart';
import 'datafetch.dart';



class HomeScreen extends StatelessWidget {

 final DataController controller = Get.put(DataController());

  @override
  Widget build(BuildContext context) {
    var color = LinearGradient(
      colors: [
        Colors.orange.shade900,
        Colors.orangeAccent.shade100,
      ],
      begin: Alignment.topLeft,
      end: Alignment.centerRight,
    );
    return Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(

          backgroundColor: Colors.orange,
          centerTitle: true,
          title: Text('All Product List'),
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(AddProductScreen());
                },
                icon: Icon(Icons.add))
          ],
        ),
      body:
      GetBuilder<DataController>(
        builder: (controller) => controller.allProduct.isEmpty
            ? Center(
          child: Text('😔 NO DATA FOUND (: 😔'),
        )
            : ListView.builder(
          itemCount: controller.allProduct.length,
          itemBuilder: (context, index) {
            return Card(
              child: Column(
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    child: Image.network(
                      controller.allProduct[index].productimage,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Product Name: ${controller.allProduct[index].productname}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Price: ${controller.allProduct[index].productprice.toString()}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            child: ElevatedButton(
                               // onPressed: (){
                               //
                               //  },
                              onPressed: () =>
                                  launch(
                                  "tel:${controller.allProduct[index].phonenumber.toString()}"),
                               child: Text('CALL'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),

      );

  }
}
