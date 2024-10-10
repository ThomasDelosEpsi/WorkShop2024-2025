import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pulpos/message.dart';
import 'camera.dart'; // Import the CameraPage
import 'program.dart'; // Import the ProgramDetailPage
import 'profils.dart'; // Import the ProfilsPage
import 'token_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Program> programs = [
    Program(
      title: "Soulager un mal de dos",
      subtitle: "Programme de la semaine",
      rating: 4.8,
      image: "../assets/MalDeDos.png",
      description: "Le mal de dos est l'un des maux les plus répandus...",
      sessions: 6,
    ),
    Program(
      title: "Périostites",
      subtitle: "Programme personnalisé",
      rating: 4.5,
      image: "../assets/MalDeDos.png",
      description: "Ce programme est conçu pour aider à traiter les périostites...",
      sessions: 4,
    ),
  ];

  int _currentIndex = 0;
  int _selectedFilterIndex = 0;
  String _avatarPath = "../assets/logopulpos.png"; // Default avatar

  void _onItemTapped(int index) {
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CameraPage()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MessagePage()),
      );
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfilsPage(
            username: Provider.of<TokenProvider>(context, listen: false).username,
            avatarPath: _avatarPath,
            onAvatarChanged: _updateAvatar,
          ),
        ),
      );
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  void _onFilterTapped(int index) {
    setState(() {
      _selectedFilterIndex = index;
    });
  }

  void _navigateToProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfilsPage(
          username: Provider.of<TokenProvider>(context, listen: false).username,
          avatarPath: _avatarPath,
          onAvatarChanged: _updateAvatar,
        ),
      ),
    );
  }

  void _updateAvatar(String newAvatarPath) {
    setState(() {
      _avatarPath = newAvatarPath;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Retrieve the username from the TokenProvider
    final username = Provider.of<TokenProvider>(context).username;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Hey, $username ",
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const TextSpan(
                          text: "👋",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: _navigateToProfile,
                    child: CircleAvatar(
                      radius: 24,
                      backgroundColor: const Color(0xFF10FD91),
                      backgroundImage: AssetImage(_avatarPath),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Programme populaire",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "filtre",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: FilterButton(
                      label: "+ Vue",
                      isSelected: _selectedFilterIndex == 0,
                      onTap: () => _onFilterTapped(0),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: FilterButton(
                      label: "Rapide",
                      isSelected: _selectedFilterIndex == 1,
                      onTap: () => _onFilterTapped(1),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: FilterButton(
                      label: "Dernier",
                      isSelected: _selectedFilterIndex == 2,
                      onTap: () => _onFilterTapped(2),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                itemCount: programs.length,
                itemBuilder: (context, index) {
                  final program = programs[index];
                  return Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProgramDetailPage(program: program),
                          ),
                        );
                      },
                      child: ProgramCard(program: program),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.camera_alt_outlined), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.message_outlined), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ''),
        ],
      ),
    );
  }
}

// Widget for filter buttons
class FilterButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const FilterButton({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isSelected ? Colors.black : Colors.grey[200],
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

// Program model
class Program {
  final String title;
  final String subtitle;
  final double rating;
  final String image;
  final String description;
  final int sessions;

  Program({
    required this.title,
    required this.subtitle,
    required this.rating,
    required this.image,
    required this.description,
    required this.sessions,
  });
}

// ProgramCard with star and heart functionality
class ProgramCard extends StatefulWidget {
  final Program program;

  const ProgramCard({super.key, required this.program});

  @override
  _ProgramCardState createState() => _ProgramCardState();
}

class _ProgramCardState extends State<ProgramCard> {
  bool isFavorite = false;
  bool isRated = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270,
      margin: const EdgeInsets.only(right: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: AssetImage(widget.program.image),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.program.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.program.subtitle,
                    style: const TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isRated = !isRated;
                          });
                        },
                        child: Icon(
                          isRated ? Icons.star : Icons.star_border,
                          color: isRated ? Colors.yellow : Colors.white,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "${widget.program.rating}",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isFavorite = !isFavorite;
                });
              },
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.white,
                size: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
