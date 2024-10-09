package com.bezkoder.springjwt.services;

import com.bezkoder.springjwt.models.BodyPart;
import com.bezkoder.springjwt.repository.BodyPartRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class BodyPartService {

    @Autowired
    private BodyPartRepository bodyPartRepository;

    // Créer un nouveau bodyPart
    public BodyPart createBodyPart(BodyPart bodyPart) {
        return bodyPartRepository.save(bodyPart);
    }

    // Récupérer tous les bodyParts
    public List<BodyPart> getAllBodyParts() {
        return bodyPartRepository.findAll();
    }

    // Récupérer un bodyPart par ID
    public Optional<BodyPart> getBodyPartById(Integer id) {
        return bodyPartRepository.findById(id);
    }

    // Mettre à jour un bodyPart
    public BodyPart updateBodyPart(Integer id, BodyPart bodyPartDetails) {
        BodyPart bodyPart = bodyPartRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("BodyPart not found with id " + id));

        bodyPart.setName(bodyPartDetails.getName());
        return bodyPartRepository.save(bodyPart);
    }

    // Supprimer un bodyPart
    public void deleteBodyPart(Integer id) {
        BodyPart bodyPart = bodyPartRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("BodyPart not found with id " + id));
        bodyPartRepository.delete(bodyPart);
    }
}
