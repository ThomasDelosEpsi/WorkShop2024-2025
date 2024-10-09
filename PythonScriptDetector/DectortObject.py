from flask import Flask, Response
import cv2
import numpy as np
import logging
import time
from imutils.video import VideoStream

# Configuration du serveur Flask
app = Flask(__name__)
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

# Chargement du modèle de réseau neuronal
logging.info("Chargement du modèle de réseau neuronal...")
try:
    net = cv2.dnn.readNetFromCaffe("MobileNetSSD_deploy.prototxt.txt", "MobileNetSSD_deploy.caffemodel")
    logging.info("Modèle chargé avec succès.")
except Exception as e:
    logging.error(f"Erreur lors du chargement du modèle : {e}")
    exit(1)

# Liste des classes du modèle
CLASSES = ["arriere-plan", "avion", "velo", "oiseau", "bateau",
           "bouteille", "autobus", "voiture", "chat", "chaise", "vache", "table",
           "chien", "cheval", "moto", "personne", "plante en pot", "mouton",
           "sofa", "train", "moniteur"]
COLORS = np.random.uniform(0, 255, size=(len(CLASSES), 3))

# Initialisation de la caméra
logging.info("Initialisation de la caméra...")
vs = VideoStream(src=0).start()
time.sleep(2.0)  # Délai pour laisser le temps à la caméra de démarrer

def gen():
    """Génère le flux vidéo avec détection d'objets"""
    while True:
        # Capture une frame de la vidéo
        frame = vs.read()
        if frame is None:
            continue

        # Prétraitement de l'image pour le modèle
        (h, w) = frame.shape[:2]
        blob = cv2.dnn.blobFromImage(cv2.resize(frame, (300, 300)), 0.007843, (300, 300), 127.5)
        
        # Passer le blob dans le réseau
        net.setInput(blob)
        detections = net.forward()

        # Boucle de détection
        for i in np.arange(0, detections.shape[2]):
            confidence = detections[0, 0, i, 2]
            if confidence > 0.2:
                idx = int(detections[0, 0, i, 1])
                box = detections[0, 0, i, 3:7] * np.array([w, h, w, h])
                (startX, startY, endX, endY) = box.astype("int")

                # Dessine la boîte de délimitation et l'étiquette
                label = "{}: {:.2f}%".format(CLASSES[idx], confidence * 100)
                cv2.rectangle(frame, (startX, startY), (endX, endY), COLORS[idx], 2)
                y = startY - 15 if startY - 15 > 15 else startY + 15
                cv2.putText(frame, label, (startX, y), cv2.FONT_HERSHEY_SIMPLEX, 0.5, COLORS[idx], 2)

                logging.info(f"Objet détecté : {label}")

        # Encodage de la frame en JPEG
        ret, jpeg = cv2.imencode('.jpg', frame)
        if not ret:
            continue

        # Envoi de la frame
        yield (b'--frame\r\n'
               b'Content-Type: image/jpeg\r\n\r\n' + jpeg.tobytes() + b'\r\n')

@app.route('/video_feed')
def video_feed():
    """Route pour le flux vidéo"""
    return Response(gen(), mimetype='multipart/x-mixed-replace; boundary=frame')

# Démarrage du serveur Flask
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=False)
