package pe.edu.upeu.infotelspringboot.model.dto;

import lombok.Data;

import java.util.List;

@Data
public class ProductoDto {
    private String nombre;
    private String descripcion;
    private String tallas;
    private String material;
    private Double precio;
    private Integer stock;
    private String nombreCategoria;
    private List<String> nombresColores;
}
