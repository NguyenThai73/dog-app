import 'package:dog_app/models/dogf.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../../../../controller/api.dart';
import '../../../../controller/user.proviser.dart';
import '../../../common/download-image.dart';
import '../../../common/toast.dart';

class ViewImageFa extends StatelessWidget {
  final DogF dog;

  ViewImageFa({required this.dog});

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

    return SafeArea(
        child: Consumer<Security>(
      builder: (context, security, child) => Scaffold(
        appBar: AppBar(title: Text(dog.breed!.breed!), actions: [
          IconButton(
              onPressed: () async {
                DatabaseReference ref = FirebaseDatabase.instance.ref("favorites/${security.user.uuid}");
                ref.child("/${dog.key}").remove();
                List<DogF> listDog = security.listDogF;
                listDog.remove(dog);
                security.changeListGodF(listDog);
                showToast(
                  context: context,
                  msg: "Removed from favorites",
                  color: Color.fromRGBO(26, 255, 22, 0.542),
                  icon: const Icon(Icons.done),
                  timeHint: 2,
                );
                Navigator.pop(context);
              },
              icon: Icon(Icons.delete)),
          IconButton(
              onPressed: () async {
                processing();
                await downloadImage(dog.url!);
                Navigator.pop(context);
              },
              icon: Icon(Icons.download))
        ]),
        body: Container(
          child: PhotoView(
            imageProvider: NetworkImage(dog.url!),
          ),
        ),
      ),
    ));
  }
}
