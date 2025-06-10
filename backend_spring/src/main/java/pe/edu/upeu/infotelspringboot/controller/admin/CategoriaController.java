package pe.edu.upeu.infotelspringboot.controller.admin;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import pe.edu.upeu.infotelspringboot.model.dto.CategoriaDto;
import pe.edu.upeu.infotelspringboot.model.entity.Categoria;
import pe.edu.upeu.infotelspringboot.service.CategoriaService;

import java.util.List;

@RestController
@RequestMapping("/admin/categoria")
public class CategoriaController {

    @Autowired
    private CategoriaService categoriaService;

    @GetMapping
    public ResponseEntity<List<Categoria>> listarCategorias() {
        return ResponseEntity.ok(categoriaService.buscarCategorias());
    }

    @GetMapping("/{idCategoria}")
    public ResponseEntity<Categoria> buscarCategoriaPorId(@PathVariable Long idCategoria) {
        return ResponseEntity.ok(categoriaService.buscarCategoriaPorId(idCategoria));
    }

    @PostMapping
    public ResponseEntity<Categoria> crearCategoria(
            @RequestPart("categoria") String categoriaJson,
            @RequestPart(value = "file", required = false) MultipartFile file) {
        try {
            ObjectMapper objectMapper = new ObjectMapper();
            CategoriaDto categoriaDto = objectMapper.readValue(categoriaJson, CategoriaDto.class);
            Categoria nuevaCategoria = categoriaService.insertarCategoria(categoriaDto, file);
            return ResponseEntity.status(HttpStatus.CREATED).body(nuevaCategoria);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @PutMapping("/{idCategoria}")
    public ResponseEntity<Categoria> actualizarCategoria(
            @PathVariable Long idCategoria,
            @RequestPart("categoria") String categoriaJson,
            @RequestPart(value = "file", required = false) MultipartFile file) {
        try {
            ObjectMapper objectMapper = new ObjectMapper();
            CategoriaDto categoriaDto = objectMapper.readValue(categoriaJson, CategoriaDto.class);
            Categoria categoriaActualizada = categoriaService.actualizarCategoria(idCategoria, categoriaDto, file);
            return ResponseEntity.ok(categoriaActualizada);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @DeleteMapping("/{idCategoria}")
    public ResponseEntity<String> eliminarCategoria(@PathVariable Long idCategoria) {
        try {
            categoriaService.eliminarCategoria(idCategoria);
            return ResponseEntity.ok("Categoría eliminada correctamente");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error al eliminar la categoría");
        }
    }

    @GetMapping("/buscar")
    public ResponseEntity<List<Categoria>> buscarPorNombre(@RequestParam String nombre) {
        return ResponseEntity.ok(categoriaService.buscarCategoriasPorNombre(nombre));
    }
}
