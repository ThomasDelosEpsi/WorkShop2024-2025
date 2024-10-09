package com.bezkoder.springjwt.services;

import com.bezkoder.springjwt.models.BodyPart;
import com.bezkoder.springjwt.models.User;
import com.bezkoder.springjwt.payload.request.UpdateUserRequest;
import com.bezkoder.springjwt.repository.BodyPartRepository;
import com.bezkoder.springjwt.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashSet;
import java.util.Optional;
import java.util.Set;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private BodyPartRepository bodyPartRepository;

    public Optional<User> updateUser(Long id, UpdateUserRequest request) {
        return userRepository.findById(id).map(user -> {
            if (request.getFirstName() != null) user.setFirstName(request.getFirstName());
            if (request.getLastName() != null) user.setLastName(request.getLastName());
            if (request.getEmail() != null) user.setEmail(request.getEmail());
            if (request.getPassword() != null) user.setPassword(request.getPassword());
            if (request.getBirthDate() != null) user.setBirthDate(request.getBirthDate());
            if (request.getWeight() != null) user.setWeight(request.getWeight());
            if (request.getHeight() != null) user.setHeight(request.getHeight());
            return userRepository.save(user);
        });
    }

    public Set<BodyPart> getBodyPartsByUserId(Long userId) {
        User user = userRepository.findById(userId).orElseThrow(() -> new RuntimeException("User not found"));
        return user.getBodyParts();
    }

    public void addBodyPartsToUser(Long userId, Set<Long> bodyPartIds) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));

        Set<BodyPart> bodyParts = new HashSet<>();
        for (Long id : bodyPartIds) {
            BodyPart bodyPart = bodyPartRepository.findById(id)
                    .orElseThrow(() -> new RuntimeException("BodyPart not found with id: " + id));
            bodyParts.add(bodyPart);
        }

        user.getBodyParts().addAll(bodyParts);
        userRepository.save(user);
    }

    public void removeBodyPartsFromUser(Long userId, Set<Long> bodyPartIds) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));

        Set<BodyPart> bodyPartsToRemove = new HashSet<>();
        for (Long id : bodyPartIds) {
            BodyPart bodyPart = bodyPartRepository.findById(id)
                    .orElseThrow(() -> new RuntimeException("BodyPart not found with id: " + id));
            bodyPartsToRemove.add(bodyPart);
        }

        user.getBodyParts().removeAll(bodyPartsToRemove);
        userRepository.save(user);
    }
}
