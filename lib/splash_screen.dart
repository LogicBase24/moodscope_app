import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:moodscope_app/home_screen.dart';
import 'package:moodscope_app/main.dart';
import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  bool _isLoading = false;
  bool _redirecting = false;
  late final StreamSubscription<AuthState> _authStateSubscription;
  Future<void> _signIn() async {
    try {
      setState(() {
        _isLoading = true;
      });
      await supabase.auth.signInWithOAuth(
        Provider.spotify,
        authScreenLaunchMode: LaunchMode.externalApplication,
        redirectTo: 'app.shervin.live://login-callback/',
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Loading')),
        );
      }
    } on AuthException catch (error) {
      SnackBar(
        content: Text(error.message),
        backgroundColor: Theme.of(context).colorScheme.error,
      );
    } catch (error) {
      SnackBar(
        content: const Text('Unexpected error occurred'),
        backgroundColor: Theme.of(context).colorScheme.error,
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    if (!mounted) {
      return;
    }
    final session = supabase.auth.currentSession;
    if (session != null) {
      Future.delayed(const Duration(milliseconds: 1500), () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        ));
      });
    } else {
      _authStateSubscription = supabase.auth.onAuthStateChange.listen((data) {
        if (_redirecting) return;
        final session = data.session;
        if (session != null) {
          _redirecting = true;
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (_) => const HomeScreen(),
          ));
        }
      });
      super.initState();
    }
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    _authStateSubscription.cancel();
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
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Container(
                margin: const EdgeInsets.only(top: 300),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 30, 185, 35)
                          .withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 30,
                      offset:
                          const Offset(0, -20), // changes position of shadow
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _signIn,
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
                      Text(
                        (_isLoading ? 'Loading' : 'Log in using Spotify'),
                        style: const TextStyle(
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
                  delay: const Duration(milliseconds: 1500),
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOutSine,
                ),
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
                  end: -120,
                  delay: const Duration(milliseconds: 1200),
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOutSine),
        ],
      ),
    );
  }
}
