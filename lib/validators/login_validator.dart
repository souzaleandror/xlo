import 'dart:async';

import 'package:xlo/blocs/login/field_state.dart';

class LoginValidator {
  final StreamTransformer<String, FieldState> emailValidator =
      StreamTransformer<String, FieldState>.fromHandlers(
          handleData: (email, sink) {
    const Pattern pattern =
        r"^(([^<>()[\]\\.,;:\s@\']+(\.[^<>()[\]\\.,;:\s@\']+)*)|(\'.+\'))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$";

    final RegExp regex = RegExp(pattern);

    if (email.isEmpty) {
      sink.add(FieldState(error: "Campo Obrigatorio"));
    } else if (!regex.hasMatch(email)) {
      sink.add(FieldState(error: "Email Invalido"));
    } else {
      sink.add(FieldState());
    }
  });
  final StreamTransformer<String, FieldState> passValidator =
      StreamTransformer<String, FieldState>.fromHandlers(
          handleData: (pass, sink) {
    if (pass.isEmpty) {
      sink.add(FieldState(error: "Campo Obrigatorio"));
    } else {
      sink.add(FieldState());
    }
  });
}
