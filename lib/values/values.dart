import 'dart:ui';

double appBarHeight (double screenHeight,double val){
  double tHeight = screenHeight * val; // % of screen height
  double finalHeight = tHeight.clamp(100.0, 150.0);
  return finalHeight;
}

Color headingColour = const Color(0xFFAD3C1F);
Color buttonColour = const Color(0xFF7C4336);
Color splashColour = const Color(0xFFF3A596);
Color bgColour = const Color(0xFFF1BCB1);
Color tileColour = const Color(0xFFF3E8E8);
Color appBarColour = const Color(0xFF5E342A);