package com.bezkoder.springjwt.payload.response;

import java.util.List;

public class BodyPartResponse {
    private Integer id;
    private String name;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
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

    public BodyPartResponse(Integer id, String name) {
        this.id = id;
        this.name = name;
    }

}
