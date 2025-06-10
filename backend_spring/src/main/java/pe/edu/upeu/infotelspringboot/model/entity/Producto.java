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
public class Producto {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idProducto;

    private String nombre;
    private String descripcion;
    private String tallas;
    private String material;
    private Double precio;
    private Integer stock;
    private String imagenUrl;

    @ManyToOne
    @JoinColumn(name = "categoria_id")
    @JsonBackReference
    private Categoria categoria;

    @OneToMany(mappedBy = "producto", cascade = CascadeType.ALL, orphanRemoval = true)
    @JsonManagedReference
    private List<ProductoColor> productoColores = new ArrayList<>();

    private LocalDateTime fechaCreacionProducto;
    private LocalDateTime fechaModificacionProducto;

    @PrePersist
    public void onCreate(){
        fechaCreacionProducto = LocalDateTime.now();
    }

    @PreUpdate
    public void onUpdate(){
        fechaModificacionProducto = LocalDateTime.now();
    }
}