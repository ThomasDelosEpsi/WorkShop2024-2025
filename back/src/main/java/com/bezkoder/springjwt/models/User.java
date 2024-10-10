package com.bezkoder.springjwt.models;

import java.sql.Time; // Importer le type Time
import java.util.Date;
import java.util.HashSet;
import java.util.Set;
import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

@Entity
@Table(name = "users",
        uniqueConstraints = {
                @UniqueConstraint(columnNames = "username"),
                @UniqueConstraint(columnNames = "email")
        })
public class User {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  @NotBlank
  @Size(max = 20)
  private String username;

  @NotBlank
  @Size(max = 50)
  @Email
  private String email;

  @NotBlank
  @Size(max = 120)
  private String password;

  private String firstName;
  private String lastName;
  private Date birthDate;
  private double weight;
  private double height;

  private String gender;

  @Column(nullable = false)
  private boolean firstConnexion;

  @Column(name = "daily_exercises") // Nom de la colonne dans la base de données
  private Time dailyExercises; // Champ pour l'heure des exercices quotidiens

  @ManyToMany(fetch = FetchType.LAZY)
  @JoinTable(
          name = "user_roles",
          joinColumns = @JoinColumn(name = "user_id"),
          inverseJoinColumns = @JoinColumn(name = "role_id")
  )
  private Set<Role> roles = new HashSet<>();

  @ManyToMany(fetch = FetchType.LAZY)
  @JoinTable(
          name = "user_body_parts",
          joinColumns = @JoinColumn(name = "user_id"),
          inverseJoinColumns = @JoinColumn(name = "body_part_id")
  )
  private Set<BodyPart> bodyParts = new HashSet<>();

  // Many-to-Many relationship with other users
  @ManyToMany(fetch = FetchType.LAZY)
  @JoinTable(
          name = "user_friends",
          joinColumns = @JoinColumn(name = "user_id"),
          inverseJoinColumns = @JoinColumn(name = "friend_id")
  )
  private Set<User> friends = new HashSet<>();

  // Constructeur vide
  public User() {
    this.firstConnexion = true; // Initialisation par défaut
  }

  // Constructeur avec paramètres
  public User(String username, String email, String password) {
    this.username = username;
    this.email = email;
    this.password = password;
    this.firstConnexion = true; // Assurez-vous que firstConnexion est vrai lors de la création d'un utilisateur
  }

  // Getters et Setters
  public Long getId() {
    return id;
  }

  public void setId(Long id) {
    this.id = id;
  }

  public String getUsername() {
    return username;
  }

  public void setUsername(String username) {
    this.username = username;
  }

  public String getEmail() {
    return email;
  }

  public void setEmail(String email) {
    this.email = email;
  }

  public String getPassword() {
    return password;
  }

  public void setPassword(String password) {
    this.password = password;
  }

  public String getFirstName() {
    return firstName;
  }

  public void setFirstName(String firstName) {
    this.firstName = firstName;
  }

  public String getLastName() {
    return lastName;
  }

  public void setLastName(String lastName) {
    this.lastName = lastName;
  }

  public Date getBirthDate() {
    return birthDate;
  }

  public void setBirthDate(Date birthDate) {
    this.birthDate = birthDate;
  }

  public double getWeight() {
    return weight;
  }

  public void setWeight(double weight) {
    this.weight = weight;
  }

  public double getHeight() {
    return height;
  }

  public void setHeight(double height) {
    this.height = height;
  }

  public String getGender() {
    return gender; // Getter pour le genre
  }

  public void setGender(String gender) {
    this.gender = gender; // Setter pour le genre
  }

  public boolean isFirstConnexion() {
    return firstConnexion;
  }

  public void setFirstConnexion(boolean firstConnexion) {
    this.firstConnexion = firstConnexion;
  }

  public Time getDailyExercises() {
    return dailyExercises; // Getter pour l'heure des exercices quotidiens
  }

  public void setDailyExercises(Time dailyExercises) {
    this.dailyExercises = dailyExercises; // Setter pour l'heure des exercices quotidiens
  }

  public Set<Role> getRoles() {
    return roles;
  }

  public void setRoles(Set<Role> roles) {
    this.roles = roles;
  }

  public Set<BodyPart> getBodyParts() {
    return bodyParts;
  }

  public void setBodyParts(Set<BodyPart> bodyParts) {
    this.bodyParts = bodyParts;
  }

  public Set<User> getFriends() {
    return friends;
  }

  public void setFriends(Set<User> friends) {
    this.friends = friends;
  }
}
