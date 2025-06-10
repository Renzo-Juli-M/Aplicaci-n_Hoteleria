package pe.edu.upeu.infotelspringboot.controller.admin;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import pe.edu.upeu.infotelspringboot.model.dto.ColorDto;
import pe.edu.upeu.infotelspringboot.model.entity.Color;
import pe.edu.upeu.infotelspringboot.service.ColorService;

import java.util.List;

@RestController
@RequestMapping("/admin/color")
public class ColorController {

    @Autowired
    private ColorService colorService;

    @GetMapping
    public ResponseEntity<List<Color>> listarColores() {
        return ResponseEntity.ok(colorService.obtenerColores());
    }

    @GetMapping("/{idColor}")
    public ResponseEntity<Color> obtenerColorPorId(@PathVariable Long idColor) {
        try {
            Color color = colorService.obtenerColorPorId(idColor);
            return ResponseEntity.ok(color);
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
        }
    }

    @PostMapping
    public ResponseEntity<Color> agregarColor(@RequestBody ColorDto colorDto) {
        try {
            Color nuevoColor = colorService.agregarColor(colorDto);
            return ResponseEntity.status(HttpStatus.CREATED).body(nuevoColor);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @PutMapping("/{idColor}")
    public ResponseEntity<Color> actualizarColor(@PathVariable Long idColor, @RequestBody ColorDto colorDto) {
        try {
            Color colorActualizado = colorService.actualizarColor(idColor, colorDto);
            return ResponseEntity.ok(colorActualizado);
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
        }
    }

    @DeleteMapping("/{idColor}")
    public ResponseEntity<String> eliminarColor(@PathVariable Long idColor) {
        try {
            colorService.eliminarColor(idColor);
            return ResponseEntity.ok("Color eliminado correctamente");
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Color no encontrado");
        }
    }

    @GetMapping("/buscar")
    public ResponseEntity<List<Color>> buscarColoresPorNombre(@RequestParam String nombre) {
        List<Color> colores = colorService.buscarColoresPorNombre(nombre);
        return ResponseEntity.ok(colores);
    }
}