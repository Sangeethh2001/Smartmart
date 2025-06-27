import 'dart:async';
import 'package:flutter/material.dart';
import 'package:new_userapp/login/login_page.dart';
import 'package:new_userapp/values/values.dart';

import '../widgets/logo_smartmart.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 800),
          pageBuilder: (context, animation, secondaryAnimation) => const LoginPage(isLogin: true,),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0); // Slide from right to left
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: Curves.easeInOut));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: splashColour,
      body: Stack(
        children: const [
          Center(
            child: SmartMartLogo(size: 200)
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Text.rich(
              TextSpan(
                text: 'Powered by ',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.yellow,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'Roboto', // Or any preferred font for "Powered by"
                ),
                children: [
                  TextSpan(
                    text: 'Sangeeth',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal,
                      fontFamily: 'Pacifico', // A stylish font like script or signature
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),

        ],
      ),
    );
  }
}