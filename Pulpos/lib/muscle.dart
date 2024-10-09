import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'specPatient.dart'; // Import SpecPatientPage

class MusclePage extends StatefulWidget {
  @override
  _MusclePageState createState() => _MusclePageState();
}

class _MusclePageState extends State<MusclePage> {
  final List<String> muscleGroups = [
    "Tout le corps",
    "Cervicales",
    "Épaules",
    "Dos / Posture",
    "Bas du dos",
    "Hanche",
    "Ischio-jambiers",
    "Quadriceps",
  ];

  List<String> selectedMuscles = [];

  void _onMuscleSelected(String muscle) {
    setState(() {
      if (muscle == "Tout le corps") {
        if (selectedMuscles.contains(muscle)) {
          selectedMuscles.clear();
        } else {
          selectedMuscles = [muscle];
        }
      } else {
        if (selectedMuscles.contains("Tout le corps")) {
          return;
        }
        selectedMuscles.contains(muscle)
            ? selectedMuscles.remove(muscle)
            : selectedMuscles.add(muscle);
      }
    });
  }

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
                    value: 0.6,
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
                    'Quelles sont les zones du corps souhaitez-vous privilégier ?',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Sélectionnez toutes les réponse qui s\'appliquent à vous',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: muscleGroups.length,
                itemBuilder: (context, index) {
                  final muscle = muscleGroups[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 4.0),
                    child: GestureDetector(
                      onTap: () => _onMuscleSelected(muscle),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(10),
                          color: selectedMuscles.contains(muscle)
                              ? const Color(0xFF11FD91).withOpacity(0.3)
                              : Colors.transparent,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              muscle,
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            if (selectedMuscles.contains(muscle))
                              Icon(Icons.check, color: const Color(0xFF11FD91)),
                          ],
                        ),
                      ),
                    ),
                  );
                },
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
                    // Log selected muscle groups
                    print('Selected Muscles: ${selectedMuscles.join(', ')}');
                    // Navigate to SpecPatientPage
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SpecPatientPage()),
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
}
