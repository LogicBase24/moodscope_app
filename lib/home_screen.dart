import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:moodscope_app/main.dart';
import 'package:moodscope_app/splash_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    void signout() async {
      try {
        await supabase.auth.signOut();
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Signing out')));
      } catch (error) {
        SnackBar(
          content: const Text('Unexpected error occurred'),
          backgroundColor: Theme.of(context).colorScheme.error,
        );
      } finally {
        if (mounted) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (_) => const SplashScreen(),
          ));
        }
      }
    }

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
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Container(
                margin: const EdgeInsets.only(top: 100),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 37, 219, 43)
                          .withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 30,
                      offset:
                          const Offset(0, -20), // changes position of shadow
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () => signout(),
                  style: const ButtonStyle(
                      shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)))),
                      padding: MaterialStatePropertyAll(EdgeInsets.only(
                          left: 100, right: 100, top: 10, bottom: 10)),
                      backgroundColor: MaterialStatePropertyAll(
                        Color.fromARGB(223, 39, 9, 1),
                      )),
                  child: Row(
                    mainAxisSize: MainAxisSize
                        .min, // set the size of the Row to be as small as possible
                    children: [
                      Image.network(
                          'https://cdn-icons-png.flaticon.com/512/2585/2585161.png?ga=GA1.1.1359017575.1703295671&',
                          height: 24,
                          width:
                              24), // replace with the path to your Google icon
                      const SizedBox(
                          width:
                              10), // add some space between the icon and the text
                      const Text(
                        ('Signout'),
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
              )
            ]).animate().scaleXY(
                  alignment: Alignment.center,
                  begin: 0.0,
                  end: 1.0,
                  delay: const Duration(milliseconds: 2500),
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOutSine,
                ),
          ),
        ],
      ),
    );
  }
}
