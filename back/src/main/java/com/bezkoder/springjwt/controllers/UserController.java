package com.bezkoder.springjwt.controllers;

import com.bezkoder.springjwt.models.BodyPart;
import com.bezkoder.springjwt.models.User;
import com.bezkoder.springjwt.payload.request.BodyPartsRequest;
import com.bezkoder.springjwt.payload.request.UpdateUserRequest;
import com.bezkoder.springjwt.payload.response.MessageResponse;
import com.bezkoder.springjwt.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;
import java.util.Set;

@RestController
@RequestMapping("/api/users")
public class UserController {

    @Autowired
    private UserService userService;

    // Endpoint to partially update user details
    @PostMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN') or hasRole('USER') or hasRole('KINE')")
    public ResponseEntity<?> updateUser(@PathVariable Long id, @RequestBody UpdateUserRequest updateUserRequest) {
        Optional<User> userData = userService.updateUser(id, updateUserRequest);

        if (userData.isPresent()) {
            return ResponseEntity.ok(new MessageResponse("User updated successfully!"));
        } else {
            return ResponseEntity.badRequest().body(new MessageResponse("Error: User not found!"));
        }
    }

    // Endpoint to get all BodyParts of a user
    @GetMapping("/{userId}/bodyparts")
    @PreAuthorize("hasRole('ADMIN') or hasRole('USER') or hasRole('KINE')")
    public ResponseEntity<Set<BodyPart>> getBodyPartsForUser(@PathVariable Long userId) {
        Set<BodyPart> bodyParts = userService.getBodyPartsByUserId(userId);
        return ResponseEntity.ok(bodyParts);
    }

    // Endpoint to add BodyParts to a user
    @PostMapping("/{id}/bodyparts")
    @PreAuthorize("hasRole('ADMIN') or hasRole('USER') or hasRole('KINE')")
    public ResponseEntity<?> addBodyPartsToUser(@PathVariable Long id, @RequestBody BodyPartsRequest request) {
        userService.addBodyPartsToUser(id, request.getBodyPartIds());
        return ResponseEntity.ok(new MessageResponse("Body parts added successfully!"));
    }


    // Endpoint to remove BodyParts from a user
    @DeleteMapping("/{userId}/bodyparts")
    @PreAuthorize("hasRole('ADMIN') or hasRole('USER') or hasRole('KINE')")
    public ResponseEntity<?> removeBodyPartsFromUser(@PathVariable Long userId, @RequestBody BodyPartsRequest request) {
        userService.removeBodyPartsFromUser(userId, request.getBodyPartIds());
        return ResponseEntity.ok(new MessageResponse("BodyParts removed successfully!"));
    }
}
