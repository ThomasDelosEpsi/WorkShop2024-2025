package com.bezkoder.springjwt.services;

import com.bezkoder.springjwt.models.Program;
import com.bezkoder.springjwt.repository.ProgramRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ProgramService {

    private final ProgramRepository programRepository;

    @Autowired
    public ProgramService(ProgramRepository programRepository) {
        this.programRepository = programRepository;
    }

    public List<Program> getAllPrograms() {
        return programRepository.findAll();
    }

    public Optional<Program> getProgramById(Long id) {
        return programRepository.findById(id);
    }

    public Program createProgram(Program program) {
        return programRepository.save(program);
    }

    public Program updateProgram(Long id, Program programDetails) {
        Program program = programRepository.findById(id).orElseThrow();
        program.setTitle(programDetails.getTitle());
        program.setDescription(programDetails.getDescription());
        program.setUser(programDetails.getUser());
        return programRepository.save(program);
    }

    public void deleteProgram(Long id) {
        programRepository.deleteById(id);
    }
}
