import 'dart:math';

import 'package:flutter/material.dart';

class HexagonalShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double corner = size.height / (3.8);
    Path path = Path()..moveTo(0, corner);
    // path.lineTo(corner, 0);
    path.quadraticBezierTo(corner, corner, corner, 0);
    path.lineTo(size.width - corner, 0);
    // path.lineTo(size.width, corner);
    path.quadraticBezierTo(size.width - corner, corner , size.width, corner);
    path.lineTo(size.width, size.height - corner);
    // path.lineTo(size.width - corner, size.height);
    path.quadraticBezierTo(size.width - corner, size.height - corner , size.width - corner, size.height);

    path.lineTo(corner, size.height);
    // path.lineTo(0, size.height - corner);
    path.quadraticBezierTo(corner, size.height - corner, 0, size.height - corner, );
    path.lineTo(0, corner);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}