import 'package:flutter/material.dart';
import 'HomePage.dart'; // Import the Program model

class ProgramDetailPage extends StatefulWidget {
  final Program program;

  ProgramDetailPage({required this.program});

  @override
  _ProgramDetailPageState createState() => _ProgramDetailPageState();
}

class _ProgramDetailPageState extends State<ProgramDetailPage> {
  bool isStarred = false; // State for the star icon
  bool isBookmarked = false; // State for the bookmark icon

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image and title section
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(15),
                          ),
                          image: DecorationImage(
                            image: AssetImage(widget.program.image),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black.withOpacity(0.6),
                                Colors.transparent,
                              ],
                            ),
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(15),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 40,
                        left: 16,
                        child: IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Positioned(
                        top: 40,
                        right: 16,
                        child: IconButton(
                          icon: Icon(
                            isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                            color: isBookmarked ? Colors.red : Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              isBookmarked = !isBookmarked;
                            });
                            if (isBookmarked) {
                              print("Favoris");
                            }
                          },
                        ),
                      ),
                      Positioned(
                        bottom: 16,
                        left: 16,
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.program.title,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(Icons.calendar_today, size: 16, color: Colors.white70),
                                  SizedBox(width: 4),
                                  Text(
                                    widget.program.subtitle,
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Text(
                          "Programme",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 4),
                        Text(
                          "Détails",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.access_time, size: 18, color: Colors.grey),
                              SizedBox(width: 4),
                              Text(
                                "${widget.program.sessions} séance",
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isStarred = !isStarred;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  isStarred ? Icons.check : Icons.star,
                                  size: 18,
                                  color: isStarred ? Colors.green : Colors.grey,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "${widget.program.rating}",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  // Scrollable text
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      widget.program.description,
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    ),
                  ),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ),
          // Full-width button at the bottom
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Handle the button action
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                "Commencer maintenant",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
