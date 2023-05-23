import 'package:dog_app/models/breed.dart';
import 'package:dog_app/models/sub-breed.dart';

class Dog {
  int? id;
  Breed? breed;
  SubBreed? subBreed;
  String? url;
  Dog({this.id, this.url, this.breed, this.subBreed});
}
