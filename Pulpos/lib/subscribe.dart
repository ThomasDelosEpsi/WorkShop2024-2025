import 'dart:convert'; // Pour la manipulation JSON
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http; // Importer http pour faire des requêtes
import 'Connexion.dart'; // Import ConnexionPage for navigation back to login

class SubscribePage extends StatefulWidget {
  @override
  _SubscribePageState createState() => _SubscribePageState();
}

class _SubscribePageState extends State<SubscribePage> {
  final TextEditingController _pseudoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false; // Pour basculer la visibilité du mot de passe
  bool _isConfirmPasswordVisible = false; // Pour basculer la visibilité de la confirmation du mot de passe
  String? _errorMessage; // Message d'erreur pour le non-correspondance des mots de passe
  bool _isTermsAccepted = false; // Variable pour suivre l'acceptation des termes

  void _validatePassword() {
    // Vérifier si le mot de passe et la confirmation correspondent
    if (_passwordController.text != _confirmPasswordController.text) {
      setState(() {
        _errorMessage = 'Le mot de passe et la confirmation ne sont pas identiques';
      });
    } else {
      setState(() {
        _errorMessage = null; // Effacer l'erreur si les mots de passe correspondent
      });
    }
  }

  Future<void> _register() async {
    if (_errorMessage != null || !_isTermsAccepted) return; // Si un message d'erreur est présent ou si les termes ne sont pas acceptés, ne pas continuer

    final response = await http.post(
      Uri.parse('http://localhost:8080/api/auth/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'username': _pseudoController.text,
        'email': _emailController.text,
        'password': _passwordController.text,
        'role': ["ROLE_USER"]
      }),
    );

