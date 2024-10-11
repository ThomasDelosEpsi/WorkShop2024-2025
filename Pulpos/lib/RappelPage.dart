import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'muscle.dart'; // Import MusclePage

class RappelPage extends StatefulWidget {
  @override
  _RappelPageState createState() => _RappelPageState();
}

class _RappelPageState extends State<RappelPage> {
  int selectedHour = 19;
  int selectedMinute = 30;

  List<int> hours = List.generate(24, (index) => index);
  List<int> minutes = List.generate(60, (index) => index);

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
                    value: 0.3,
                    backgroundColor: Colors.white.withOpacity(0.3),
                    valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF11FD91)),
                    minHeight: 6,
                  ),
                ),
              ),
            ),
            // Title and Subtitle
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                children: [
                  Text(
                    'Réglez votre rappel quotidien pour faire vos exercices',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Choisissez une heure ci-dessous',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            // Time Picker using CupertinoPicker
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Hour picker
                  Expanded(
                    child: CupertinoPicker(
                      backgroundColor: const Color(0xFF8245E6),
                      itemExtent: 40,
                      scrollController:
                      FixedExtentScrollController(initialItem: selectedHour),
                      onSelectedItemChanged: (int index) {
                        setState(() {
                          selectedHour = hours[index];
                        });
                      },
                      children: hours
                          .map((hour) => Center(
                        child: Text(
                          hour.toString().padLeft(2, '0'),
                          style: TextStyle(
                            color: hour == selectedHour ? Colors.white : Colors.white70,
                            fontSize: hour == selectedHour ? 24 : 18,
                          ),
                        ),
                      ))
                          .toList(),
                    ),
                  ),
                  // Separator
                  Text(
                    ':',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  // Minute picker
                  Expanded(
                    child: CupertinoPicker(
                      backgroundColor: const Color(0xFF8245E6),
                      itemExtent: 40,
                      scrollController:
                      FixedExtentScrollController(initialItem: selectedMinute),
                      onSelectedItemChanged: (int index) {
                        setState(() {
                          selectedMinute = minutes[index];
                        });
                      },
                      children: minutes
                          .map((minute) => Center(
                        child: Text(
                          minute.toString().padLeft(2, '0'),
                          style: TextStyle(
                            color: minute == selectedMinute ? Colors.white : Colors.white70,
                            fontSize: minute == selectedMinute ? 24 : 18,
                          ),
                        ),
                      ))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
            // Continue Button
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
                    // Log the selected time
                    final selectedTime =
                        '${selectedHour.toString().padLeft(2, '0')}:${selectedMinute.toString().padLeft(2, '0')}';
                    print('Selected Time: $selectedTime');

                    // Navigate to MusclePage
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MusclePage()),
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
            // Bottom Text
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Image.asset(
                '../assets/logoWhite.png', // Path to your logo image
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
