import 'dart:io';

import 'package:infotel_flutter/features/admin/data/models/usuario_completo_dto.dart';
import 'package:infotel_flutter/features/admin/data/models/usuario_completo_response.dart';

abstract class UsuarioRepository {
  Future<List<UsuarioCompletoResponse>> getUsuariosCompleto();
  Future<UsuarioCompletoResponse> getUsuarioCompletoById(int id);
  Future<UsuarioCompletoResponse> postUsuarioCompleto(UsuarioCompletoDto usuario, File? imagen);
  Future<UsuarioCompletoResponse> putUsuarioCompleto(int id, UsuarioCompletoDto usuario, File? imagen);
  Future<void> deleteUsuarioCompleto(int id);
  Future<List<UsuarioCompletoResponse>> buscarUsuariosCompletosPorNombre(String username);
}
