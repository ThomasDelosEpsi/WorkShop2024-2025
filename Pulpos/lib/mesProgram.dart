import 'package:flutter/material.dart';

class MesProgrammesPage extends StatelessWidget {
  final List<Map<String, String>> programs;

  MesProgrammesPage({required this.programs});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mes Programmes'),
      ),
      body: ListView.builder(
        itemCount: programs.length,
        itemBuilder: (context, index) {
          final program = programs[index];
          return ListTile(
            title: Text(program['title'] ?? 'Programme sans titre'),
            subtitle: Text(
              program['content'] ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailProgrammePage(program: program),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DetailProgrammePage extends StatelessWidget {
  final Map<String, String> program;

  DetailProgrammePage({required this.program});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(program['title'] ?? 'Détails du Programme'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(program['content'] ?? 'Aucun contenu disponible.'),
      ),
    );
  }
}
