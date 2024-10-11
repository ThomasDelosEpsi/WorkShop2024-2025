import 'package:flutter/material.dart';
import 'package:pulpos/AddProgramPage.dart';

class ProgramPage extends StatefulWidget {
  const ProgramPage({Key? key}) : super(key: key);

  @override
  _ProgramPageState createState() => _ProgramPageState();
}

class _ProgramPageState extends State<ProgramPage> {
  final List<Map<String, String>> programs = [
    {
      "title": "Rééducation du dos",
      "description": "Un programme ciblé pour renforcer le dos et améliorer la posture.",
      "image": "../assets/dos.png", // Assurez-vous que le chemin de l'image est correct
    },
    {
      "title": "Rééducation du genou",
      "description": "Exercices pour renforcer les muscles autour du genou et améliorer la mobilité.",
      "image": "../assets/genou.png",
    },
    {
      "title": "Rééducation des épaules",
      "description": "Un programme pour améliorer la flexibilité et la force des épaules.",
      "image": "../assets/epaule.png",
    },
  ];

  String _searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final filteredPrograms = programs.where((program) {
      final title = program["title"]!.toLowerCase();
      return title.contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Programmes de Rééducation'),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input de recherche et boutons "Filtrer", "Créer un programme", et "IA"
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
                      hintText: 'Rechercher un programme',
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
                      fontWeight: FontWeight.bold, // Texte en gras
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AddProgramPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8245E6), // Fond violet
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    "Créer un programme",
                    style: TextStyle(
                      color: Colors.white, // Texte en blanc
                      fontWeight: FontWeight.bold, // Texte en gras
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    // Action pour le bouton IA
                    // Ici, vous pouvez ajouter la logique pour ce bouton
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF50), // Fond vert
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    "IA",
                    style: TextStyle(
                      color: Colors.white, // Texte en blanc
                      fontWeight: FontWeight.bold, // Texte en gras
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Liste des programmes de rééducation
            Expanded(
              child: ListView.builder(
                itemCount: filteredPrograms.length,
                itemBuilder: (context, index) {
                  final program = filteredPrograms[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: ListTile(
                      leading: Image.asset(
                        program['image']!,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(program['title']!,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(program['description']!),
                      onTap: () {
                        // Action lorsque l'utilisateur clique sur un programme
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
