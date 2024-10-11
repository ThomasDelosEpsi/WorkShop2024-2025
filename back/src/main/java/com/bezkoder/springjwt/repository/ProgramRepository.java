package com.bezkoder.springjwt.repository;

import com.bezkoder.springjwt.models.Program;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ProgramRepository extends JpaRepository<Program, Long> {
}
