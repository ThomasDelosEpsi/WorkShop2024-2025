import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart'; // Import the file picker for video upload
import 'token_provider.dart'; // Import the TokenProvider

class AddExercisePage extends StatefulWidget {
  const AddExercisePage({Key? key}) : super(key: key);

  @override
  _AddExercisePageState createState() => _AddExercisePageState();
}

class _AddExercisePageState extends State<AddExercisePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  String? _selectedBodyPart;
  String? _videoFilePath; // Variable to hold the selected video file path

  // Static list of body parts
  final List<Map<String, dynamic>> _bodyParts = [
    {'id': 1, 'name': 'Chest'},
    {'id': 2, 'name': 'Back'},
    {'id': 3, 'name': 'Legs'},
    {'id': 4, 'name': 'Arms'},
    {'id': 5, 'name': 'Shoulders'},
    {'id': 6, 'name': 'Abs'},
    {'id': 7, 'name': 'Glutes'},
    {'id': 8, 'name': 'Calves'},
    {'id': 9, 'name': 'Neck'},
    {'id': 10, 'name': 'Forearms'}
  ];

  // Function to pick a video
  Future<void> _pickVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );

    if (result != null) {
      setState(() {
        _videoFilePath = result.files.single.path; // Store the file path
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Form is valid, handle the submission logic
      final exerciseName = _nameController.text;
      final selectedBodyPart = _selectedBodyPart;
      final videoFile = _videoFilePath;

      // Print values for now, but you can send them to your backend or API
      print('Nom: $exerciseName');
      print('Chemin de la vidéo: $videoFile');
      print('Partie du corps ciblée: $selectedBodyPart');

      // Reset the form after submission if needed
      _formKey.currentState!.reset();
      setState(() {
        _videoFilePath = null; // Reset video file path after form submission
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter un exercice'),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Champ Nom de l'exercice
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nom de l\'exercice',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le nom de l\'exercice';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Champ pour uploader une vidéo
              TextButton(
                onPressed: _pickVideo,
                child: const Text('Uploader une vidéo'),
              ),
              _videoFilePath != null
                  ? Text('Vidéo sélectionnée : $_videoFilePath')
                  : const Text('Aucune vidéo sélectionnée'),
              const SizedBox(height: 16),

              // Liste déroulante pour les parties du corps
              DropdownButtonFormField<String>(
                value: _selectedBodyPart,
                items: _bodyParts.map((bodyPart) {
                  return DropdownMenuItem<String>(
                    value: bodyPart['name'],
                    child: Text(bodyPart['name']),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedBodyPart = value;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Partie du corps ciblée',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez sélectionner une partie du corps';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Bouton soumettre
              SizedBox(
                width: double.infinity,
                 child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8245E6), // Fond violet
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Ajouter l\'exercice',
                      style: TextStyle(
                        color: Colors.white, // Texte en blanc
                        fontWeight: FontWeight.bold, // Texte en gras
                      ),
                    ),
                  )

              ),
            ],
          ),
        ),
      ),
    );
  }
}
