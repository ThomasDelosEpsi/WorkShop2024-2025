package com.bezkoder.springjwt.DTO;

public class ExerciseDTO {
    private Long id;
    private String name;
    private String urlVideo;
    private Long bodyPartId; // Only store the ID for serialization

    public ExerciseDTO(Long id, String name, String urlVideo, Long bodyPartId) {
        this.id = id;
        this.name = name;
        this.urlVideo = urlVideo;
        this.bodyPartId = bodyPartId;
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

    public Long getBodyPartId() {
        return bodyPartId;
    }

    public void setBodyPartId(Long bodyPartId) {
        this.bodyPartId = bodyPartId;
    }
}
