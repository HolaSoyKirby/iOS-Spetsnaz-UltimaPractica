import 'dart:async';

import 'package:blocpattern/src/bloc/provider.dart';
import 'package:blocpattern/src/models/producto_model.dart';
import 'package:blocpattern/src/providers/productos_provider.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}



class _HomePage extends State<HomePage> {
  final productosProvider = new ProductosProvider();
  Future<List<ProductoModel>> allProducts;

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('home'),
      ),
      body: _crearListado(),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.deepPurple,
      onPressed: () => Navigator.pushNamed(context, 'producto'),
    );
  }

  Widget _crearListado() {
    allProducts = productosProvider.cargarProductos();
    return FutureBuilder(
      future: allProducts,
      builder:(BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
        if (snapshot.hasData) {
          final productos = snapshot.data;

          return RefreshIndicator(
            child: ListView.builder(
              itemCount: productos.length,
              itemBuilder: (contex, i) => _crearItem(context, productos[i])),
              
            onRefresh: _pullRefresh);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Future<void> _pullRefresh() async {
    setState(() {
      allProducts = Future.value([]);
    });
    Completer<Null> completer = new Completer<Null>();
    Timer timer = new Timer(new Duration(seconds: 3), () {
      setState((){
        allProducts = productosProvider.cargarProductos();
      });
      completer.complete();  
    });
    return completer.future;
  }

  Widget _crearItem(BuildContext context, ProductoModel producto) {

    var shownImage = (producto.fotoUrl == null)
                  ? Image(image: AssetImage('assets/no-image.png'))
                  : FadeInImage(
                      image: NetworkImage(producto.fotoUrl),
                      placeholder: AssetImage('assets/jar-loading.gif'),
                      height: 100.0,
                      width: 150.0,
                      fit: BoxFit.cover,
                    );



    return Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
        ),
        onDismissed: (direccion) {
          productosProvider.borrarProducto(producto.id);
        },
        /*child: Card(
          child: Column(
            children: <Widget>[
              (producto.fotoUrl == null)
                  ? Image(image: AssetImage('assets/no-image.png'))
                  : FadeInImage(
                      image: NetworkImage(producto.fotoUrl),
                      placeholder: AssetImage('assets/jar-loading.gif'),
                      height: 300.0,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
              ListTile(
                title: Text('${producto.titulo} -${producto.valor}'),
                subtitle: Text(producto.id),
                /* onTap: ()=>Navigator.pushNamed(context, 'producto'), */
                onTap: () => Navigator.pushNamed(context, 'producto',
                    arguments: producto),
              )
            ],
          ),
        ));*/

        child: Card(
          child: ListTile(
            leading: shownImage,
            title: Text('${producto.titulo}'),
            subtitle: Text('Precio:${producto.valor}'),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
            onTap: () => Navigator.pushNamed(context, 'producto',
                    arguments: producto),
          ),
        ),
        );
  }
}
/* 
*/