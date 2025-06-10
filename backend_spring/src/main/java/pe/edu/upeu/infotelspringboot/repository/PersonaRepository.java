package pe.edu.upeu.infotelspringboot.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import pe.edu.upeu.infotelspringboot.model.entity.Persona;

@Repository
public interface PersonaRepository extends JpaRepository<Persona, Long> {
}
