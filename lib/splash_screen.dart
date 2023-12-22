import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:moodscope_app/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    if (false) {
      Future.delayed(const Duration(milliseconds: 1500), () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        ));
      });
    }
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Make the background transparent
      // Add a Container with a gradient background
      body: Stack(
        children: <Widget>[
          // Background
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.bottomCenter, // near the top right
                radius: 3,
                // radius of the gradient
                colors: [
                  Color.fromARGB(255, 36, 62, 97), // start color
                  Color.fromARGB(255, 16, 16, 16), // end color
                ],
                stops: [0.0, 0.4],
                // Adjust the stops values
              ),
            ),
          ),
          // Blur effect
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              color: const Color.fromRGBO(31, 31, 31, 1).withOpacity(0.3),
            ),
          ),
          // Image
          const Center(
            child: Image(
              image: AssetImage('assets/logo.png'),
            ),
          )
              .animate()
              .scaleXY(
                alignment: Alignment.center,
                begin: 0.0,
                end: 1.0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOutSine,
              )
              .rotate(
                begin: 0.0,
                end: 1.0,
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeInOutSine,
              )
              .moveY(
                  begin: 0,
                  end: -150,
                  delay: const Duration(milliseconds: 1200),
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOutSine),

          const Center(
                  child: Text('Moodscope',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 30,
                        color: Color.fromARGB(255, 246, 160, 22),
                        fontWeight: FontWeight.w700,
                      )))
              .animate()
              .moveY(
                  begin: 0,
                  end: 150,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOutSine)
              .scaleXY(
                alignment: Alignment.center,
                begin: 0.0,
                end: 1.0,
                delay: const Duration(milliseconds: 3000),
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOutSine,
              ),
        ],
      ),
    );
  }
}
