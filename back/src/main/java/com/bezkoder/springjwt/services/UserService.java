package com.bezkoder.springjwt.services;

import com.bezkoder.springjwt.models.BodyPart;
import com.bezkoder.springjwt.models.Role;
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

    // Method to update a user
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

    // Method to get body parts of a user
    public Set<BodyPart> getBodyPartsByUserId(Long userId) {
        User user = userRepository.findById(userId).orElseThrow(() -> new RuntimeException("User not found"));
        return user.getBodyParts();
    }

    // Method to add body parts to a user
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

    // Method to remove body parts from a user
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

    // Method to get the friends of a user
    public Set<User> getFriendsByUserId(Long userId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));
        return user.getFriends();
    }

    // Method to add a friend to a user, with role-based restrictions
    public void addFriend(Long userId, Long friendId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));
        User friend = userRepository.findById(friendId)
                .orElseThrow(() -> new RuntimeException("Friend not found"));

        // Check if user and friend meet the role-based friendship requirements
        if (canBeFriends(user, friend)) {
            user.getFriends().add(friend);
            userRepository.save(user);
        } else {
            throw new RuntimeException("Users can only be friends with Kine and vice versa.");
        }
    }

    // Method to remove a friend from a user
    public void removeFriend(Long userId, Long friendId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));
        User friend = userRepository.findById(friendId)
                .orElseThrow(() -> new RuntimeException("Friend not found"));

        if (user.getFriends().contains(friend)) {
            user.getFriends().remove(friend);
            userRepository.save(user);
        } else {
            throw new RuntimeException("The user is not your friend!");
        }
    }

    // Method to get a specific friend by userId and friendId
    public User getFriendById(Long userId, Long friendId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));
        User friend = userRepository.findById(friendId)
                .orElseThrow(() -> new RuntimeException("Friend not found"));

        if (user.getFriends().contains(friend)) {
            return friend;
        } else {
            throw new RuntimeException("Friend not found in user's friend list.");
        }
    }

    // Helper method to check if users can be friends based on their roles
    private boolean canBeFriends(User user, User potentialFriend) {
        boolean userIsKine = user.getRoles().stream().anyMatch(role -> role.getName().equals("ROLE_KINE"));
        boolean friendIsKine = potentialFriend.getRoles().stream().anyMatch(role -> role.getName().equals("ROLE_KINE"));

        // A User can be friends with a Kine, but not with another User
        return (userIsKine && !friendIsKine) || (!userIsKine && friendIsKine);
    }
}
