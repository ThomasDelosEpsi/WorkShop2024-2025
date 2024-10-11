import 'package:flutter/material.dart';
import 'package:pulpos/AddExercisePage.dart';

class ExercisePage extends StatefulWidget {
  const ExercisePage({Key? key}) : super(key: key);

  @override
  _ExercisePageState createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  final List<Map<String, String>> exercises = [
    {
      "title": "Squat",
      "description": "Un excellent exercice pour les jambes et les fessiers.",
      "image": "../assets/squat.png",
    },
    {
      "title": "Pompes",
      "description": "Renforcez vos bras et votre poitrine avec cet exercice classique.",
      "image": "../assets/pushup.png",
    },
    {
      "title": "Burpees",
      "description": "Un exercice complet pour travailler tout le corps.",
      "image": "../assets/burpees.png",
    },
  ];

  String _searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final filteredExercises = exercises.where((exercise) {
      final title = exercise["title"]!.toLowerCase();
      return title.contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercices'),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input de recherche et boutons "Filter" et "Ajouter un exercice"
            Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Rechercher un exercice',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    // Action pour le bouton Filtrer
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Fond blanc
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    "Filtrer",
                    style: TextStyle(
                      color: Color(0xFF8245E6), // Texte en violet
                      fontWeight: FontWeight.bold, // Facultatif : pour un texte en gras
                    ),
                  ),
                ),

                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AddExercisePage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8245E6), // Fond violet
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    "Ajouter",
                    style: TextStyle(
                      color: Colors.white, // Texte en blanc
                      fontWeight: FontWeight.bold, // Facultatif : pour un texte en gras
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),

            // Liste des exercices
            Expanded(
              child: ListView.builder(
                itemCount: filteredExercises.length,
                itemBuilder: (context, index) {
                  final exercise = filteredExercises[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: ListTile(
                      leading: Image.asset(
                        exercise['image']!,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(exercise['title']!,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(exercise['description']!),
                      onTap: () {
                        // Action lorsque l'utilisateur clique sur un exercice
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
