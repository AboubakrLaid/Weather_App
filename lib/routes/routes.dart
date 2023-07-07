import 'package:flutter/material.dart';
import 'package:weather/screens/Settinngs/settings.dart';
import 'package:weather/screens/home/home.dart';
import 'package:weather/screens/on_bording/on_bording.dart';
import 'package:weather/screens/slider_drawer/slider_drawer.dart';
import 'package:weather/screens/location/location.dart';
import 'package:weather/screens/manage_locations.dart/manage_locations.dart';
import 'package:weather/util/export.dart';

Widget defaultScreen = const OnBording();

final router = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: "/",
  routes: [
    GoRoute(
      path: "/",
      name: "root",
      builder: (context, state) => defaultScreen,
    ),
    GoRoute(
        path: '/Home',
        name: "Home",
        pageBuilder: (context, state) => CustomTransitionPage(
              child: const Home(),
              transitionDuration: const Duration(milliseconds: 200),
              reverseTransitionDuration: const Duration(milliseconds: 200),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            )),
    GoRoute(
        path: '/Location',
        name: "Location",
        pageBuilder: (context, state) => CustomTransitionPage(
              child: const Location(),
              transitionDuration: const Duration(milliseconds: 200),
              reverseTransitionDuration: const Duration(milliseconds: 200),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return SlideTransition(
                  position: Tween<Offset>(
                          begin: const Offset(1, 0), end: const Offset(0, 0))
                      .animate(animation),
                  child: child,
                );
              },
            )),
    GoRoute(
        path: '/SliderDrawer',
        name: "SliderDrawer",
        pageBuilder: (context, state) => CustomTransitionPage(
              child:
                  SliderDrawer(animation: state.extra as AnimationController),
              transitionDuration: const Duration(milliseconds: 200),
              reverseTransitionDuration: const Duration(milliseconds: 200),
              barrierDismissible: true,
              opaque: false,
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: appLanguage.isArabic
                        ? const Offset(1, 0)
                        : const Offset(-1, 0),
                    end: appLanguage.isArabic
                        ? const Offset(0.2, 0)
                        : const Offset(-0.2, 0),
                  ).animate(animation),
                  child: child,
                );
              },
            )),
    GoRoute(
      path: '/ManageLocations',
      name: "ManageLocations",
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const ManageLocations(),
        transitionDuration: const Duration(milliseconds: 300),
        reverseTransitionDuration: const Duration(milliseconds: 300),
        barrierDismissible: true,
        opaque: false,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: Tween<double>(begin: 0.0, end: 1.0).animate(animation),
            child: SlideTransition(
              position: Tween<Offset>(
                      begin: const Offset(0, 1), end: const Offset(0, 0))
                  .animate(animation),
              child: child,
            ),
          );
        },
      ),
    
    ),
     GoRoute(
      path: '/Settings',
      name: "Settings",
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const Settings(),
        transitionDuration: const Duration(milliseconds: 300),
        reverseTransitionDuration: const Duration(milliseconds: 300),
        barrierDismissible: true,
        opaque: false,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: Tween<double>(begin: 0.0, end: 1.0).animate(animation),
            child: SlideTransition(
              position: Tween<Offset>(
                      begin: const Offset(0, 1), end: const Offset(0, 0))
                  .animate(animation),
              child: child,
            ),
          );
        },
      ),
    
    ),
  ],
);
