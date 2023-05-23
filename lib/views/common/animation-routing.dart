import 'package:flutter/material.dart';

class EnterExitRoute extends PageRouteBuilder {
  final String enterRouteName;
  final String exitRouteName;

  EnterExitRoute({required this.enterRouteName, required this.exitRouteName})
      : super(
          settings: RouteSettings(name: enterRouteName),
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              Container(), // Thay thế Container bằng widget tương ứng với enterRouteName
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              Stack(
            children: <Widget>[
              SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.0, 0.0),
                  end: const Offset(-1.0, 0.0),
                ).animate(animation),
                child:
                    Container(), // Thay thế Container bằng widget tương ứng với exitRouteName
              ),
              SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(animation),
                child:
                    Container(), // Thay thế Container bằng widget tương ứng với enterRouteName
              ),
            ],
          ),
        );
}
