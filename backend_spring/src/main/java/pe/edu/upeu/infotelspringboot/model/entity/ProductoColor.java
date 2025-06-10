package pe.edu.upeu.infotelspringboot.model.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDateTime;

@Entity
@Data
public class ProductoColor {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "producto_id")
    @JsonBackReference
    private Producto producto;

    @ManyToOne
    @JoinColumn(name = "color_id")
    @JsonBackReference
    private Color color;

    private LocalDateTime fechaCreacionProductoColor;
    private LocalDateTime fechaModificacionProductoColor;

    @PrePersist
    public void onCreate(){
        fechaCreacionProductoColor = LocalDateTime.now();
    }

    @PreUpdate
    public void onUpdate(){
        fechaModificacionProductoColor = LocalDateTime.now();
    }
}