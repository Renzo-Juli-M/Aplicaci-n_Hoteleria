package pe.edu.upeu.infotelspringboot.model.dto;

import lombok.Data;

import java.util.Map;

@Data
public class DashboardAdminDto {
    private Long totalCategorias;
    private Long totalProductos;
    private Long totalColores;
    private Long totalUsuarios;
    private Map<String, Long> productosPorCategoria;
    private Map<String, Long> usuariosPorRol;
}