// camera.dart
import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Utilisation d'import conditionnel pour télécharger la vidéo selon la plateforme
import 'camera_web.dart' if (dart.library.io) 'camera_mobile.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  bool _isRecording = false;
  Timer? _timer;
  int _recordDuration = 0;
  String _videoPath = '';

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      _cameras = await availableCameras();
      if (_cameras!.isNotEmpty) {
        _cameraController = CameraController(
          _cameras![0],
          ResolutionPreset.high,
        );
        await _cameraController!.initialize();
        if (!mounted) return;
        setState(() {});
      }
    } catch (e) {
      print('Erreur lors de l\'initialisation de la caméra : $e');
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _startRecording() async {
    if (!_cameraController!.value.isRecordingVideo) {
      try {
        await _cameraController!.startVideoRecording();
        setState(() {
          _isRecording = true;
          _recordDuration = 0;
        });
        _startTimer();
      } catch (e) {
        print('Erreur lors du démarrage de l\'enregistrement vidéo : $e');
      }
    }
  }

  Future<void> _stopRecording() async {
    if (_cameraController!.value.isRecordingVideo) {
      try {
        final XFile videoFile = await _cameraController!.stopVideoRecording();
        _timer?.cancel();

        setState(() {
          _isRecording = false;
          _videoPath = videoFile.path;
        });

        // Télécharger la vidéo (fonction définie dans camera_web.dart ou camera_mobile.dart)
        downloadVideoFile(videoFile);

        print('Vidéo enregistrée à : $_videoPath');
      } catch (e) {
        print('Erreur lors de l\'arrêt de l\'enregistrement vidéo : $e');
      }
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _recordDuration++;
      });
    });
  }

  String _formatDuration(int seconds) {
    final int minutes = seconds ~/ 60;
    final int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          _cameraController != null && _cameraController!.value.isInitialized
              ? SizedBox.expand(
            child: CameraPreview(_cameraController!),
          )
              : const Center(child: CircularProgressIndicator()),
          Positioned(
            top: 40,
            left: 16,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Positioned(
            top: 40,
            right: 16,
            child: CircleAvatar(
              radius: 24,
              backgroundColor: const Color(0xFF10FD91),
              child: ClipOval(
                child: Image.asset(
                  '../assets/logopulpos.png',
                  fit: BoxFit.cover,
                  width: 40,
                  height: 40,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_isRecording)
                    Text(
                      _formatDuration(_recordDuration),
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: _isRecording ? _stopRecording : _startRecording,
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _isRecording ? Colors.red : Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
