import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gossip/view/homescreen.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Homescreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/splash_pic.jpg', fit: BoxFit.cover,height: height * 0.8),
              SizedBox(height: height * 0.04),
              Text(
                'Top Headlines',
                style: GoogleFonts.anton(letterSpacing: 0.6, color: Colors.indigoAccent, fontSize: 25),
              ),
              SizedBox(height: height * 0.02),
              SpinKitCircle(color: Colors.red, size: 40),
            ],
          ),
        ),
      ),
    );
  }
}
