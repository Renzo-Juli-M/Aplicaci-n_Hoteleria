package pe.edu.upeu.infotelspringboot.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import pe.edu.upeu.infotelspringboot.model.dto.DashboardAdminDto;
import pe.edu.upeu.infotelspringboot.service.DashboardService;

@RestController
@RequestMapping("/admin/dashboard")
public class DashboardController {

    @Autowired
    private DashboardService dashboardService;

    @GetMapping
    public ResponseEntity<DashboardAdminDto> obtenerDashboard() {
        DashboardAdminDto dto = dashboardService.obtenerResumenAdmin();
        return ResponseEntity.ok(dto);
    }
}