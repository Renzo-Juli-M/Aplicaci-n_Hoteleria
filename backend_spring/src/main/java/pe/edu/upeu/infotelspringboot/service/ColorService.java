package pe.edu.upeu.infotelspringboot.service;

import pe.edu.upeu.infotelspringboot.model.dto.ColorDto;
import pe.edu.upeu.infotelspringboot.model.entity.Color;

import java.util.List;

public interface ColorService {
    public List<Color> obtenerColores();
    public Color obtenerColorPorId(Long idColor);
    public Color agregarColor(ColorDto colorDto);
    public Color actualizarColor(Long idColor, ColorDto colorDto);
    public void eliminarColor(Long idColor);
    public List<Color> buscarColoresPorNombre(String nombre);
}
