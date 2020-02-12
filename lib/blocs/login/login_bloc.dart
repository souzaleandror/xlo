import 'package:rxdart/rxdart.dart';
import 'package:xlo/blocs/login/field_state.dart';
import 'package:xlo/validators/login_validator.dart';

class LoginBloc with LoginValidator {
  final BehaviorSubject<String> _emailController = BehaviorSubject<String>();
  final BehaviorSubject<String> _passController = BehaviorSubject<String>();

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePass => _passController.sink.add;

  Stream<FieldState> get outEmail =>
      _emailController.stream.transform(emailValidator);
  Stream<FieldState> get outPass =>
      _emailController.stream.transform(passValidator);

  void dispose() {
    _emailController.close();
    _passController.close();
  }
}
