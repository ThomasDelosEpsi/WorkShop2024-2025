// camera_web.dart
import 'package:camera/camera.dart';
import 'dart:html' as html;

void downloadVideoFile(XFile videoFile) async {
  // Créer un objet Blob à partir des données vidéo
  final blob = html.Blob([await videoFile.readAsBytes()], 'video/mp4');
  // Créer une URL à partir du Blob
  final url = html.Url.createObjectUrlFromBlob(blob);
  // Créer un élément d'ancrage pour télécharger le fichier
  final anchor = html.AnchorElement(href: url)
    ..setAttribute('download', 'video_${DateTime.now().millisecondsSinceEpoch}.mp4')
    ..click(); // Déclencher le clic pour démarrer le téléchargement
  // Révoquer l'URL pour libérer les ressources
  html.Url.revokeObjectUrl(url);
}
