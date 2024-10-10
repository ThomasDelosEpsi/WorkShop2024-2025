import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'AvatarCreationPage.dart'; // Import the AvatarCreationPage

class ProfilsPage extends StatelessWidget {
  final String username;
  final String avatarPath;
  final ValueChanged<String> onAvatarChanged;

  const ProfilsPage({
    super.key,
    required this.username,
    required this.avatarPath,
    required this.onAvatarChanged,
  });

  // Function to change the avatar
  Future<void> _changeAvatar(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choisir depuis la galerie'),
              onTap: () async {
                Navigator.pop(context);
                final picker = ImagePicker();
                final pickedFile = await picker.pickImage(source: ImageSource.gallery);

                if (pickedFile != null) {
                  onAvatarChanged(pickedFile.path);
                  Navigator.pop(context);
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.create),
              title: const Text('Créer un avatar personnalisé'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AvatarCreationPage(
                      onAvatarCreated: (newAvatarPath) {
                        onAvatarChanged(newAvatarPath);
                      },
                    ),
                  ),
                );
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            const Text(
              "Mon profil",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              "🦑",
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black),
            onPressed: () {
              // Settings action
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () => _changeAvatar(context),
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: const Color(0xFF10FD91),
                  backgroundImage: AssetImage(avatarPath),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                username,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    _buildProfileInfoRow("Votre santé", "À compléter"),
                    _buildProfileInfoRow("Zone de douleur", "Aucune"),
                    const SizedBox(height: 16),
                    _buildProfileStatsRow("Programmes en cours", "2"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget to build profile information rows
  Widget _buildProfileInfoRow(String title, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget to build profile statistics rows
  Widget _buildProfileStatsRow(String title, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
