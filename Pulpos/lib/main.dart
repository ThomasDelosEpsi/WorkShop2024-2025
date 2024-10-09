import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Pour afficher les SVG
import 'introductionPage.dart'; // Importez le fichier contenant la page d'accueil

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Attendre x secondes avant de passer à la page principale
    Future.delayed(Duration(seconds: 2), () {
      // Naviguer vers HomePage et remplacer l'écran actuel
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => IntroductionPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF8245E6), // Couleur de fond violet
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
