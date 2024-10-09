import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Connexion.dart'; // Import ConnexionPage for navigation back to login
import 'introductionPage.dart'; // Import IntroductionPage for navigation

class SubscribePage extends StatefulWidget {
  @override
  _SubscribePageState createState() => _SubscribePageState();
}

class _SubscribePageState extends State<SubscribePage> {
  final TextEditingController _pseudoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false; // For toggling password visibility
  bool _isConfirmPasswordVisible = false; // For toggling confirm password visibility
  String? _errorMessage; // Error message for password mismatch

  void _validatePassword() {
    // Check if password and confirmation match
    if (_passwordController.text != _confirmPasswordController.text) {
      setState(() {
        _errorMessage = 'Le mot de passe et la confirmation ne sont pas identiques';
      });
    } else {
      setState(() {
        _errorMessage = null; // Clear error if they match
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8245E6), // Purple background
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Top logo
            Padding(
              padding: const EdgeInsets.only(top: 32.0),
              child: Image.asset(
                '../assets/logoWhite.png', // Replace with your actual logo path
                width: 120,
                height: 120,
              ),
            ),
            // Form fields and button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Pseudo field
                  TextFormField(
                    controller: _pseudoController,
                    decoration: InputDecoration(
                      labelText: 'Pseudo',
                      labelStyle: const TextStyle(color: Colors.white),
                      hintText: 'Pseudo',
                      hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF11FD91)),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  // Email field
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Adresse mail',
                      labelStyle: const TextStyle(color: Colors.white),
                      hintText: 'Adresse mail',
                      hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF11FD91)),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  // Password field
                  TextFormField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      labelText: 'Mot de passe',
                      labelStyle: const TextStyle(color: Colors.white),
                      hintText: 'Mot de passe',
                      hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF11FD91)),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                    onChanged: (value) => _validatePassword(),
                  ),
                  const SizedBox(height: 16),
                  // Confirm password field
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: !_isConfirmPasswordVisible,
                    decoration: InputDecoration(
                      labelText: 'Confirmation Mot de passe',
                      labelStyle: const TextStyle(color: Colors.white),
                      hintText: 'Confirmation Mot de passe',
                      hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF11FD91)),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                          });
                        },
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                    onChanged: (value) => _validatePassword(),
                  ),
                  const SizedBox(height: 8),
                  // Error message
                  if (_errorMessage != null)
                    Text(
                      _errorMessage!,
                      style: TextStyle(color: Colors.red, fontSize: 14),
                    ),
                  const SizedBox(height: 16),
                  // Subscribe button
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
                      onPressed: () {
                        _validatePassword();
                        if (_errorMessage == null) {
                          // Print the input data to the console
                          print('Pseudo: ${_pseudoController.text}');
                          print('Email: ${_emailController.text}');
                          print('Password: ${_passwordController.text}');

                          // Navigate to the IntroductionPage
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => IntroductionPage(),
                            ),
                          );
                        }
                      },
                      child: Text(
                        "S'inscrire",
                        style: GoogleFonts.roboto(
                          color: const Color(0xFF8245E6),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Already have an account? Sign in
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ConnexionPage(),
                        ),
                      );
                    },
                    child: Text(
                      "Déjà un compte ? Se connecter",
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Bottom logo
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Image.asset(
                '../assets/logopulpos.png', // Replace with your actual logo path
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
