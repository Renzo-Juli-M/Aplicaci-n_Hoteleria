package pe.edu.upeu.infotelspringboot.model.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Data
public class Rol {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idRol;

    @Column(nullable = false, unique = true)
    private String nombre;

    @OneToMany(mappedBy = "rol")
    @JsonBackReference
    private List<Usuario> usuarios = new ArrayList<>();

    private LocalDateTime fechaCreacionRol;
    private LocalDateTime fechaModificacionRol;

    @PrePersist
    public void onCreate(){
        fechaCreacionRol = LocalDateTime.now();
    }

    @PreUpdate
    public void onUpdate(){
        fechaModificacionRol = LocalDateTime.now();
    }
}
