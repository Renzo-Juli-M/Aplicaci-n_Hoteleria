package pe.edu.upeu.infotelspringboot.service;

import org.springframework.web.multipart.MultipartFile;
import pe.edu.upeu.infotelspringboot.model.dto.ProductoDto;
import pe.edu.upeu.infotelspringboot.model.entity.Categoria;
import pe.edu.upeu.infotelspringboot.model.entity.Producto;

import java.util.List;

public interface ProductoService {
    public List<Producto> obtenerProductos();
    public Producto obtenerProductoPorId(Long id);
    public Producto agregarProducto(ProductoDto productoDto, MultipartFile file);
    public Producto actualizarProducto(Long idProducto, ProductoDto productoDto, MultipartFile file);
    public void eliminarProducto(Long idProducto);
    public List<Producto> buscarProductosPorNombre(String nombre);
}
