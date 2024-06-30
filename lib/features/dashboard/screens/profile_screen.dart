import 'dart:math';

import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
        child: Column(children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Korty ray",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {},
              )
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text('203'),
                  Text('Following'),
                ],
              ),
              Container(
                width: 120,
                height: 120,
                child: CustomPaint(
                  painter: DiagonalCircleBorderPainter(),
                  child: ClipOval(
                    child: Image.network(
                      'https://images.unsplash.com/photo-1666615435088-4865bf5ed3fd?q=80&w=1471&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  Text('203'),
                  Text('Followers'),
                ],
              ),
            ],
          ),
        ]),
      )),
    );
  }
}

class DiagonalCircleBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    // Define the radius
    final radius = size.width / 2;

    // Right and top arc
    paint.color = Color(0xFFFF004F);
    canvas.drawArc(
      Rect.fromCircle(center: Offset(radius, radius), radius: radius),
      -pi / 4,
      pi,
      false,
      paint,
    );

    // Left and bottom arc
    paint.color = Color(0xFF8010EF);
    canvas.drawArc(
      Rect.fromCircle(center: Offset(radius, radius), radius: radius),
      3 * pi / 4,
      pi,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
