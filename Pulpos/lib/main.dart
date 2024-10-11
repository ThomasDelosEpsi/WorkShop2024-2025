import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'connexion.dart'; // Importez le fichier contenant la page de connexion
import 'token_provider.dart'; // Importez le fichier du TokenProvider

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TokenProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Attendre 2 secondes avant de passer à la page de connexion
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ConnexionPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8245E6), // Couleur de fond violet
      body: Center(
        child: Image.asset(
          '../assets/logoWhite.png', // Chemin vers votre logo
          width: 181, // Largeur ajustée
          height: 60, // Hauteur ajustée
        ),
      ),
    );
  }
}
