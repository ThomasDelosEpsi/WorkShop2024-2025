package com.bezkoder.springjwt.models;

import jakarta.persistence.*;

@Entity
@Table(name = "exercises")
public class Exercise {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String name;

    @Column(name = "url_video", nullable = false)
    private String urlVideo;

    @ManyToOne(fetch = FetchType.LAZY)  // Keep lazy loading for BodyPart
    @JoinColumn(name = "body_part_id", nullable = false)
    private BodyPart bodyPart;

    public Exercise() {}

    public Exercise(String name, String urlVideo, BodyPart bodyPart) {
        this.name = name;
        this.urlVideo = urlVideo;
        this.bodyPart = bodyPart;
    }

    // Getters and Setters

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUrlVideo() {
        return urlVideo;
    }

    public void setUrlVideo(String urlVideo) {
        this.urlVideo = urlVideo;
    }

    public BodyPart getBodyPart() {
        return bodyPart;
    }

    public void setBodyPart(BodyPart bodyPart) {
        this.bodyPart = bodyPart;
    }
}
