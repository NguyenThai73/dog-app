// ignore_for_file: unused_field, unused_element, unused_import, prefer_const_constructors_in_immutables

import 'package:dog_app/views/screens/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import 'controller/user.proviser.dart';
import 'firebase_options.dart';
import 'views/common/animation-routing.dart';
import 'views/screens/login/login-screen.dart';
import 'views/screens/sign/sign-screen.dart';
import 'views/screens/welcome/welcome-screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Security()),
      ],
      child:  MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
   MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const LoginScreen(),
      initialRoute: '/welcome',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/sign': (context) => const SignScreen(),
        '/welcome': (context) => const WelComeScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
