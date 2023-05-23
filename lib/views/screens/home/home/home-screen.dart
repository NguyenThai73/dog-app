// ignore_for_file: prefer_const_constructors, deprecated_member_use, use_build_context_synchronously
import 'dart:convert';
import 'package:dog_app/views/screens/home/home/view-image.dart';
import 'package:photo_view/photo_view.dart';
import 'package:dog_app/models/breed.dart';
import 'package:dog_app/models/dog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dropdown_search/dropdown_search.dart';
import '../../../../controller/api.dart';
import '../../../../controller/user.proviser.dart';
import '../../../../models/sub-breed.dart';

class HomeBodyScreen extends StatefulWidget {
  const HomeBodyScreen({Key? key}) : super(key: key);

  @override
  State<HomeBodyScreen> createState() => _HomeBodyScreenState();
}

class _HomeBodyScreenState extends State<HomeBodyScreen> {
  bool statusData = false;
  Breed selectedBreed = Breed();
  SubBreed selectedSubBreed = SubBreed(subBreed: "--Chọn--");
  List<Dog> listDog = [];

  getImage(Breed breed, SubBreed subBreed) async {
    var spiBreed = "";
    if (subBreed.subBreed == "--Chọn--") {
      spiBreed = breed.breed!;
    } else {
      spiBreed = "${breed.breed}/${subBreed.subBreed}";
    }
    setState(() {
      listDog = [];
    });
    print("/api/breed/$spiBreed/images");
    var response1 = await httpGet("/api/breed/$spiBreed/images", context);
    var body1 = response1['body'];
    body1['message'].forEach((element) {
      Dog item = Dog(url: element);
      setState(() {
        listDog.add(item);
      });
    });
  }

  void callApi() async {
    var response = await httpGet("/api/breeds/list/all", context);
    if (response.containsKey("body")) {
      var body = await response['body'];
      var breedName = await body['message'].keys.first ?? "";
      var breedNumber = await body['message'][body['message'].keys.first].length ?? 0;
      setState(() {
        selectedBreed = Breed(breed: breedName, numberSub: breedNumber);
      });
    }
    await getImage(selectedBreed, selectedSubBreed);

    setState(() {
      statusData = true;
    });
  }

  var abc = {};

  Future<List<Breed>> getBreed() async {
    List<Breed> resultBreed = [];
    var response3 = await httpGet("/api/breeds/list/all", context);
    resultBreed = [];
    if (response3.containsKey("body")) {
      setState(() {
        var body = response3['body'];
        var message = body['message'];
        message.forEach((key, value) {
          Breed itemBreed = Breed(breed: key, numberSub: value.length);
          resultBreed.add(itemBreed);
        });
      });
    }
    return resultBreed;
  }

  Future<List<SubBreed>> getSubBreed(Breed breed) async {
    List<SubBreed> resultSubBreed = [];
    var response4 = await httpGet("/api/breed/${breed.breed}/list", context);
    resultSubBreed = [];
    if (response4.containsKey("body")) {
      setState(() {
        var body = response4['body'];
        var message = body['message'];
        message.forEach((element) {
          SubBreed itemBreed = SubBreed(breed: breed.breed, subBreed: element);
          resultSubBreed.add(itemBreed);
        });
      });
      resultSubBreed.insert(0, SubBreed(subBreed: "--Chọn--"));
    }
    return resultSubBreed;
  }

