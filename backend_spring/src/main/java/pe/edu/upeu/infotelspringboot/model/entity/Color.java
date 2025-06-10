package pe.edu.upeu.infotelspringboot.model.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Data
public class Color {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idColor;

    private String nombre;

    @OneToMany(mappedBy = "color", cascade = CascadeType.ALL, orphanRemoval = true)
    @JsonManagedReference
    private List<ProductoColor> productoColores = new ArrayList<>();

    private LocalDateTime fechaCreacionColor;
    private LocalDateTime fechaModificacionColor;

    @PrePersist
    public void onCreate(){
        fechaCreacionColor = LocalDateTime.now();
    }

    @PreUpdate
    public void onUpdate(){
        fechaModificacionColor = LocalDateTime.now();
    }
}