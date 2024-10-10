package com.bezkoder.springjwt.models;

import jakarta.persistence.*;

@Entity
@Table(name = "programs")
public class Program {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idProgram")
    private Long idProgram;

    @Column(name = "title", length = 50, nullable = false)
    private String title;

    @Column(name = "description", columnDefinition = "TEXT")
    private String description;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "idUser", referencedColumnName = "id", nullable = false)
    private User user;

    // Constructors
    public Program() {}

    public Program(String title, String description, User user) {
        this.title = title;
        this.description = description;
        this.user = user;
    }

    // Getters and Setters
    public Long getIdProgram() {
        return idProgram;
    }

    public void setIdProgram(Long idProgram) {
        this.idProgram = idProgram;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}
