import 'dart:convert';

// Recibe json en forma de string y regresa nueva instancia del modelo
ProductoModel productoModelFromJson(String str) =>
    ProductoModel.fromJson(json.decode(str));

// toma el modelo y lo modela como json
String productoModelToJson(ProductoModel data) => json.encode(data.toJson());

class ProductoModel {
  ProductoModel({
    this.id,
    this.titulo = '',
    this.valor = 0.0,
    this.disponible = true,
    this.fotoUrl,
  });

  String id;
  String titulo;
  var valor;
  bool disponible;
  String fotoUrl;

  // Recibe mapa y regresa nueva intancia por eso factory
  factory ProductoModel.fromJson(Map<String, dynamic> json) => ProductoModel(
        id: json["id"],
        titulo: json["titulo"],
        valor: json["valor"],
        disponible: json["disponible"],
        fotoUrl: json["fotoURL"],
      );

  // toma el modelo y lo transforma a json
  Map<String, dynamic> toJson() => {
        //"id": id,
        "titulo": titulo,
        "valor": valor,
        "disponible": disponible,
        "fotoURL": fotoUrl,
      };
}
