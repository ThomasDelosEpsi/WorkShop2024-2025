package com.bezkoder.springjwt.controllers;

import com.bezkoder.springjwt.models.Program;
import com.bezkoder.springjwt.services.ProgramService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/programs")
public class ProgramController {

    private final ProgramService programService;

    @Autowired
    public ProgramController(ProgramService programService) {
        this.programService = programService;
    }

    // Récupérer tous les programmes
    @GetMapping
    @PreAuthorize("hasRole('USER') or hasRole('KINE') or hasRole('ADMIN')")
    public List<Program> getAllPrograms() {
        return programService.getAllPrograms();
    }

    // Récupérer un programme par ID
    @GetMapping("/{id}")
    @PreAuthorize("hasRole('USER') or hasRole('KINE') or hasRole('ADMIN')")
    public ResponseEntity<Program> getProgramById(@PathVariable Long id) {
        return programService.getProgramById(id)
                .map(program -> ResponseEntity.ok().body(program))
                .orElse(ResponseEntity.notFound().build());
    }

    // Créer un nouveau programme
    @PostMapping
    @PreAuthorize("hasRole('ADMIN') or hasRole('KINE')")
    public ResponseEntity<Program> createProgram(@RequestBody Program program) {
        Program createdProgram = programService.createProgram(program);
        return ResponseEntity.ok(createdProgram);
    }

    // Mettre à jour un programme
    @PutMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN') or hasRole('KINE')")
    public ResponseEntity<Program> updateProgram(@PathVariable Long id, @RequestBody Program programDetails) {
        Program updatedProgram = programService.updateProgram(id, programDetails);
        return ResponseEntity.ok(updatedProgram);
    }

    // Supprimer un programme
    @DeleteMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN') or hasRole('KINE')")
    public ResponseEntity<Void> deleteProgram(@PathVariable Long id) {
        programService.deleteProgram(id);
        return ResponseEntity.noContent().build();
    }
}
