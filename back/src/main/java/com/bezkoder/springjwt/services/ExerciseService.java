package com.bezkoder.springjwt.services;

import com.bezkoder.springjwt.models.BodyPart;
import com.bezkoder.springjwt.models.Exercise;
import com.bezkoder.springjwt.payload.request.ExerciseRequest;
import com.bezkoder.springjwt.repository.BodyPartRepository;
import com.bezkoder.springjwt.repository.ExerciseRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ExerciseService {

    @Autowired
    private ExerciseRepository exerciseRepository;

    @Autowired
    private BodyPartRepository bodyPartRepository;

    public List<Exercise> getAllExercises() {
        return exerciseRepository.findAll();
    }

    public Optional<Exercise> getExerciseById(Long id) {
        return exerciseRepository.findById(id);
    }

    public List<Exercise> getExercisesByBodyPartId(Long bodyPartId) {
        return exerciseRepository.findByBodyPartId(bodyPartId); // Méthode que vous allez créer dans le dépôt
    }

    public Exercise createExercise(ExerciseRequest exerciseRequest) {
        BodyPart bodyPart = bodyPartRepository.findById(exerciseRequest.getBodyPartId())
                .orElseThrow(() -> new RuntimeException("BodyPart not found"));

        Exercise exercise = new Exercise();
        exercise.setName(exerciseRequest.getName());
        exercise.setUrlVideo(exerciseRequest.getUrlVideo());
        exercise.setBodyPart(bodyPart);
        return exerciseRepository.save(exercise);
    }

    public Optional<Exercise> updateExercise(Long id, ExerciseRequest exerciseRequest) {
        return exerciseRepository.findById(id).map(exercise -> {
            exercise.setName(exerciseRequest.getName());
            exercise.setUrlVideo(exerciseRequest.getUrlVideo());
            if (exerciseRequest.getBodyPartId() != null) {
                BodyPart bodyPart = bodyPartRepository.findById(exerciseRequest.getBodyPartId())
                        .orElseThrow(() -> new RuntimeException("BodyPart not found"));
                exercise.setBodyPart(bodyPart);
            }
            return exerciseRepository.save(exercise);
        });
    }

    public void deleteExercise(Long id) {
        exerciseRepository.deleteById(id);
    }
}
