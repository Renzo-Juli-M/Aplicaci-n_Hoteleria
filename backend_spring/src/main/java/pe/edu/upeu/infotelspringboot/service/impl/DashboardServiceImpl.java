package pe.edu.upeu.infotelspringboot.service.impl;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pe.edu.upeu.infotelspringboot.model.dto.DashboardAdminDto;
import pe.edu.upeu.infotelspringboot.repository.CategoriaRepository;
import pe.edu.upeu.infotelspringboot.repository.ColorRepository;
import pe.edu.upeu.infotelspringboot.repository.ProductoRepository;
import pe.edu.upeu.infotelspringboot.repository.UsuarioRepository;
import pe.edu.upeu.infotelspringboot.service.DashboardService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class DashboardServiceImpl implements DashboardService {

    @Autowired
    private CategoriaRepository categoriaRepository;

    @Autowired
    private ProductoRepository productoRepository;

    @Autowired
    private ColorRepository colorRepository;

    @Autowired
    private UsuarioRepository usuarioRepository;

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public DashboardAdminDto obtenerResumenAdmin() {
        DashboardAdminDto dto = new DashboardAdminDto();

        dto.setTotalCategorias(categoriaRepository.count());
        dto.setTotalProductos(productoRepository.count());
        dto.setTotalColores(colorRepository.count());
        dto.setTotalUsuarios(usuarioRepository.count());

        dto.setProductosPorCategoria(getProductosPorCategoria());
        dto.setUsuariosPorRol(getUsuariosPorRol());

        return dto;
    }

    private Map<String, Long> getProductosPorCategoria() {
        List<Object[]> results = entityManager.createQuery(
                        "SELECT p.categoria.nombre, COUNT(p) FROM Producto p GROUP BY p.categoria.nombre", Object[].class)
                .getResultList();

        Map<String, Long> resultMap = new HashMap<>();
        for (Object[] row : results) {
            resultMap.put((String) row[0], (Long) row[1]);
        }
        return resultMap;
    }

    private Map<String, Long> getUsuariosPorRol() {
        List<Object[]> results = entityManager.createQuery(
                        "SELECT u.rol.nombre, COUNT(u) FROM Usuario u GROUP BY u.rol.nombre", Object[].class)
                .getResultList();

        Map<String, Long> resultMap = new HashMap<>();
        for (Object[] row : results) {
            resultMap.put((String) row[0], (Long) row[1]);
        }
        return resultMap;
    }
}