
import 'package:flutter/material.dart';

class BottomNavBarDesign extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()..moveTo(0, 0);
path.lineTo(size.width / 2 - 50, 0);
    path.quadraticBezierTo(size.width/ 2 - 40, 0 , size.width / 2 - 38, 10);
    path.arcToPoint(Offset(size.width*0.6, 10), radius: Radius.circular(39),clockwise: false);
    path.quadraticBezierTo(size.width* 0.6, 0, size.width*0.6 + 16, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}