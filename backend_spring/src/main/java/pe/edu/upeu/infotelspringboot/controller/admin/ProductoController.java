package pe.edu.upeu.infotelspringboot.controller.admin;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import pe.edu.upeu.infotelspringboot.model.dto.ProductoDto;
import pe.edu.upeu.infotelspringboot.model.entity.Producto;
import pe.edu.upeu.infotelspringboot.service.ProductoService;

import java.util.List;

@RestController
@RequestMapping("/admin/producto")
public class ProductoController {

    @Autowired
    private ProductoService productoService;

    @GetMapping
    public ResponseEntity<List<Producto>> listarProductos() {
        return ResponseEntity.ok(productoService.obtenerProductos());
    }

    @GetMapping("/{idProducto}")
    public ResponseEntity<Producto> buscarProductoPorId(@PathVariable Long idProducto) {
        return ResponseEntity.ok(productoService.obtenerProductoPorId(idProducto));
    }

    @PostMapping
    public ResponseEntity<Producto> crearProducto(
            @RequestPart("producto") String productoJson,
            @RequestPart(value = "file", required = false) MultipartFile file) {
        try {
            ObjectMapper objectMapper = new ObjectMapper();
            ProductoDto productoDto = objectMapper.readValue(productoJson, ProductoDto.class);
            Producto nuevoProducto = productoService.agregarProducto(productoDto, file);
            return ResponseEntity.status(HttpStatus.CREATED).body(nuevoProducto);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @PutMapping("/{idProducto}")
    public ResponseEntity<Producto> actualizarProducto(
            @PathVariable Long idProducto,
            @RequestPart("producto") String productoJson,
            @RequestPart(value = "file", required = false) MultipartFile file) {
        try {
            ObjectMapper objectMapper = new ObjectMapper();
            ProductoDto productoDto = objectMapper.readValue(productoJson, ProductoDto.class);
            Producto productoActualizado = productoService.actualizarProducto(idProducto, productoDto, file);
            return ResponseEntity.ok(productoActualizado);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @DeleteMapping("/{idProducto}")
    public ResponseEntity<String> eliminarProducto(@PathVariable Long idProducto) {
        try {
            productoService.eliminarProducto(idProducto);
            return ResponseEntity.ok("Producto eliminado correctamente");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error al eliminar el producto");
        }
    }

    @GetMapping("/buscar")
    public ResponseEntity<List<Producto>> buscarPorNombre(@RequestParam String nombre) {
        return ResponseEntity.ok(productoService.buscarProductosPorNombre(nombre));
    }
}