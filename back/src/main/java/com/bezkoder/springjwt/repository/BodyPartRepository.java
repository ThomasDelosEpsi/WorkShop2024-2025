package com.bezkoder.springjwt.repository;

import com.bezkoder.springjwt.models.BodyPart;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BodyPartRepository extends JpaRepository<BodyPart, Integer> {
}
