package com.bezkoder.springjwt.payload.response;

import java.util.List;

public class BodyPartResponse {
    private Long id;
    private String name;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public BodyPartResponse() {
    }

    public void setName(String name) {
        this.name = name;
    }

    public BodyPartResponse(Long id, String name) {
        this.id = id;
        this.name = name;
    }

}