  @override
  void initState() {
    super.initState();
    callApi();
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
        builder: (context, security, child) => (statusData)
            ? Container(
                padding: EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(),
                child: Column(
                  children: [
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: 5),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      'Breed ',
                                      style: TextStyle(color: Colors.blue, fontSize: 20),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Container(
                                      color: Colors.white,
                                      width: MediaQuery.of(context).size.width * 0.20,
                                      height: 40,
                                      child: DropdownSearch<Breed>(
                                        popupProps: PopupPropsMultiSelection.menu(
                                          showSearchBox: true,
                                        ),
                                        dropdownDecoratorProps: DropDownDecoratorProps(
                                          baseStyle: TextStyle(color: Colors.blue, fontSize: 15),
                                          dropdownSearchDecoration: InputDecoration(
                                            helperStyle: TextStyle(color: Colors.blue, fontSize: 15),
                                            constraints: const BoxConstraints.tightFor(
                                              width: 300,
                                              height: 40,
                                            ),
                                            contentPadding: const EdgeInsets.only(left: 14, bottom: 14),
                                            focusedBorder: const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                              borderSide: BorderSide(color: Colors.blue, width: 0.5),
                                            ),
                                            hintMaxLines: 2,
                                            enabledBorder: const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                              borderSide: BorderSide(color: Colors.blue, width: 0.5),
                                            ),
                                          ),
                                        ),
                                        asyncItems: (String? filter) => getBreed(),
                                        itemAsString: (Breed u) => u.breed!,
                                        selectedItem: selectedBreed,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedBreed = value!;
                                            if (selectedBreed.numberSub == 0) selectedSubBreed = SubBreed(subBreed: "--Chọn--");
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              if (selectedBreed.numberSub! > 0) SizedBox(height: 10),
                              if (selectedBreed.numberSub! > 0)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        'Subbreed ',
                                        style: TextStyle(color: Colors.blue, fontSize: 20),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 5,
                                      child: Container(
                                        color: Colors.white,
                                        width: MediaQuery.of(context).size.width * 0.20,
                                        height: 40,
                                        child: DropdownSearch<SubBreed>(
                                          popupProps: PopupPropsMultiSelection.menu(
                                            showSearchBox: true,
                                          ),
                                          dropdownDecoratorProps: DropDownDecoratorProps(
                                            baseStyle: TextStyle(color: Colors.blue, fontSize: 15),
                                            dropdownSearchDecoration: InputDecoration(
                                              helperStyle: TextStyle(color: Colors.blue, fontSize: 15),
                                              constraints: const BoxConstraints.tightFor(
                                                width: 300,
                                                height: 40,
                                              ),
                                              contentPadding: const EdgeInsets.only(left: 14, bottom: 14),
                                              focusedBorder: const OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                                borderSide: BorderSide(color: Colors.blue, width: 0.5),
                                              ),
                                              hintMaxLines: 2,
                                              enabledBorder: const OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                                borderSide: BorderSide(color: Colors.blue, width: 0.5),
                                              ),
                                            ),
                                          ),
                                          asyncItems: (String? filter) => getSubBreed(selectedBreed),
                                          itemAsString: (SubBreed u) => u.subBreed!,
                                          selectedItem: selectedSubBreed,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedSubBreed = value!;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            left: 10,
                          ),
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: IconButton(
                                  onPressed: () async {
                                    processing();
                                    await getImage(selectedBreed, selectedSubBreed);
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.search,
                                    color: Colors.white,
                                  ))),
                        ),
                        SizedBox(width: 5),
                      ],
                    ),
                    SizedBox(height: 5),
                    Divider(color: Colors.blue[200], thickness: 2),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Search results: ${listDog.length} ${(selectedSubBreed.subBreed != "--Chọn--") ? "${selectedSubBreed.subBreed} - ${selectedBreed.breed}" : "${selectedBreed.breed}"}",
                          style: TextStyle(color: Colors.blue.shade700),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child: GridView.builder(
                        itemCount: listDog.length,
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
                                  builder: (BuildContext context) => ViewImage(
                                    breed:(selectedSubBreed.subBreed != "--Chọn--") ? "${selectedSubBreed.subBreed} - ${selectedBreed.breed}" : "${selectedBreed.breed}",
                                    url: listDog[index].url!,
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
                                image: listDog[index].url!,
                                fit: BoxFit.fill,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ))
            : Center(child: const CircularProgressIndicator()));
  }
}
