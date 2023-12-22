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
                  Color.fromARGB(255, 129, 67, 128), // start color
                  Color.fromARGB(255, 29, 17, 1), // end color
                ],
                stops: [0.0, 0.3],
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
          Center(
                  child: Container(
            margin: const EdgeInsets.only(top: 400),
            child: ElevatedButton(
              onPressed: () {
                print("pressed");
              },
              style: const ButtonStyle(
                  shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)))),
                  padding: MaterialStatePropertyAll(EdgeInsets.only(
                      left: 100, right: 100, top: 10, bottom: 10)),
                  backgroundColor: MaterialStatePropertyAll(
                    Color.fromARGB(226, 254, 144, 10),
                  )),
              child: Row(
                mainAxisSize: MainAxisSize
                    .min, // set the size of the Row to be as small as possible
                children: [
                  Image.asset('assets/google.png',
                      height: 24,
                      width: 24), // replace with the path to your Google icon
                  const SizedBox(
                      width:
                          10), // add some space between the icon and the text
                  const Text(
                    'Log in with Google',
                    style: TextStyle(
                      fontFamily: 'Calibri',
                      fontSize: 18,
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          )).animate().scaleXY(
                alignment: Alignment.center,
                begin: 0.0,
                end: 1.0,
                delay: const Duration(milliseconds: 2500),
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOutSine,
              ),
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
                  end: -100,
                  delay: const Duration(milliseconds: 1200),
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOutSine),
        ],
      ),
    );
  }
}
