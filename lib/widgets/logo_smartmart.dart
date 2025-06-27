import 'package:flutter/material.dart';

class SmartMartLogo extends StatelessWidget {
  final double size;
  const SmartMartLogo({this.size = 80, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset('assets/new.png', width: size, height: size),
      ],
    );
  }
}