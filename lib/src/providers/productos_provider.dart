import 'dart:convert';
import 'package:blocpattern/src/models/producto_model.dart';
import 'package:http/http.dart' as http;
import 'dart:core';
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';
import 'dart:io';

class ProductosProvider{
  final String _url = 'proyecto1-3b4fb-default-rtdb.firebaseio.com';

  Future<bool> crearProducto(ProductoModel producto )
   async{

    final url = Uri.https(_url,'/productos.json');

    final resp = await http.post(

      url,
      body: productoModelToJson(producto));

    final decodeData = json.decode(resp.body);

    print(decodeData);

    return true;

  }

    Future<bool> editarProducto(ProductoModel producto )
   async{

    final url = Uri.https(_url,'/productos/${producto.id}.json');

    final resp = await http.put(

      url,
      body: productoModelToJson(producto));

    final decodeData = json.decode(resp.body);

    print(decodeData);

    return true;

  }

  Future <List<ProductoModel>> cargarProductos () async{

      final url = Uri.https(_url,'/productos.json');
      final resp = await http.get(url);

      /* final decodeData = json.decode(resp.body); */
      final Map<String, dynamic> decodeData = json.decode(resp.body);
      final List<ProductoModel> productos = new List();

      if (decodeData == null) return [];

      decodeData.forEach((id, prod) { 
        //print(producto);
        final prodTemp = ProductoModel.fromJson(prod);
        prodTemp.id = id;
        productos.add(prodTemp);
      });

      print(productos);

      return productos;

  }

  Future<int> borrarProducto(String id)async{
    final url = Uri.https(_url,'/productos/$id.json');
    final resp = await http.delete(url);

    print(json.decode(resp.body));

    return 1;
  }

  Future<String> subirImagen(File imagen)async{
    final url = Uri.parse('https://@api.cloudinary.com/v1_1/miguel-company/image/upload?upload_preset=fo560rzy');
    final mimeType = mime(imagen.path).split('/'); //imagen/jpeg

    final imageUploadRequest = http.MultipartRequest(
      'POST',
      url
    );
    final file = await http.MultipartFile.fromPath(
      'file', 
      imagen.path,
      contentType: MediaType(
        mimeType[0],mimeType[1])
      );
      imageUploadRequest.files.add(file);

      final streamResponse = await imageUploadRequest.send();
      final resp = await http.Response.fromStream(streamResponse);

      if (resp.statusCode != 200 && resp.statusCode != 201){
        print('algo salio mal');
        print(resp.body);
        return null;
      }

      final respData = json.decode(resp.body);

      print(respData);

      return respData['secure_url'];
  }
}