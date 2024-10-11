import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ExercicesIAPage extends StatefulWidget {
  @override
  _ExercicesIAPageState createState() => _ExercicesIAPageState();
}

class _ExercicesIAPageState extends State<ExercicesIAPage> {
  final TextEditingController _controller = TextEditingController();
  String _generatedExercice = '';
  String? _exerciseTitle;

  final String openaiApiKey = '';

  Future<void> _generateExercice(String bodyPart) async {
    if (bodyPart.isEmpty) {
      setState(() {
        _generatedExercice = 'Veuillez sélectionner une partie du corps.';
      });
      return;
    }

    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $openaiApiKey',
      },
      body: jsonEncode({
        'model': 'gpt-3.5-turbo',
        'messages': [
          {'role': 'system', 'content': 'Vous êtes un kinésithérapeute qui donne des conseils en français.'},
          {
            'role': 'user',
            'content': 'Je cherche des exercices d\'étirement ou de kiné pour soulager les douleurs au niveau du $bodyPart. Pouvez-vous m\'aider ?',
          },
        ],
        'max_tokens': 500,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
      final String workoutPlan = data['choices'][0]['message']['content'];

      setState(() {
        _exerciseTitle = 'Exercice pour $bodyPart';
        _generatedExercice = workoutPlan;
      });
    } else {
      setState(() {
        _generatedExercice = 'Erreur lors de la génération des exercices. Code: ${response.statusCode}, Réponse: ${response.body}';
      });
    }
  }

  void _saveAndReturn() {
    if (_exerciseTitle != null && _generatedExercice.isNotEmpty) {
      Navigator.pop(context, {
        'title': _exerciseTitle!,
        'content': _generatedExercice
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Générateur d\'exercices de kiné'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Où avez-vous mal ?',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  _generateExercice(_controller.text);
                } else {
                  setState(() {
                    _generatedExercice = 'Veuillez indiquer l\'endroit où vous avez mal.';
                  });
                }
              },
              child: Text('Générer les exercices'),
            ),
            SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  _generatedExercice,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            if (_generatedExercice.isNotEmpty)
              ElevatedButton(
                onPressed: _saveAndReturn,
                child: Text('Sauvegarder et retourner'),
              ),
          ],
        ),
      ),
    );
  }
}
