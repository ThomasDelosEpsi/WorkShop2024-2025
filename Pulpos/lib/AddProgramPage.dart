import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart'; // Import pour l'upload de fichiers
import 'token_provider.dart'; // Import du TokenProvider

class AddProgramPage extends StatefulWidget {
  const AddProgramPage({Key? key}) : super(key: key);

  @override
  _AddProgramPageState createState() => _AddProgramPageState();
}

class _AddProgramPageState extends State<AddProgramPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  List<String> _selectedExercises = []; // Liste pour stocker les exercices sélectionnés

  // Exemple de liste d'exercices (normalement, vous pouvez les récupérer à partir d'une API ou d'une base de données)
  final List<Map<String, String>> _exercises = [
    {
      'name': 'Squat',
      'description': 'Un excellent exercice pour les jambes et les fessiers.',
    },
    {
      'name': 'Pompes',
      'description': 'Renforcez vos bras et votre poitrine avec cet exercice classique.',
    },
    {
      'name': 'Burpees',
      'description': 'Un exercice complet pour travailler tout le corps.',
    },
    // Ajoutez d'autres exercices ici...
  ];

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Formulaire valide, gérer la logique de soumission
      final programName = _nameController.text;

      // Imprimer les valeurs pour le moment, mais vous pouvez les envoyer à votre backend ou API
      print('Nom du programme: $programName');
      print('Exercices sélectionnés: $_selectedExercises');

      // Réinitialiser le formulaire après la soumission
      _formKey.currentState!.reset();
      setState(() {
        _selectedExercises.clear(); // Réinitialiser les exercices sélectionnés après la soumission
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter un programme'),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Champ Nom du programme
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nom du programme',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le nom du programme';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Liste des exercices
              Expanded(
                child: ListView.builder(
                  itemCount: _exercises.length,
                  itemBuilder: (context, index) {
                    final exercise = _exercises[index];
                    return CheckboxListTile(
                      title: Text(exercise['name']!),
                      subtitle: Text(exercise['description']!),
                      value: _selectedExercises.contains(exercise['name']),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value == true) {
                            _selectedExercises.add(exercise['name']!);
                          } else {
                            _selectedExercises.remove(exercise['name']!);
                          }
                        });
                      },
                    );
                  },
                ),
              ),

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
                    'Créer le programme',
                    style: TextStyle(
                      color: Colors.white, // Texte en blanc
                      fontWeight: FontWeight.bold, // Texte en gras
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
