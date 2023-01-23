import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:myapp/view/login/login.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print('something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'MyApp',
              theme: ThemeData(
                brightness: Brightness.light,
                primaryColor: Colors.orange,
                // textTheme: TextTheme(subtitle1: TextStyle(color: grey)),
                fontFamily: 'poppins_regular',
              ),
            home: LoginPage(),
          );

        });


  }
}


