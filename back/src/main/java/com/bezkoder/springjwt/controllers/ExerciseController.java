package com.bezkoder.springjwt.controllers;

import com.bezkoder.springjwt.DTO.ExerciseDTO;
import com.bezkoder.springjwt.models.Exercise;
import com.bezkoder.springjwt.payload.request.ExerciseRequest;
import com.bezkoder.springjwt.services.ExerciseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/exercises")
public class ExerciseController {

    @Autowired
    private ExerciseService exerciseService;

    @GetMapping
    public List<ExerciseDTO> getAllExercises() {
        return exerciseService.getAllExercises().stream()
                .map(exercise -> new ExerciseDTO(
                        exercise.getId(),
                        exercise.getName(),
                        exercise.getUrlVideo(),
                        exercise.getBodyPart().getId()
                ))
                .collect(Collectors.toList());
    }

    @GetMapping("/{id}")
    public ResponseEntity<ExerciseDTO> getExerciseById(@PathVariable Long id) {
        return exerciseService.getExerciseById(id)
                .map(exercise -> new ExerciseDTO(
                        exercise.getId(),
                        exercise.getName(),
                        exercise.getUrlVideo(),
                        exercise.getBodyPart().getId()
                ))
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/bodyPart/{bodyPartId}")
    public List<ExerciseDTO> getExercisesByBodyPartId(@PathVariable Long bodyPartId) {
        return exerciseService.getExercisesByBodyPartId(bodyPartId).stream()
                .map(exercise -> new ExerciseDTO(
                        exercise.getId(),
                        exercise.getName(),
                        exercise.getUrlVideo(),
                        exercise.getBodyPart().getId()
                ))
                .collect(Collectors.toList());
    }

    @PostMapping
    public ResponseEntity<Exercise> createExercise(@RequestBody ExerciseRequest exerciseRequest) {
        Exercise exercise = exerciseService.createExercise(exerciseRequest);
        return ResponseEntity.status(201).body(exercise);
    }

    @PutMapping("/{id}")
    public ResponseEntity<ExerciseDTO> updateExercise(@PathVariable Long id, @RequestBody ExerciseRequest exerciseRequest) {
        return exerciseService.updateExercise(id, exerciseRequest)
                .map(exercise -> new ExerciseDTO(
                        exercise.getId(),
                        exercise.getName(),
                        exercise.getUrlVideo(),
                        exercise.getBodyPart().getId()
                ))
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteExercise(@PathVariable Long id) {
        exerciseService.deleteExercise(id);
        return ResponseEntity.noContent().build();
    }
}
