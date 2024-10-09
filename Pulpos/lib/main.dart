import 'package:flutter/material.dart';
// Pour afficher les SVG
import 'connexion.dart';// Importez le fichier contenant la page d'accueil

void main() {
  runApp(const MyApp());
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
    // Attendre x secondes avant de passer à la page principale
    Future.delayed(const Duration(seconds: 2), () {
      // Naviguer vers HomePage et remplacer l'écran actuel
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
          '../assets/logoWhite.png', // Chemin vers votre logo SVG
          width: 181, // Largeur ajustée
          height: 60, // Hauteur ajustée
        ),
      ),
    );
  }
}
