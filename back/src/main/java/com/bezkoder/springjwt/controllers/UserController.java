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

    // Endpoint to get friends of a user
    @GetMapping("/{userId}/friends")
    @PreAuthorize("hasRole('ADMIN') or hasRole('USER') or hasRole('KINE')")
    public ResponseEntity<Set<User>> getFriends(@PathVariable Long userId) {
        Set<User> friends = userService.getFriendsByUserId(userId);
        return ResponseEntity.ok(friends);
    }

    // Endpoint to add a friend
    @PostMapping("/{userId}/friends/{friendId}")
    @PreAuthorize("hasRole('ADMIN') or hasRole('USER') or hasRole('KINE')")
    public ResponseEntity<?> addFriend(@PathVariable Long userId, @PathVariable Long friendId) {
        userService.addFriend(userId, friendId);
        return ResponseEntity.ok(new MessageResponse("Friend added successfully!"));
    }

    // Endpoint to remove a friend
    @DeleteMapping("/{userId}/friends/{friendId}")
    @PreAuthorize("hasRole('ADMIN') or hasRole('USER') or hasRole('KINE')")
    public ResponseEntity<?> removeFriend(@PathVariable Long userId, @PathVariable Long friendId) {
        userService.removeFriend(userId, friendId);
        return ResponseEntity.ok(new MessageResponse("Friend removed successfully!"));
    }

    // Endpoint to get a specific friend by ID
    @GetMapping("/{userId}/friends/{friendId}")
    @PreAuthorize("hasRole('ADMIN') or hasRole('USER') or hasRole('KINE')")
    public ResponseEntity<User> getFriendById(@PathVariable Long userId, @PathVariable Long friendId) {
        User friend = userService.getFriendById(userId, friendId);
        return ResponseEntity.ok(friend);
    }
}
