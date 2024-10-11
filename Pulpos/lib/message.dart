import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  // Function to pick an image from the gallery
  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Image ajoutée: ${pickedFile.path}')),
      );
    }
  }

  // Function to open camera
  Future<void> _openCamera(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Photo capturée: ${pickedFile.path}')),
      );
    }
  }

  // Function to record audio
  void _recordAudio(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Enregistrement audio commencé')),
    );
    // Implémenter la logique d'enregistrement audio ici
  }

  // Function to pick an emoji (dummy function)
  void _pickEmoji(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Sélecteur d\'emoji ouvert')),
    );
    // Implémenter la logique du sélecteur d'emoji ici
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('../assets/logopulpos.png'),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Cabinet Durand',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'en ligne',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.phone, color: Colors.black),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Appel lancé')),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.videocam, color: Colors.black),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Appel vidéo lancé')),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                _buildMessageBubble(
                  "Bonjour, Gus",
                  DateTime.now().subtract(const Duration(minutes: 5)),
                  isSentByMe: true,
                ),
                _buildMessageBubble(
                  "Bonjour, avez-vous commencé le programme?",
                  DateTime.now().subtract(const Duration(minutes: 4)),
                  isSentByMe: false,
                ),
                _buildMessageBubble(
                  "Je commence maintenant!",
                  DateTime.now().subtract(const Duration(minutes: 3)),
                  isSentByMe: true,
                ),
                _buildMessageBubble(
                  "Super, tenez-moi au courant.",
                  DateTime.now().subtract(const Duration(minutes: 2)),
                  isSentByMe: false,
                ),
              ],
            ),
          ),
          _buildMessageInput(context),
        ],
      ),
    );
  }

  // Helper method to build message bubbles
  Widget _buildMessageBubble(String message, DateTime time, {bool isSentByMe = false}) {
    final formattedTime = "${time.hour}:${time.minute.toString().padLeft(2, '0')}";
    return Align(
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSentByMe ? const Color(0xFF10FD91) : Colors.grey[200],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              message,
              style: TextStyle(color: isSentByMe ? Colors.white : Colors.black),
            ),
            const SizedBox(height: 4),
            Text(
              formattedTime,
              style: TextStyle(color: isSentByMe ? Colors.white70 : Colors.black54, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build the message input field
  Widget _buildMessageInput(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.attach_file, color: Colors.black),
            onPressed: () => _pickImage(context),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'message',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.emoji_emotions_outlined, color: Colors.grey),
                    onPressed: () => _pickEmoji(context),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.camera_alt, color: Colors.black),
            onPressed: () => _openCamera(context),
          ),
          IconButton(
            icon: const Icon(Icons.mic, color: Colors.black),
            onPressed: () => _recordAudio(context),
          ),
        ],
      ),
    );
  }
}
