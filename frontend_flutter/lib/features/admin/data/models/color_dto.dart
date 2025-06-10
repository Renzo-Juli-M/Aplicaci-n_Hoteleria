class ColorDto {
  final String? nombre;

  ColorDto({this.nombre});

  factory ColorDto.fromJson(Map<String, dynamic> json) {
    return ColorDto(
      nombre: json['nombre'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
    };
  }
}