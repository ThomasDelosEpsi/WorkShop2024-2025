package com.bezkoder.springjwt.payload.request;

import java.util.Set;
import jakarta.validation.constraints.NotNull;

public class BodyPartsRequest {

    @NotNull
    private Set<Integer> bodyPartIds;

    public Set<Integer> getBodyPartIds() {
        return bodyPartIds;
    }

    public void setBodyPartIds(Set<Integer> bodyPartIds) {
        this.bodyPartIds = bodyPartIds;
    }
}
