import 'dart:async';

import 'package:flutter/material.dart';

import 'home_page.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4),
          ()=>Navigator.pushReplacement(context,
        MaterialPageRoute(builder:
            (context) =>  HomePage(),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Indian_Army.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
