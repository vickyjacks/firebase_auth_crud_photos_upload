import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'dart:ui';

import 'package:myapp/view/login/authController.dart';
import 'package:myapp/view/signup/signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  AuthController controller =Get.put(AuthController());

Map<String ,String> userloginData = {"email":"","password":""};
  TextEditingController emailController= TextEditingController();
  TextEditingController passwordController= TextEditingController();

  final _formKey=GlobalKey<FormState>();

  loginFunaction(){
    if(_formKey.currentState!.validate()){
      print("here is ready for login screens");
      _formKey.currentState!.save();
      print("Data for login ${userloginData}");
      controller.logInController(userloginData['email'],userloginData['password']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height,
          ),
          decoration: BoxDecoration(
            gradient: new LinearGradient(
              colors: [
                Colors.orange.shade900,
                Colors.orangeAccent.shade100,
              ],
              begin: Alignment.topLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 36.0, horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 42.0,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        "Enter a Beautiful Place",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value){
                              if(value==null || value.isEmpty){
                                return "email required";
                              }
                              return null;
                            },
                            onSaved: (value){
                              userloginData['email']=value!;
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xFFE7EDEB),
                              hintText: "Email",
                              prefixIcon: Icon(
                                Icons.mail,
                                color: Colors.grey[600],
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            validator: (value){
                              if(value==null || value.isEmpty){
                                return "password required";
                              }
                            },
                            onSaved: (value){
                              userloginData['password']=value!;
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xFFE7EDEB),
                              hintText: "password",
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Colors.grey[600],
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "Forget password",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  color: Colors.blue[800],
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 50.0,
                          ),
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(8.0)),
                              gradient: new LinearGradient(
                                colors: [
                                  Colors.orange.shade900,
                                  Colors.orangeAccent.shade100,
                                ],
                                begin: Alignment.topRight,
                                end: Alignment.centerLeft,
                              ),
                            ),

                            width: double.infinity,
                            child: TextButton(
                              onPressed: () {
                                loginFunaction();
                              },
                              // shape: RoundedRectangleBorder(
                              //   borderRadius: BorderRadius.circular(8.0),
                              // ),
                             // color: Colors.blue[600],
                              child: Padding(
                                padding:
                                const EdgeInsets.symmetric(vertical: 0),
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 80.0,
                          ),
                      TextButton(onPressed: () { Get.to(SignUpPage()); },
                        child:
                        Text("Don't have an Account ? register now"))
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
 