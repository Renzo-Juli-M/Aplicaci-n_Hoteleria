package pe.edu.upeu.infotelspringboot.controller.general;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import pe.edu.upeu.infotelspringboot.model.entity.Categoria;
import pe.edu.upeu.infotelspringboot.service.CategoriaService;

import java.util.List;

@RestController
@RequestMapping("/general/categoria")
public class CategoriaGeneralController {
    @Autowired
    private CategoriaService categoriaService;

    @GetMapping
    public ResponseEntity<List<Categoria>> obtenerCategorias() {
        return ResponseEntity.ok(categoriaService.buscarCategorias());
    }

    @GetMapping("/{idCategoria}")
    public ResponseEntity<Categoria> obtenerCategoriaPorId(@PathVariable Long idCategoria) {
        return ResponseEntity.ok(categoriaService.buscarCategoriaPorId(idCategoria));
    }
}
