package com.bezkoder.springjwt.payload.request;

import jakarta.validation.constraints.NotBlank;

public class ExerciseRequest {

    @NotBlank
    private String name;

    @NotBlank
    private String urlVideo;

    private Long bodyPartId; // The ID of the BodyPart associated with this exercise

    // Getters and Setters

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