    if (response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ConnexionPage(),
        ),
      );
    } else {
      // Si l'inscription a échoué, afficher un message d'erreur
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      setState(() {
        _errorMessage = responseData['message'] ?? 'Une erreur est survenue';
      });
    }
  }

  // Méthode pour afficher le pop-up avec les conditions d'utilisation
  void _showTermsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Conditions Générales d'Utilisation"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const Text("Voici les conditions générales d'utilisation concernant la collecte et le traitement de vos données :"),
                const SizedBox(height: 16),
                DataTable(
                  columns: const [
                    DataColumn(label: Text('Type de données')),
                    DataColumn(label: Text('Détails collectés')),
                    DataColumn(label: Text('Méthode de stockage')),
                    DataColumn(label: Text('Sécurisation')),
                    DataColumn(label: Text('Durée de conservation')),
                  ],
                  rows: const [
                    DataRow(cells: [
                      DataCell(Text('Données personnelles')),
                      DataCell(Text('')),
                      DataCell(Text('')),
                      DataCell(Text('')),
                      DataCell(Text('')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Nom et prénom')),
                      DataCell(Text('Informations de base du profil utilisateur')),
                      DataCell(Text('Stockées sur des serveurs sécurisés')),
                      DataCell(Text('Chiffrement (au repos et en transit via HTTPS)')),
                      DataCell(Text('Jusqu\'à la suppression du compte ou après 2 ans d\'inactivité')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Adresse e-mail')),
                      DataCell(Text('Utilisée pour l’identification et la communication')),
                      DataCell(Text('Stockées sur des serveurs sécurisés')),
                      DataCell(Text('Chiffrement')),
                      DataCell(Text('Jusqu\'à la suppression du compte ou après 2 ans d\'inactivité')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Numéro de téléphone')),
                      DataCell(Text('Facultatif, pour les notifications')),
                      DataCell(Text('Stockées sur des serveurs sécurisés')),
                      DataCell(Text('Chiffrement')),
                      DataCell(Text('Jusqu\'à la suppression du compte ou après 2 ans d\'inactivité')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Mot de passe')),
                      DataCell(Text('Authentification des utilisateurs')),
                      DataCell(Text('Stocké sous forme hachée')),
                      DataCell(Text('Hachage sécurisé (bcrypt)')),
                      DataCell(Text('Tant que le compte est actif')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Données de santé')),
                      DataCell(Text('')),
                      DataCell(Text('')),
                      DataCell(Text('')),
                      DataCell(Text('')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Antécédents médicaux')),
                      DataCell(Text('Pathologies, maladies chroniques, etc.')),
                      DataCell(Text('Stockées sur des serveurs sécurisés')),
                      DataCell(Text('Chiffrement, accès uniquement pour les praticiens')),
                      DataCell(Text('Jusqu\'à la suppression du compte ou après 2 ans d\'inactivité')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Symptômes')),
                      DataCell(Text('Douleurs, intensité, localisation, durée')),
                      DataCell(Text('Stockées sur des serveurs sécurisés')),
                      DataCell(Text('Chiffrement, accès restreint aux praticiens')),
                      DataCell(Text('Jusqu\'à la suppression du compte ou après 2 ans d\'inactivité')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Programme de rééducation')),
                      DataCell(Text('Programme d’exercices personnalisé généré par l’IA')),
                      DataCell(Text('Stockées sur des serveurs sécurisés')),
                      DataCell(Text('Chiffrement, accès pour praticiens et patients')),
                      DataCell(Text('Jusqu\'à la suppression du compte ou après 2 ans d\'inactivité')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Historique des consultations')),
                      DataCell(Text('Notes et rapports des consultations')),
                      DataCell(Text('Stockées sur des serveurs sécurisés')),
                      DataCell(Text('Chiffrement, accès restreint aux praticiens')),
                      DataCell(Text('Jusqu\'à la suppression du compte ou après 2 ans d\'inactivité')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Messages privés')),
                      DataCell(Text('Échanges entre les patients et les praticiens')),
                      DataCell(Text('Stockés sur des serveurs sécurisés')),
                      DataCell(Text('Chiffrement, accès restreint aux participants')),
                      DataCell(Text('Jusqu\'à la suppression du compte ou après 2 ans d\'inactivité')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Données d\'usage')),
                      DataCell(Text('')),
                      DataCell(Text('')),
                      DataCell(Text('')),
                      DataCell(Text('')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Type d’appareil')),
                      DataCell(Text('Modèle de téléphone, version de l’OS (iOS, Android)')),
                      DataCell(Text('Stockées sur des serveurs sécurisés')),
                      DataCell(Text('Anonymisation si non nécessaire')),
                      DataCell(Text('2 ans après l\'inactivité de l\'utilisateur')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Données d\'actions')),
                      DataCell(Text('Actions dans l’application (ex. progression des exercices)')),
                      DataCell(Text('Stockées sur des serveurs sécurisés')),
                      DataCell(Text('Anonymisation pour analyse statistique')),
                      DataCell(Text('2 ans après l\'inactivité de l\'utilisateur')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Données de paiement')),
                      DataCell(Text('')),
                      DataCell(Text('')),
                      DataCell(Text('')),
                      DataCell(Text('')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Abonnement (via Stripe)')),
                      DataCell(Text('Type d’abonnement choisi, statut de paiement')),
                      DataCell(Text('Stockées par Stripe (référence sur vos serveurs)')),
                      DataCell(Text('Stripe conforme à la norme PCI-DSS (chiffrement, gestion de la sécurité)')),
                      DataCell(Text('Tant que l’abonnement est actif ou selon les obligations légales (10 ans pour les factures en France)')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Informations de carte bancaire')),
                      DataCell(Text('Numéro de carte, date d\'expiration, code CVV')),
                      DataCell(Text('Non stockées directement par l\'application (gérées par Stripe)')),
                      DataCell(Text('Stripe conforme à PCI-DSS (chiffrement)')),
                      DataCell(Text('Non applicable (géré par Stripe uniquement)')),
                    ]),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  "Nous avons besoin de ces données pour plusieurs raisons :\n"
                      "- Fournir un service personnalisé et adapté à vos besoins.\n"
                      "- Assurer la sécurité de votre compte et de vos informations.\n"
                      "- Faciliter la communication et l'identification de votre compte.\n"
                      "- Analyser et améliorer nos services en fonction de votre utilisation.\n"
                      "- Respecter nos obligations légales et réglementaires.\n"
                      "Votre confiance est essentielle, et nous nous engageons à protéger vos informations personnelles.",
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Fermer'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8245E6), // Fond violet
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Logo en haut
            Padding(
              padding: const EdgeInsets.only(top: 32.0),
              child: Image.asset(
                '../assets/logoWhite.png', // Remplacez par votre chemin d'accès au logo
                width: 120,
                height: 120,
              ),
            ),
            // Champs du formulaire et bouton
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Champ pseudo
                  TextFormField(
                    controller: _pseudoController,
                    decoration: InputDecoration(
                      labelText: 'Pseudo',
                      labelStyle: const TextStyle(color: Colors.white),
                      hintText: 'Pseudo',
                      hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF11FD91)),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  // Champ email
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Adresse mail',
                      labelStyle: const TextStyle(color: Colors.white),
                      hintText: 'Adresse mail',
                      hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF11FD91)),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  // Champ mot de passe
                  TextFormField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      labelText: 'Mot de passe',
                      labelStyle: const TextStyle(color: Colors.white),
                      hintText: 'Mot de passe',
                      hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF11FD91)),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                    onChanged: (value) => _validatePassword(),
                  ),
                  const SizedBox(height: 16),
                  // Champ de confirmation de mot de passe
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: !_isConfirmPasswordVisible,
                    decoration: InputDecoration(
                      labelText: 'Confirmation Mot de passe',
                      labelStyle: const TextStyle(color: Colors.white),
                      hintText: 'Confirmation Mot de passe',
                      hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF11FD91)),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                          });
                        },
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                    onChanged: (value) => _validatePassword(),
                  ),
                  const SizedBox(height: 8),
                  // Message d'erreur
                  if (_errorMessage != null)
                    Text(
                      _errorMessage!,
                      style: TextStyle(color: Colors.red, fontSize: 14),
                    ),
                  const SizedBox(height: 16),
                  // Case à cocher pour accepter les conditions d'utilisation
                  Row(
                    children: [
                      Checkbox(
                        value: _isTermsAccepted,
                        onChanged: (value) {
                          setState(() {
                            _isTermsAccepted = value!;
                          });
                        },
                      ),
                      GestureDetector(
                        onTap: _showTermsDialog,
                        child: Text(
                          "J'accepte les conditions générales d'utilisation",
                          style: TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Bouton d'inscription
                  SizedBox(
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
                        _validatePassword();
                        _register(); // Appel de la méthode pour enregistrer l'utilisateur
                      },
                      child: Text(
                        "S'inscrire",
                        style: GoogleFonts.roboto(
                          color: const Color(0xFF8245E6),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Déjà un compte ? Se connecter
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ConnexionPage(),
                        ),
                      );
                    },
                    child: Text(
                      "Déjà un compte ? Se connecter",
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Logo en bas
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Image.asset(
                '../assets/logopulpos.png', // Remplacez par votre chemin d'accès au logo
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
