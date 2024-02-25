// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'dart:async';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool _showFirstImage = true;

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        _showFirstImage = !_showFirstImage;
      });
      Navigator.pushReplacementNamed(context, '/base');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              Color.fromARGB(255, 18, 6, 184),
            ],
          ),
        ),
        child: Center(
          child: AnimatedCrossFade(
            duration: const Duration(seconds: 1),
            firstChild: Image.asset('assets/logo_A.png'),
            secondChild: Image.asset('assets/logo_B.png'),
            crossFadeState: _showFirstImage
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
          ),
        ),
      ),
    );
  }
}
