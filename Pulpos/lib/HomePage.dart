import 'package:flutter/material.dart';
import 'camera.dart'; // Import the CameraPage
import 'program.dart'; // Import the ProgramDetailPage

class HomePage extends StatefulWidget {
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
      description: "Le mal de dos est l'un des maux les plus répandus, touchant des millions de personnes au quotidien. Que vous souffriez de douleurs chroniques ou passagères, notre programme en 6 séances est conçu pour vous aider à soulager et prévenir les douleurs.",
      sessions: 6,
    ),
    Program(
      title: "Périostites",
      subtitle: "Programme personnalisé",
      rating: 4.5,
      image: "../assets/MalDeDos.png",
      description: "Ce programme est conçu pour aider à traiter les périostites, avec des exercices et des conseils personnalisés adaptés à votre condition.",
      sessions: 4,
    ),
    // Add more programs here if needed
  ];

  int _currentIndex = 0; // State for the bottom navigation bar

  void _onItemTapped(int index) {
    if (index == 1) {
      // Navigate to CameraPage if the camera icon is clicked
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CameraPage()),
      );
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header and search bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Hey, Gus ",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: "👋",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Color(0xFF10FD91),
                    child: IconButton(
                      icon: Image.asset(
                        "../assets/logopulpos.png",
                        fit: BoxFit.cover,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Container(
                width: 374,
                height: 58,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.grey),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Recherche un programme',
                          ),
                        ),
                      ),
                    ),
                    VerticalDivider(
                      color: Colors.grey,
                      width: 1,
                      thickness: 1,
                    ),
                    IconButton(
                      icon: Icon(Icons.filter_list),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
            SizedBox(height: 8),
            // Filter buttons remain unchanged
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: FilterButton(
                      label: "+ Vue",
                      isSelected: _currentIndex == 0,
                      onTap: () {
                        setState(() {
                          _currentIndex = 0;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: FilterButton(
                      label: "Rapide",
                      isSelected: _currentIndex == 1,
                      onTap: () {
                        setState(() {
                          _currentIndex = 1;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: FilterButton(
                      label: "Dernier",
                      isSelected: _currentIndex == 2,
                      onTap: () {
                        setState(() {
                          _currentIndex = 2;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            // Display the programs dynamically
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
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.camera_alt_outlined), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: ''),
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

  FilterButton({required this.label, required this.isSelected, required this.onTap});

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

  ProgramCard({required this.program});

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
      margin: EdgeInsets.only(right: 16.0),
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
              margin: EdgeInsets.all(8.0),
              padding: EdgeInsets.all(10.0),
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
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    widget.program.subtitle,
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: 4),
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
                      SizedBox(width: 4),
                      Text(
                        "${widget.program.rating}",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Heart icon at the top right corner
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
