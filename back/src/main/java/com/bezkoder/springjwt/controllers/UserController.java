package com.bezkoder.springjwt.controllers;

import com.bezkoder.springjwt.models.User;
import com.bezkoder.springjwt.payload.request.UpdateUserRequest;
import com.bezkoder.springjwt.payload.response.MessageResponse;
import com.bezkoder.springjwt.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RestController
@RequestMapping("/api/users")
public class UserController {

    @Autowired
    UserRepository userRepository;

    // Endpoint to partially update user details
    @PostMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN') or hasRole('USER') or hasRole('KINE')")
    public ResponseEntity<?> updateUser(@PathVariable Long id, @RequestBody UpdateUserRequest updateUserRequest) {
        // Find the user by ID
        Optional<User> userData = userRepository.findById(id);

        if (userData.isPresent()) {
            User user = userData.get();

            // Update only fields that are provided in the request
            if (updateUserRequest.getFirstName() != null) {
                user.setFirstName(updateUserRequest.getFirstName());
            }
            if (updateUserRequest.getLastName() != null) {
                user.setLastName(updateUserRequest.getLastName());
            }
            if (updateUserRequest.getEmail() != null) {
                user.setEmail(updateUserRequest.getEmail());
            }
            if (updateUserRequest.getPassword() != null) {
                user.setPassword(updateUserRequest.getPassword());
            }
            if (updateUserRequest.getBirthDate() != null) {
                user.setBirthDate(updateUserRequest.getBirthDate());
            }
            if (updateUserRequest.getWeight() != null) {
                user.setWeight(updateUserRequest.getWeight());
            }
            if (updateUserRequest.getHeight() != null) {
                user.setHeight(updateUserRequest.getHeight());
            }

            // Save the updated user
            userRepository.save(user);
            return ResponseEntity.ok(new MessageResponse("User updated successfully!"));
        } else {
            return ResponseEntity.badRequest().body(new MessageResponse("Error: User not found!"));
        }
    }
}
