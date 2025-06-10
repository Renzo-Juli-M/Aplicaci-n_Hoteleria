import 'dart:io';

import 'package:infotel_flutter/features/admin/data/models/usuario_completo_dto.dart';
import 'package:infotel_flutter/features/admin/data/models/usuario_completo_response.dart';
import 'package:infotel_flutter/features/admin/domain/repositories/usuario_repository.dart';

class UpdateUsuarioUseCase {
  final UsuarioRepository repository;

  UpdateUsuarioUseCase(this.repository);

  Future<UsuarioCompletoResponse> call(int id, UsuarioCompletoDto usuario, File? imagen) {
    return repository.putUsuarioCompleto(id, usuario, imagen);
  }
}