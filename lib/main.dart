import 'package:flutter/material.dart';
import 'package:moodscope_app/splash_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
      anonKey: dotenv.env['SUPABASE_KEY'] ?? '',
      url: dotenv.env['SUPABASE_URL'] ?? '');
  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Moodscope',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
