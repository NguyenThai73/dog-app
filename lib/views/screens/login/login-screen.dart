// ignore_for_file: prefer_const_constructors, deprecated_member_use, use_build_context_synchronously
import 'package:dog_app/controller/user.proviser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/firebase-auth.dart';
import '../../../models/breed.dart';
import '../../../models/dog.dart';
import '../../../models/dogf.dart';
import '../../../models/user.dart';
import '../../common/button-login-other.dart';
import '../../common/toast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> processing() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return Center(child: const CircularProgressIndicator());
        },
      );
    }

    return Consumer<Security>(
      builder: (context, security, child) => Scaffold(
        backgroundColor: Color(0xffFFFFFF),
        body: ListView(
          children: [
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 42, left: 22),
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.black, width: 1)),
                  child: IconButton(
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      Navigator.pushNamed(context, "/welcome");
                    },
                    icon: Icon(
                      Icons.navigate_before,
                      size: 30,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10, top: 20),
                  width: 130,
                  height: 130,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 60,
                            height: 60,
                            child: Image.asset(
                              "assets/images/1.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 60,
                            height: 60,
                            child: Image.asset(
                              "assets/images/2.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 60,
                            height: 60,
                            child: Image.asset(
                              "assets/images/3.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 60,
                            height: 60,
                            child: Image.asset(
                              "assets/images/4.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    margin: const EdgeInsets.only(left: 33.0, right: 27, bottom: 18),
                    height: 52.0,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(color: Color(0xffF6F6F6), borderRadius: BorderRadius.circular(10.0), border: Border.all(width: 1, color: Color(0x60606078))),
                    child: TextField(
                      decoration: InputDecoration(hintText: "Email", hintStyle: TextStyle(color: Color(0xffAFAFAF)), border: InputBorder.none),
                      controller: username,
                      obscureText: false,
                    )),
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    margin: const EdgeInsets.only(left: 33.0, right: 27, bottom: 18),
                    height: 52.0,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(color: Color(0xffF6F6F6), borderRadius: BorderRadius.circular(10.0), border: Border.all(width: 1, color: Color(0x60606078))),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Password",
                              hintStyle: TextStyle(color: Color(0xffAFAFAF)),
                              border: InputBorder.none,
                            ),
                            controller: password,
                            obscureText: true,
                          ),
                        ),
                        // IconButton(
                        //   padding: EdgeInsets.all(0),
                        //   onPressed: () {},
                        //   icon: Icon(Icons.visibility),
                        // )
                      ],
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/sign");
                        },
                        child: Text(
                          "Register member",
                          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: Colors.black),
                        )),
                    SizedBox(
                      width: 33,
                    )
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(left: 33.0, right: 27, bottom: 18, top: 47),
                  padding: EdgeInsets.all(0),
                  height: 52.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: Color(0xff0064D2), borderRadius: BorderRadius.circular(10.0), border: Border.all(width: 1, color: Color(0x60606078)), boxShadow: const [
                    BoxShadow(
                      color: Color(0x00000040),
                      offset: Offset(0, 4),
                      blurRadius: 4,
                      spreadRadius: 0,
                    ),
                  ]),
                  child: TextButton(
                    onPressed: () async {
                      processing();
                      if (username.text == "" || password.text == "") {
                        showToast(
                          context: context,
                          msg: "Need to fill out the information completely",
                          color: Color.fromRGBO(245, 115, 29, 0.464),
                          icon: const Icon(Icons.warning),
                          timeHint: 2,
                        );
                        Navigator.pop(context);
                      } else {
                        try {
                          UserCredential userCredential = await _auth.signInWithEmailAndPassword(
                            email: username.text,
                            password: password.text,
                          );
                          User? user = userCredential.user;
                          security.changeUser(UserLogin(
                            uuid: user?.uid,
                            displayName: user?.displayName,
                            photoURL: user?.photoURL,
                            userName: user?.email,
                          ));
                          List<DogF> listDog = [];
                          DatabaseReference ref = FirebaseDatabase.instance.ref("favorites/${user?.uid}");
                          try {
                            final snapshot = await ref.get();
                            if (snapshot.exists) {
                              var listData = snapshot.value as Map;
                              listData.forEach((key, value) {
                                Breed breed = Breed(breed: value['breed']);

                                DogF item = DogF(breed: breed, url: value['url'],key:key );
                                listDog.add(item);
                              });
                              // listData.forEach((element) {

                              // });
                            } else {
                              print('No data available.');
                            }
                          } catch (e) {
                            print("loi:$e");
                          }
                          security.changeListGodF(listDog);
                          Navigator.pushNamed(context, "/home");
                        } catch (e) {
                          showToast(
                            context: context,
                            msg: "Account password is not correct",
                            color: Color.fromRGBO(245, 115, 29, 0.464),
                            icon: const Icon(Icons.warning),
                            timeHint: 2,
                          );
                          Navigator.pop(context);
                        }
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Login",
                          style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white, fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 33.0, right: 32, bottom: 30, top: 30),
                  padding: EdgeInsets.all(0),
                  child: Row(
                    children: const [
                      Expanded(child: Divider(color: Colors.black, height: 1)),
                      Text(
                        " Or Login With ",
                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: Colors.black),
                      ),
                      Expanded(child: Divider(color: Colors.black, height: 1)),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 33,
                    ),
                    Expanded(
                      child: ButtonLink(
                        onPressed: () async {},
                        url: "assets/icon/facebook.png",
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: ButtonLink(
                        onPressed: () async {},
                        url: "assets/icon/google.png",
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: ButtonLink(
                        onPressed: () {},
                        url: "assets/icon/apple.png",
                      ),
                    ),
                    SizedBox(
                      width: 33,
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
