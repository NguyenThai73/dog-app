import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<void> downloadImage(String url) async {
  try {
    
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final directory = await getExternalStorageDirectory();
      final filePath = '${directory!.path}/image.jpg';
      
      File file = File(filePath);
      var abc= await file.writeAsBytes(response.bodyBytes);
      print(abc.toString());
      print('Image downloaded successfully!');
    } else {
      print('Failed to download image. Error code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}
