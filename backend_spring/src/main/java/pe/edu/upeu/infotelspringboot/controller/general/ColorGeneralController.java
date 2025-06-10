package pe.edu.upeu.infotelspringboot.controller.general;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import pe.edu.upeu.infotelspringboot.model.entity.Color;
import pe.edu.upeu.infotelspringboot.service.ColorService;

@RestController
@RequestMapping("/general/color")
public class ColorGeneralController {

    @Autowired
    private ColorService colorService;

    @GetMapping("/{idColor}")
    public ResponseEntity<Color> buscarColorPorId(
            @PathVariable("idColor") Long idColor
    ){
        return ResponseEntity.ok(colorService.obtenerColorPorId(idColor));
    }
}
