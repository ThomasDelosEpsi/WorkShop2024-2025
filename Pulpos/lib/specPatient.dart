import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'addKine.dart'; // Import AddKinePage

class SpecPatientPage extends StatefulWidget {
  @override
  _SpecPatientPageState createState() => _SpecPatientPageState();
}

class _SpecPatientPageState extends State<SpecPatientPage> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  int selectedGenderIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8245E6),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 0.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: LinearProgressIndicator(
                    value: 0.7,
                    backgroundColor: Colors.white.withOpacity(0.3),
                    valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF11FD91)),
                    minHeight: 6,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                children: [
                  Text(
                    'Information complémentaire',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Rentrer les informations nécessaires pour la création de votre programme :',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildInputField('Votre taille:', _heightController, 'cm'),
                  const SizedBox(height: 16),
                  _buildInputField('Votre poids:', _weightController, 'kg'),
                  const SizedBox(height: 24),
                  _buildGenderSelection(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () {
                    print('Height: ${_heightController.text}');
                    print('Weight: ${_weightController.text}');
                    print('Selected Gender Index: $selectedGenderIndex');
                    // Navigate to AddKinePage
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddKinePage()),
                    );
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

  Widget _buildInputField(String label, TextEditingController controller, String suffix) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: GoogleFonts.roboto(color: Colors.white, fontSize: 16),
        ),
        const SizedBox(width: 8),
        Container(
          width: 100,
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          suffix,
          style: GoogleFonts.roboto(color: Colors.white, fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildGenderSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Vous êtes :',
          style: GoogleFonts.roboto(color: Colors.white, fontSize: 16),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) {
            final icons = [Icons.female, Icons.male, Icons.transgender];
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedGenderIndex = index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Icon(
                  icons[index],
                  color: selectedGenderIndex == index ? Colors.green : Colors.white,
                  size: 30,
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
