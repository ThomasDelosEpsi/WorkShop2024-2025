package com.bezkoder.springjwt.controllers;

import com.bezkoder.springjwt.models.BodyPart;
import com.bezkoder.springjwt.services.BodyPartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/bodyParts")
public class BodyPartController {

    @Autowired
    private BodyPartService bodyPartService;

    // Créer un nouveau bodyPart
    @PostMapping
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<BodyPart> createBodyPart(@RequestBody BodyPart bodyPart) {
        BodyPart createdBodyPart = bodyPartService.createBodyPart(bodyPart);
        return ResponseEntity.ok(createdBodyPart);
    }

    // Récupérer tous les bodyParts
    @GetMapping
    @PreAuthorize("hasRole('USER') or hasRole('KINE') or hasRole('ADMIN')")
    public List<BodyPart> getAllBodyParts() {
        return bodyPartService.getAllBodyParts();
    }

    // Récupérer un bodyPart par ID
    @GetMapping("/{id}")
    @PreAuthorize("hasRole('USER') or hasRole('KINE') or hasRole('ADMIN')")
    public ResponseEntity<BodyPart> getBodyPartById(@PathVariable Integer id) {
        BodyPart bodyPart = bodyPartService.getBodyPartById(id)
                .orElseThrow(() -> new RuntimeException("BodyPart not found with id " + id));
        return ResponseEntity.ok(bodyPart);
    }

    // Mettre à jour un bodyPart
    @PutMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<BodyPart> updateBodyPart(@PathVariable Integer id, @RequestBody BodyPart bodyPartDetails) {
        BodyPart updatedBodyPart = bodyPartService.updateBodyPart(id, bodyPartDetails);
        return ResponseEntity.ok(updatedBodyPart);
    }

    // Supprimer un bodyPart
    @DeleteMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<Void> deleteBodyPart(@PathVariable Integer id) {
        bodyPartService.deleteBodyPart(id);
        return ResponseEntity.noContent().build();
    }
}
