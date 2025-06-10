package pe.edu.upeu.infotelspringboot.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pe.edu.upeu.infotelspringboot.model.dto.ColorDto;
import pe.edu.upeu.infotelspringboot.model.entity.Color;
import pe.edu.upeu.infotelspringboot.repository.ColorRepository;
import pe.edu.upeu.infotelspringboot.service.ColorService;

import java.util.List;

@Service
public class ColorServiceImpl implements ColorService {

    @Autowired
    private ColorRepository colorRepository;

    @Override
    public List<Color> obtenerColores() {
        return colorRepository.findAll();
    }

    @Override
    public Color obtenerColorPorId(Long idColor) {
        return colorRepository.findById(idColor)
                .orElseThrow(() -> new RuntimeException("Color con id " + idColor + " no encontrado"));
    }

    @Override
    public Color agregarColor(ColorDto colorDto) {
        Color color = new Color();
        color.setNombre(colorDto.getNombre());
        return colorRepository.save(color);
    }

    @Override
    public Color actualizarColor(Long idColor, ColorDto colorDto) {
        Color color = colorRepository.findById(idColor)
                .orElseThrow(() -> new RuntimeException("Color con id " + idColor + " no encontrado"));

        color.setNombre(colorDto.getNombre());
        return colorRepository.save(color);
    }

    @Override
    public void eliminarColor(Long idColor) {
        if (!colorRepository.existsById(idColor)) {
            throw new RuntimeException("Color con id " + idColor + " no encontrado");
        }
        colorRepository.deleteById(idColor);
    }

    @Override
    public List<Color> buscarColoresPorNombre(String nombre) {
        return colorRepository.buscarPorNombre(nombre);
    }
}