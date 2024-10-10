import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:async';
import 'dart:html' as html;

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
      print('Error initializing camera: $e');
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
        print('Error starting video recording: $e');
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

        if (kIsWeb) {
          _downloadVideoFile(videoFile);
        }

        print('Video recorded to: $_videoPath');
      } catch (e) {
        print('Error stopping video recording: $e');
      }
    }
  }

  void _downloadVideoFile(XFile videoFile) async {
    final blob = html.Blob([await videoFile.readAsBytes()], 'video/mp4');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute('download', 'video_${DateTime.now().millisecondsSinceEpoch}.mp4')
      ..click();
    html.Url.revokeObjectUrl(url);
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
          // Back button
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
          // User profile image
          Positioned(
            top: 40,
            right: 16,
            child: CircleAvatar(
              radius: 24,
              backgroundColor: const Color(0xFF10FD91),
              child: ClipOval(
                child: Image.asset(
                  '../assets/logopulpos.png', // Chemin vers votre image
                  fit: BoxFit.cover,
                  width: 40,
                  height: 40,
                ),
              ),
            ),
          ),
          // Capture button and timer
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
