import 'package:flutter/material.dart';
import 'dart:async';
import 'HomePage.dart'; // Import HomePage

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // Animation controller for rotating the logo
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat(); // Repeat the animation indefinitely

    // Navigate to HomePage after 2.4 seconds
    Timer(const Duration(milliseconds: 2400), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the animation controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8245E6),
      body: Center(
        child: RotationTransition(
          turns: _controller,
          child: Image.asset(
            '../assets/logopulpos.png', // Replace with the actual logo path
            width: 100,
            height: 100,
          ),
        ),
      ),
    );
  }
}
