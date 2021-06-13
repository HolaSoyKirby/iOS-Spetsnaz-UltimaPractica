import 'dart:async';

class Validators{
  final validarEmail = StreamTransformer<String,String>.fromHandlers(
    handleData: (email,sink){
      Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp = new RegExp(pattern);

      if(regExp.hasMatch(email)){
        // debemos dejar fluir la data si es correcta
        sink.add(email);
      }
      else{
        sink.addError('email incorrecto');
      }
    }
  );
  final validarPassword =  StreamTransformer<String,String>.fromHandlers(
    handleData: (password,sink){
      if(password.length >= 6){
        sink.add(password);
      }else{
        sink.addError('Necesita una contraseña más larga');
      }
    }
  );
}