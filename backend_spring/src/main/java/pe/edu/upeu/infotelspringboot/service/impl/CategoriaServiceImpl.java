package pe.edu.upeu.infotelspringboot.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import pe.edu.upeu.infotelspringboot.model.dto.CategoriaDto;
import pe.edu.upeu.infotelspringboot.model.entity.Categoria;
import pe.edu.upeu.infotelspringboot.repository.CategoriaRepository;
import pe.edu.upeu.infotelspringboot.service.CategoriaService;

import java.io.File;
import java.io.IOException;
import java.util.List;

@Service
public class CategoriaServiceImpl implements CategoriaService {
    @Autowired
    private CategoriaRepository categoriaRepository;

    @Override
    public List<Categoria> buscarCategorias() {
        return categoriaRepository.findAll();
    }

    @Override
    public Categoria buscarCategoriaPorId(Long idCategoria) {
        return categoriaRepository.findById(idCategoria).orElseThrow(
                () -> new RuntimeException("Categoria con id "+idCategoria+" no encontrada")
        );
    }

    @Override
    public Categoria insertarCategoria(CategoriaDto categoriaDto, MultipartFile file) {
        Categoria categoriaCreada = new Categoria();
        categoriaCreada.setNombre(categoriaDto.getNombre());
        categoriaCreada.setDescripcion(categoriaDto.getDescripcion());

        if (file != null && !file.isEmpty()) {
            String fileName = saveFile(file);
            categoriaCreada.setIconoUrl(fileName);
        }

        return categoriaRepository.save(categoriaCreada);
    }

    @Override
    public Categoria actualizarCategoria(Long idCategoria, CategoriaDto categoriaDto, MultipartFile file) {
        Categoria categoriaActualizada = categoriaRepository.findById(idCategoria).orElseThrow(
                () -> new RuntimeException("Categoria con id "+idCategoria+" no encontrada")
        );

        categoriaActualizada.setNombre(categoriaDto.getNombre());
        categoriaActualizada.setDescripcion(categoriaDto.getDescripcion());

        if (file != null && !file.isEmpty()) {
            String fileName = saveFile(file);
            categoriaActualizada.setIconoUrl(fileName);
        }

        return categoriaRepository.save(categoriaActualizada);
    }

    @Override
    public void eliminarCategoria(Long idCategoria) {
        categoriaRepository.deleteById(idCategoria);
    }

    @Override
    public List<Categoria> buscarCategoriasPorNombre(String nombre) {
        return categoriaRepository.buscarPorNombre(nombre);
    }

    private static final String UPLOAD_DIR = System.getProperty("user.dir") + "/upload/";

    private String saveFile(MultipartFile file) {
        try {
            // Log: ruta donde se intentará guardar el archivo
            System.out.println("UPLOAD_DIR: " + UPLOAD_DIR);

            // Verificamos si la carpeta existe
            File uploadPath = new File(UPLOAD_DIR);
            if (!uploadPath.exists()) {
                boolean created = uploadPath.mkdirs();
                System.out.println("¿Se creó el directorio upload?: " + created);
            }

            // Log: nombre original del archivo recibido
            System.out.println("Archivo recibido: " + file.getOriginalFilename());

            // Crear nombre de archivo único
            String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
            File destinationFile = new File(uploadPath, fileName);

            // Transferencia del archivo
            file.transferTo(destinationFile);

            // Log: confirmación de que se guardó
            System.out.println("Archivo guardado exitosamente en: " + destinationFile.getAbsolutePath());

            return fileName;
        } catch (IOException e) {
            System.err.println("Error al guardar la imagen: " + e.getMessage());
            throw new RuntimeException("Error al guardar la imagen", e);
        }
    }
}
