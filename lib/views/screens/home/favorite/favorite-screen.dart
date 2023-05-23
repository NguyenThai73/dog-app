// ignore_for_file: prefer_const_constructors, deprecated_member_use, use_build_context_synchronously, unused_local_variable
import 'dart:async';
import 'package:dog_app/models/breed.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../controller/user.proviser.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../../../models/dog.dart';
import '../home/view-image.dart';
import 'view-image-fa.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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
        builder: (context, security, child) => Container(
            padding: EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 25),
                      width: 130,
                      height: 50,
                      decoration: BoxDecoration(border: Border.all(color: Colors.blue, width: 1), borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Text(
                          "Favorites",
                          style: TextStyle(color: Colors.blue, fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: GridView.builder(
                    itemCount: security.listDogF.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return TextButton(
                        onPressed: () {
                          Navigator.push<void>(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) => ViewImageFa(
                                dog: security.listDogF[index],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          // margin: EdgeInsets.all(5),
                          height: 200,
                          color: Color.fromARGB(119, 0, 0, 0),
                          child: FadeInImage.assetNetwork(
                            placeholder: 'assets/gif/load.gif',
                            image: security.listDogF[index].url!,
                            fit: BoxFit.fill,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            )));
  }
}
