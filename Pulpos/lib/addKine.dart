import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'loading.dart'; // Import LoadingPage

class AddKinePage extends StatefulWidget {
  @override
  _AddKinePageState createState() => _AddKinePageState();
}

class _AddKinePageState extends State<AddKinePage> {
  final TextEditingController _practitionerController = TextEditingController();

  void _navigateToLoadingPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoadingPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8245E6),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Progress bar at the top
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 0.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: LinearProgressIndicator(
                    value: 0.8,
                    backgroundColor: Colors.white.withOpacity(0.3),
                    valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF11FD91)),
                    minHeight: 6,
                  ),
                ),
              ),
            ),
            // Title and subtitle
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                children: [
                  Text(
                    'Rechercher votre praticien',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Rechercher votre praticien pour lui envoyer une notification de demande d\'ajout',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Search bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.white),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _practitionerController,
                        decoration: InputDecoration(
                          hintText: 'Ajouter votre praticien',
                          hintStyle: GoogleFonts.roboto(color: Colors.grey),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.search, color: Colors.grey),
                      onPressed: () {
                        print('Search practitioner: ${_practitionerController.text}');
                      },
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            // Continue button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: SizedBox(
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
                    print('Practitioner: ${_practitionerController.text}');
                    _navigateToLoadingPage(); // Navigate to LoadingPage
                  },
                  child: Text(
                    'Continuer',
                    style: GoogleFonts.roboto(
                      color: const Color(0xFF8245E6),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Skip option
            TextButton(
              onPressed: _navigateToLoadingPage, // Navigate to LoadingPage
              child: Text(
                'Passer si vous n\'avez pas de praticien',
                style: GoogleFonts.roboto(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ),
            // Bottom logo
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Image.asset(
                '../assets/logoWhite.png', // Replace with the actual logo path
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
