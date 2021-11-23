import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DesignCustom extends StatelessWidget {
  const DesignCustom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: DrapClip2(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.8,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                const Color(0xfffce4ec),
                Colors.deepPurpleAccent.shade100
              ], begin: Alignment.bottomCenter, end: Alignment.bottomRight),
            ),
          ),
        ),
        ClipPath(
          clipper: DrapClip(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.79,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                const Color(0xfffce4ec),
                Colors.deepPurpleAccent.shade100
              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            ),
          ),
        ),
      ],
    );
  }
}

class DrapClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.80);
    path.cubicTo(size.width / 4, size.height, 3 * size.width / 4,
        size.height / 2, size.width, size.height * 0.8);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class DrapClip2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.80);
    path.cubicTo(size.width / 4, size.height, 3 * size.width / 4,
        size.height / 2, size.width, size.height * 0.9);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
