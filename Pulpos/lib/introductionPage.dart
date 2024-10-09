import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'connexion.dart'; // Import du fichier connexion.dart

class IntroductionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF8245E6),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 0.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: LinearProgressIndicator(
                  value: 0.1,
                  backgroundColor: Colors.white.withOpacity(0.3),
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF11FD91)),
                  minHeight: 6,
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
            Spacer(),
            Image.asset(
              '../assets/logopulpos.png',
              width: 100,
              height: 100,
            ),
            SizedBox(height: 24),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Bienvenue chez ',
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'pulpos',
                      style: GoogleFonts.roboto(
                        color: Color(0xFF11FD91),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 16,
                        height: 1.5,
                      ),
                      children: <TextSpan>[
                        TextSpan(text: "L’application de "),
                        TextSpan(
                          text: "Kinésithérapeute ",
                          style: TextStyle(color: Color(0xFF11FD91)),
                        ),
                        TextSpan(text: "pour réduire la douleur et préparer son programme de rééducation "),
                        TextSpan(
                          text: "personnalisé.",
                          style: TextStyle(color: Color(0xFF11FD91)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () {
                    // Naviguer vers la ConnexionPage
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ConnexionPage()),
                    );
                  },
                  child: Text(
                    "Continuer",
                    style: GoogleFonts.roboto(
                      color: Color(0xFF8245E6),
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 24),
            Image.asset(
              '../assets/logoWhite.png',
              width: 100,
              height: 100,
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
