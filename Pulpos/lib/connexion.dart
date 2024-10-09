import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http; // Importation de la bibliothèque http
import 'dart:convert'; // Importation pour décoder le JSON
import 'HomePage.dart'; // Assurez-vous que le chemin d'importation est correct

class ConnexionPage extends StatefulWidget {
  const ConnexionPage({super.key});

  @override
  _ConnexionPageState createState() => _ConnexionPageState();
}

class _ConnexionPageState extends State<ConnexionPage> {
  bool _isPasswordVisible = false; // Etat initial de visibilité du mot de passe
  final TextEditingController _emailController = TextEditingController(); // Contrôleur pour l'adresse e-mail
  final TextEditingController _passwordController = TextEditingController(); // Contrôleur pour le mot de passe

  @override
  void dispose() {
    // Libérer les contrôleurs lorsque la page est supprimée
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    // Récupérer les valeurs des champs
    String email = _emailController.text;
    String password = _passwordController.text;

    // L'URL de l'API
    final url = Uri.parse('http://localhost:8080/api/auth/signin');

    // Effectuer la requête POST
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': email, // Utilisez 'username' ou 'email' selon votre API
          'password': password,
        }),
      );

      // Vérifier le statut de la réponse
      if (response.statusCode == 200) {
        // Connexion réussie
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(), // Naviguer vers HomePage
          ),
        );
      } else {
        // Gérer les erreurs de connexion
        final responseBody = json.decode(response.body);
        _showErrorDialog(responseBody['message'] ?? 'Erreur inconnue'); // Afficher un message d'erreur
      }
    } catch (error) {
      // Gérer les exceptions
      _showErrorDialog('Erreur de connexion : $error');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Erreur'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8245E6), // Couleur de fond violet
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Logo en haut de page
            Padding(
              padding: const EdgeInsets.only(top: 32.0),
              child: Image.asset(
                '../assets/logoWhite.png',
                width: 120,
                height: 120,
              ),
            ),
            // Centre de la page avec champs de texte et bouton
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Champ d'adresse mail
                  TextFormField(
                    controller: _emailController, // Ajout du contrôleur
                    decoration: InputDecoration(
                      labelText: 'Adresse mail',
                      labelStyle: const TextStyle(color: Colors.white),
                      hintText: 'Adresse mail',
                      hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF11FD91)),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF11FD91)),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 16),

                  // Champ de mot de passe avec l'icône de visibilité
                  TextFormField(
                    controller: _passwordController, // Ajout du contrôleur
                    obscureText: !_isPasswordVisible, // Masquer ou afficher le texte
                    decoration: InputDecoration(
                      labelText: 'Mot de passe',
                      labelStyle: const TextStyle(color: Colors.white),
                      hintText: 'Mot de passe',
                      hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF11FD91)),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF11FD91)),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible; // Inverser l'état
                          });
                        },
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 24),

                  // Bouton Connexion
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: _login, // Appeler la fonction de connexion
                      child: Text(
                        "Connexion", // Changement du texte ici
                        style: GoogleFonts.roboto(
                          color: const Color(0xFF8245E6),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Texte de bas de page avec lien
                  TextButton(
                    onPressed: () {
                      // Action pour aller à la page d'inscription
                    },
                    child: Text(
                      "Je n'ai pas de compte ? Je m'inscris", // Changement du texte ici
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Logo en bas de page
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Image.asset(
                '../assets/logoWhite.png',
                width: 80,
                height: 80,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
