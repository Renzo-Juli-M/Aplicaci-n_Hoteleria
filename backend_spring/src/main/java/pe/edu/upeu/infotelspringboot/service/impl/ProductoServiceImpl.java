package pe.edu.upeu.infotelspringboot.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import pe.edu.upeu.infotelspringboot.model.dto.ProductoDto;
import pe.edu.upeu.infotelspringboot.model.entity.Categoria;
import pe.edu.upeu.infotelspringboot.model.entity.Color;
import pe.edu.upeu.infotelspringboot.model.entity.Producto;
import pe.edu.upeu.infotelspringboot.model.entity.ProductoColor;
import pe.edu.upeu.infotelspringboot.repository.CategoriaRepository;
import pe.edu.upeu.infotelspringboot.repository.ColorRepository;
import pe.edu.upeu.infotelspringboot.repository.ProductoRepository;
import pe.edu.upeu.infotelspringboot.service.ProductoService;

import java.io.File;
import java.io.IOException;
import java.util.List;

@Service
public class ProductoServiceImpl implements ProductoService {

    @Autowired
    private ProductoRepository productoRepository;

    @Autowired
    private CategoriaRepository categoriaRepository;

    @Autowired
    private ColorRepository colorRepository;

    private static final String UPLOAD_DIR = System.getProperty("user.dir") + "/upload/";

    @Override
    public List<Producto> obtenerProductos() {
        return productoRepository.findAll();
    }

    @Override
    public Producto obtenerProductoPorId(Long id) {
        return productoRepository.findById(id).orElseThrow(
                () -> new RuntimeException("Producto con id " + id + " no encontrado")
        );
    }

    @Override
    public Producto agregarProducto(ProductoDto productoDto, MultipartFile file) {
        Producto producto = new Producto();
        producto.setNombre(productoDto.getNombre());
        producto.setDescripcion(productoDto.getDescripcion());
        producto.setTallas(productoDto.getTallas());
        producto.setMaterial(productoDto.getMaterial());
        producto.setPrecio(productoDto.getPrecio());
        producto.setStock(productoDto.getStock());

        Categoria categoriaEncontrada = categoriaRepository
                .findByNombre(productoDto.getNombreCategoria())
                .orElseThrow(() -> new RuntimeException("Categoria con nombre " + productoDto.getNombreCategoria() + " no encontrada"));
        producto.setCategoria(categoriaEncontrada);

        // Manejo de imagen
        if (file != null && !file.isEmpty()) {
            String fileName = saveFile(file);
            producto.setImagenUrl(fileName);
        }

        // Guardamos el producto primero (para que tenga ID si es necesario)
        productoRepository.save(producto);

        // Asignar los colores
        if (productoDto.getNombresColores() != null && !productoDto.getNombresColores().isEmpty()) {
            List<Color> colores = colorRepository.findByNombreIn(productoDto.getNombresColores());

            if (colores.size() != productoDto.getNombresColores().size()) {
                throw new RuntimeException("Algunos colores no fueron encontrados");
            }

            for (Color color : colores) {
                ProductoColor productoColor = new ProductoColor();
                productoColor.setProducto(producto);
                productoColor.setColor(color);
                producto.getProductoColores().add(productoColor);
            }
        }

        return productoRepository.save(producto);
    }

    @Override
    public Producto actualizarProducto(Long idProducto, ProductoDto productoDto, MultipartFile file) {
        Producto producto = productoRepository.findById(idProducto)
                .orElseThrow(() -> new RuntimeException("Producto con id " + idProducto + " no encontrado"));

        producto.setNombre(productoDto.getNombre());
        producto.setDescripcion(productoDto.getDescripcion());
        producto.setTallas(productoDto.getTallas());
        producto.setMaterial(productoDto.getMaterial());
        producto.setPrecio(productoDto.getPrecio());
        producto.setStock(productoDto.getStock());

        // Actualizar categoría
        Categoria categoriaEncontrada = categoriaRepository
                .findByNombre(productoDto.getNombreCategoria())
                .orElseThrow(() -> new RuntimeException("Categoria con nombre " + productoDto.getNombreCategoria() + " no encontrada"));
        producto.setCategoria(categoriaEncontrada);

        // Actualizar imagen si se envía nueva
        if (file != null && !file.isEmpty()) {
            String fileName = saveFile(file);
            producto.setImagenUrl(fileName);
        }

        // Actualizar colores
        // Primero limpiar la lista de ProductoColor existentes (y con orphanRemoval = true se borran de la BD)
        producto.getProductoColores().clear();

        if (productoDto.getNombresColores() != null && !productoDto.getNombresColores().isEmpty()) {
            List<Color> colores = colorRepository.findByNombreIn(productoDto.getNombresColores());

            if (colores.size() != productoDto.getNombresColores().size()) {
                throw new RuntimeException("Algunos colores no fueron encontrados");
            }

            for (Color color : colores) {
                ProductoColor productoColor = new ProductoColor();
                productoColor.setProducto(producto);
                productoColor.setColor(color);
                producto.getProductoColores().add(productoColor);
            }
        }

        return productoRepository.save(producto);
    }

    @Override
    public void eliminarProducto(Long idProducto) {
        productoRepository.deleteById(idProducto);
    }

    @Override
    public List<Producto> buscarProductosPorNombre(String nombre) {
        return productoRepository.buscarPorNombre(nombre);
    }

    private String saveFile(MultipartFile file) {
        try {
            System.out.println("UPLOAD_DIR: " + UPLOAD_DIR);
            File uploadPath = new File(UPLOAD_DIR);
            if (!uploadPath.exists()) {
                boolean created = uploadPath.mkdirs();
                System.out.println("¿Se creó el directorio upload?: " + created);
            }

            System.out.println("Archivo recibido: " + file.getOriginalFilename());

            String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
            File destinationFile = new File(uploadPath, fileName);
            file.transferTo(destinationFile);

            System.out.println("Archivo guardado exitosamente en: " + destinationFile.getAbsolutePath());

            return fileName;
        } catch (IOException e) {
            System.err.println("Error al guardar la imagen: " + e.getMessage());
            throw new RuntimeException("Error al guardar la imagen", e);
        }
    }
}