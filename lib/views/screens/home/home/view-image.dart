// ignore_for_file: unnecessary_string_interpolations, prefer_const_constructors, use_build_context_synchronously, avoid_unnecessary_containers

import 'package:dog_app/models/breed.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import '../../../../controller/user.proviser.dart';
import '../../../../models/dog.dart';
import '../../../../models/dogf.dart';
import '../../../common/download-image.dart';
import '../../../common/toast.dart';

class ViewImage extends StatefulWidget {
  final String breed;
  final String url;
  ViewImage({super.key, required this.url, required this.breed});
  @override
  State<ViewImage> createState() => _ViewImageState();
}

class _ViewImageState extends State<ViewImage> {
  bool statusData = false;
  bool checkFavorite = false;
  var security;

  void callApi() async {
    setState(() {
      statusData = false;
    });
    security.listDogF.forEach((element) {
      if (widget.url == element.url) {
        print("trung");
        setState(() {
          checkFavorite = true;
        });
      }
    });

    setState(() {
      statusData = true;
    });
  }

  @override
  void initState() {
    super.initState();
    security = Provider.of<Security>(context, listen: false);
    Future.delayed(Duration(seconds: 1), () {
      callApi();
    });
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

    return SafeArea(
        child: Consumer<Security>(
      builder: (context, security, child) => (statusData)
          ? Scaffold(
              appBar: AppBar(title: Text("${(widget.breed)}"), actions: [
                IconButton(
                  onPressed: (!checkFavorite)
                      ? () async {
                          DatabaseReference ref = FirebaseDatabase.instance.ref("favorites/${security.user.uuid}");
                          DatabaseReference newPostRef = ref.push();
                          newPostRef.set({
                            "breed": "${widget.breed}",
                            "url": "${widget.url}",
                          });
                          List<DogF> listDog = security.listDogF;
                          listDog.add(DogF(key: newPostRef.key, breed: Breed(breed: widget.breed), url: widget.url));
                          security.changeListGodF(listDog);
                          setState(() {
                            checkFavorite = true;
                          });
                           showToast(
                          context: context,
                          msg: "Added to favorites",
                          color: Color.fromRGBO(26, 255, 22, 0.542),
                          icon: const Icon(Icons.done),
                          timeHint: 2,
                        );
                        }
                      : null,
                  icon: Icon(Icons.favorite, color: (!checkFavorite) ? Colors.grey : Colors.red),
                ),
                IconButton(
                    onPressed: () async {
                      processing();
                      await downloadImage(widget.url);
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.download))
              ]),
              body: Container(
                child: PhotoView(
                  imageProvider: NetworkImage(widget.url),
                ),
              ),
            )
          : Center(child: const CircularProgressIndicator()),
    ));
  }
}
