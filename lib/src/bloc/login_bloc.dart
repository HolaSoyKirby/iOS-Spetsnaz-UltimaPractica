import 'dart:async';
import 'package:blocpattern/src/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';


class LoginBloc with Validators{
  // stream nos va a servir para controlar flujo y cambios en las propiedades de niveles bajos
  /* 
  final _emailController = StreamController<String>.broadcast();
  final _passwordController = StreamController<String>.broadcast(); */
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  Stream<String>get emailStream => _emailController.stream.transform(validarEmail);
  Stream<String>get passwordStream => _passwordController.stream.transform(validarPassword);

  //Neceitamos reactive extension (no existen los stream)
  Stream<bool> get formValidStream => Rx.combineLatest2(emailStream,passwordStream,(e,p)=>true);

  Function(String) get changeEmail => _emailController.sink.add; // crear un referencia
  Function(String) get changePassword => _passwordController.sink.add; // crear un referencia

  // obtener ultimo valor de streams
  String get email => _emailController.value;
  String get password => _passwordController.value;

  dispose(){
    _emailController?.close();
    _passwordController?.close();
  }
}