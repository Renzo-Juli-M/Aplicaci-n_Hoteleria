package pe.edu.upeu.infotelspringboot.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import pe.edu.upeu.infotelspringboot.model.entity.Color;

import java.util.List;
import java.util.Optional;

public interface ColorRepository extends JpaRepository<Color, Long> {
    List<Color> findByNombreIn(List<String> nombres);
    Optional<Color> findByNombre(String nombre);
    @Query("SELECT c FROM Color c WHERE LOWER(c.nombre) LIKE LOWER(CONCAT('%', :nombre, '%'))")
    List<Color> buscarPorNombre(@Param("nombre") String nombre);
}
