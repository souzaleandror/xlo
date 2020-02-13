import 'package:rxdart/rxdart.dart';
import 'package:xlo/blocs/login/button_state.dart';
import 'package:xlo/blocs/login/field_state.dart';
import 'package:xlo/blocs/login/login_bloc_state.dart';
import 'package:xlo/validators/login_validator.dart';

class LoginBloc with LoginValidator {
  final BehaviorSubject<LoginBlocState> _stateController =
      BehaviorSubject<LoginBlocState>.seeded(
          LoginBlocState(state: LoginState.IDLE));
  final BehaviorSubject<String> _emailController = BehaviorSubject<String>();
  final BehaviorSubject<String> _passController = BehaviorSubject<String>();

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePass => _passController.sink.add;

  Stream<LoginBlocState> get outState => _stateController.stream;

  //Stream<FieldState> get outEmail => _emailController.stream.transform(emailValidator);
  //Stream<FieldState> get outPass => _passController.stream.transform(passValidator);

  Stream<FieldState> get outEmail => Rx.combineLatest2(
          _emailController.stream.transform(emailValidator), outState, (a, b) {
        a.enabled = b.state != LoginState.LOADING;
        return a;
      });

  Stream<FieldState> get outPass => Rx.combineLatest2(
          _passController.stream.transform(passValidator), outState, (a, b) {
        a.enabled = b.state != LoginState.LOADING;
        return a;
      });

  Future<bool> loginWithEmail() async {
    _stateController.add(LoginBlocState(state: LoginState.LOADING));
    await Future.delayed(Duration(seconds: 3));

    _stateController.add(LoginBlocState(state: LoginState.IDLE));
    return true;
  }

  Stream<ButtonState> get outLoginButton =>
      Rx.combineLatest3(outEmail, outPass, outState, (sEmail, sPass, sState) {
        return ButtonState(
            loading: sState.state == LoginState.LOADING,
            enable: sEmail.error == null &&
                sPass.error == null &&
                sState.state != LoginState.LOADING);
      });

  void dispose() {
    _stateController.close();
    _emailController.close();
    _passController.close();
  }

  Future<bool> loginWithFacebook() async {
    _stateController.add(LoginBlocState(state: LoginState.LOADING_FACE));
    await Future.delayed(Duration(seconds: 3));

    _stateController.add(LoginBlocState(state: LoginState.IDLE));
    return true;
  }
}
