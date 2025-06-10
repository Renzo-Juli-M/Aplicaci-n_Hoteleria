package pe.edu.upeu.infotelspringboot.util.dataLoaders;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.CommandLineRunner;
import org.springframework.core.annotation.Order;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;
import pe.edu.upeu.infotelspringboot.model.entity.Persona;
import pe.edu.upeu.infotelspringboot.model.entity.Rol;
import pe.edu.upeu.infotelspringboot.model.entity.Usuario;
import pe.edu.upeu.infotelspringboot.model.enums.EstadoCuenta;
import pe.edu.upeu.infotelspringboot.repository.PersonaRepository;
import pe.edu.upeu.infotelspringboot.repository.RolRepository;
import pe.edu.upeu.infotelspringboot.repository.UsuarioRepository;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Order(7)
@Component
@RequiredArgsConstructor
public class UsuarioDataLoader implements CommandLineRunner {

    private final UsuarioRepository usuarioRepository;
    private final RolRepository rolRepository;
    private final PersonaRepository personaRepository;
    private final PasswordEncoder passwordEncoder;

    @Override
    @Transactional
    public void run(String... args) {
        if (usuarioRepository.findByUsername("admin").isEmpty()) {

            // Crear roles si no existen (como antes)
            Rol rolAdmin = rolRepository.findByNombre("ROLE_ADMIN").orElseGet(() -> {
                Rol nuevoRol = new Rol();
                nuevoRol.setNombre("ROLE_ADMIN");
                return rolRepository.save(nuevoRol);
            });

            Rol rolUsuario = rolRepository.findByNombre("ROLE_USUARIO").orElseGet(() -> {
                Rol nuevoRol = new Rol();
                nuevoRol.setNombre("ROLE_USUARIO");
                return rolRepository.save(nuevoRol);
            });

            // Crear persona para admin
            Persona personaAdmin = new Persona();
            personaAdmin.setNombres("Admin");
            personaAdmin.setApellidos("Principal");
            personaAdmin.setTipoDocumento("DNI");
            personaAdmin.setNumeroDocumento("12345678");
            personaAdmin.setTelefono("1234567890");
            personaAdmin.setDireccion("Jr. callefalsa");
            personaAdmin.setCorreoElectronico("admin@gmail.com");
            personaAdmin.setFotoPerfil("persona1.jpg");
            personaAdmin.setFechaNacimiento(LocalDate.of(1990, 1, 1));
            personaRepository.save(personaAdmin);

            // Crear usuario admin
            Usuario usuarioAdmin = new Usuario();
            usuarioAdmin.setUsername("admin");
            usuarioAdmin.setPassword(passwordEncoder.encode("Password123!admin"));
            usuarioAdmin.setRol(rolAdmin);
            usuarioAdmin.setPersona(personaAdmin);
            usuarioAdmin.setEstado(EstadoCuenta.ACTIVO);
            usuarioAdmin.setFechaCreacionUsuario(LocalDateTime.now());
            usuarioRepository.save(usuarioAdmin);

            // Crear persona para usuario
            Persona personaUsuario = new Persona();
            personaUsuario.setNombres("Usuario");
            personaUsuario.setApellidos("Principal");
            personaUsuario.setTipoDocumento("DNI");
            personaUsuario.setNumeroDocumento("87654321");
            personaUsuario.setTelefono("1234567891");
            personaUsuario.setDireccion("Av. ejemplo");
            personaUsuario.setCorreoElectronico("usuario@gmail.com");
            personaUsuario.setFotoPerfil("persona2.jpg");
            personaUsuario.setFechaNacimiento(LocalDate.of(1995, 2, 2));
            personaRepository.save(personaUsuario);

            // Crear usuario
            Usuario usuario = new Usuario();
            usuario.setUsername("usuario");
            usuario.setPassword(passwordEncoder.encode("Password123!usuario"));
            usuario.setRol(rolUsuario);
            usuario.setPersona(personaUsuario);
            usuario.setEstado(EstadoCuenta.ACTIVO);
            usuario.setFechaCreacionUsuario(LocalDateTime.now());
            usuarioRepository.save(usuario);

            System.out.println("Usuarios creados: admin, usuario");
        } else {
            System.out.println("El usuario admin ya existe.");
        }
    }
}