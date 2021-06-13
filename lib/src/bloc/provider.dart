import 'package:flutter/material.dart';
import 'login_bloc.dart';
export 'login_bloc.dart';


class Provider extends InheritedWidget{

  static Provider _instancia;

  // ignore: missing_return
  factory Provider({Key key, Widget child}){
    // si deseo utilizar una nueva o la que está
    if(_instancia == null){
      _instancia = new Provider._internal(key: key,child: child);
    }
    return _instancia;
  }

  Provider._internal({Key key, Widget child})
  : super(key: key,child: child);

  final loginBloc = LoginBloc();

/*   Provider({Key key, Widget child})
  : super(key: key, child: child); */

  static LoginBloc of(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<Provider>().loginBloc;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}