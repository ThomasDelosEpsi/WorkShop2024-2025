import 'package:flutter/material.dart';

class AvatarCreationPage extends StatefulWidget {
  final ValueChanged<String> onAvatarCreated;

  const AvatarCreationPage({super.key, required this.onAvatarCreated});

  @override
  _AvatarCreationPageState createState() => _AvatarCreationPageState();
}

class _AvatarCreationPageState extends State<AvatarCreationPage> {
  Color _skinColor = Colors.brown; // Default skin color
  Color _hairColor = Colors.black; // Default hair color
  String _accessory = "none"; // Default accessory

  // Method to update skin color
  void _updateSkinColor(Color color) {
    setState(() {
      _skinColor = color;
    });
  }

  // Method to update hair color
  void _updateHairColor(Color color) {
    setState(() {
      _hairColor = color;
    });
  }

  // Method to update accessory
  void _updateAccessory(String accessory) {
    setState(() {
      _accessory = accessory;
    });
  }

  // Method to create the avatar and return the image path
  void _createAvatar() {
    // Here you would normally generate the avatar as an image file and save it
    // For the sake of simplicity, we are just using a placeholder path
    String avatarPath = "path/to/generated/avatar.png";
    widget.onAvatarCreated(avatarPath);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Créer un Avatar"),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Personnalisez votre avatar",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Display the current avatar
            CircleAvatar(
              radius: 50,
              backgroundColor: _skinColor,
              child: Icon(
                Icons.person,
                color: _hairColor,
                size: 40,
              ),
            ),
            const SizedBox(height: 16),
            // Skin color selection
            const Text("Couleur de peau:"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _colorOption(Colors.brown, _updateSkinColor),
                _colorOption(Colors.yellow, _updateSkinColor),
                _colorOption(Colors.pink, _updateSkinColor),
              ],
            ),
            const SizedBox(height: 16),
            // Hair color selection
            const Text("Couleur des cheveux:"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _colorOption(Colors.black, _updateHairColor),
                _colorOption(Colors.brown, _updateHairColor),
                _colorOption(Colors.yellow, _updateHairColor),
              ],
            ),
            const SizedBox(height: 16),
            // Accessory selection
            const Text("Accessoire:"),
            DropdownButton<String>(
              value: _accessory,
              items: <String>['none', 'glasses', 'hat', 'beard']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                _updateAccessory(newValue ?? 'none');
              },
            ),
            const Spacer(),
            // Create button
            ElevatedButton(
              onPressed: _createAvatar,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                "Créer l'avatar",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to create color options
  Widget _colorOption(Color color, Function(Color) onSelect) {
    return GestureDetector(
      onTap: () => onSelect(color),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          border: Border.all(width: 2, color: Colors.grey),
        ),
      ),
    );
  }
}
