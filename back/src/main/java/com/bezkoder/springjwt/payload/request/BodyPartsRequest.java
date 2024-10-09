package com.bezkoder.springjwt.payload.request;

import java.util.Set;
import jakarta.validation.constraints.NotNull;

public class BodyPartsRequest {

    @NotNull
    private Set<Long> bodyPartIds;

    public Set<Long> getBodyPartIds() {
        return bodyPartIds;
    }

    public void setBodyPartIds(Set<Long> bodyPartIds) {
        this.bodyPartIds = bodyPartIds;
    }
}
