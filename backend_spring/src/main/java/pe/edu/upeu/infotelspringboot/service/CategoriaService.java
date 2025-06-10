package pe.edu.upeu.infotelspringboot.service;

import org.springframework.web.multipart.MultipartFile;
import pe.edu.upeu.infotelspringboot.model.dto.CategoriaDto;
import pe.edu.upeu.infotelspringboot.model.entity.Categoria;

import java.util.List;

public interface CategoriaService {
    public List<Categoria> buscarCategorias();
    public Categoria buscarCategoriaPorId(Long idCategoria);
    public Categoria insertarCategoria(CategoriaDto categoriaDto, MultipartFile file);
    public Categoria actualizarCategoria(Long idCategoria, CategoriaDto categoriaDto, MultipartFile file);
    public void eliminarCategoria(Long idCategoria);
    public List<Categoria> buscarCategoriasPorNombre(String nombre);
}
