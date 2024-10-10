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

    // Méthode pour mettre à jour un utilisateur
    public Optional<User> updateUser(Long id, UpdateUserRequest request) {
        return userRepository.findById(id).map(user -> {
            if (request.getFirstName() != null) user.setFirstName(request.getFirstName());
            if (request.getLastName() != null) user.setLastName(request.getLastName());
            if (request.getEmail() != null) user.setEmail(request.getEmail());
            if (request.getPassword() != null) user.setPassword(request.getPassword());
            if (request.getBirthDate() != null) user.setBirthDate(request.getBirthDate());
            if (request.getWeight() != null) user.setWeight(request.getWeight());
            if (request.getHeight() != null) user.setHeight(request.getHeight());
            if (request.getFirstConnexion() != null) user.setFirstConnexion(request.getFirstConnexion()); // Gérer firstConnexion
            return userRepository.save(user);
        });
    }

    // Méthode pour obtenir les parties du corps d'un utilisateur
    public Set<BodyPart> getBodyPartsByUserId(Long userId) {
        User user = userRepository.findById(userId).orElseThrow(() -> new RuntimeException("User not found"));
        return user.getBodyParts();
    }

    // Méthode pour ajouter des parties du corps à un utilisateur
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

    // Méthode pour supprimer des parties du corps d'un utilisateur
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

    // Méthode pour obtenir les amis d'un utilisateur
    public Set<User> getFriendsByUserId(Long userId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));
        return user.getFriends();
    }

    // Méthode pour ajouter un ami à un utilisateur, avec des restrictions basées sur les rôles
    public void addFriend(Long userId, Long friendId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));
        User friend = userRepository.findById(friendId)
                .orElseThrow(() -> new RuntimeException("Friend not found"));

        // Vérifier si l'utilisateur et l'ami respectent les conditions d'amitié basées sur les rôles
        if (canBeFriends(user, friend)) {
            user.getFriends().add(friend);
            userRepository.save(user);
        } else {
            throw new RuntimeException("Users can only be friends with Kine and vice versa.");
        }
    }

    // Méthode pour supprimer un ami d'un utilisateur
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

    // Méthode pour obtenir un ami spécifique par userId et friendId
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

    // Méthode d'aide pour vérifier si les utilisateurs peuvent être amis en fonction de leurs rôles
    private boolean canBeFriends(User user, User potentialFriend) {
        boolean userIsKine = user.getRoles().stream().anyMatch(role -> role.getName().equals("ROLE_KINE"));
        boolean friendIsKine = potentialFriend.getRoles().stream().anyMatch(role -> role.getName().equals("ROLE_KINE"));

        // Un utilisateur peut être ami avec un Kine, mais pas avec un autre utilisateur
        return (userIsKine && !friendIsKine) || (!userIsKine && friendIsKine);
    }
}
