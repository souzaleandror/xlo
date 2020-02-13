import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xlo/blocs/login/field_state.dart';
import 'package:xlo/blocs/login/login_bloc.dart';
import 'package:xlo/screens/login/widgets/facebook_button.dart';
import 'package:xlo/screens/login/widgets/login_button.dart';
import 'package:xlo/screens/login/widgets/or_divider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginBloc _loginBloc = LoginBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Entrar"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              FacebookButton(_loginBloc),
              OrDivider(),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 11),
                child: Text(
                  "Acessar com email",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey[900]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 3, bottom: 4),
                child: Text(
                  "Email",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w700),
                ),
              ),
              StreamBuilder<FieldState>(
                stream: _loginBloc.outEmail,
                initialData: FieldState(),
                builder: (context, snapshot) {
                  return TextField(
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      errorText: snapshot.data.error,
                    ),
                    onChanged: _loginBloc.changeEmail,
                    enabled: snapshot.data.enabled,
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 3, bottom: 5, top: 26),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "Senha",
                        style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    GestureDetector(
                      child: Text(
                        "Esqueceu sua senha ?",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
              StreamBuilder<FieldState>(
                stream: _loginBloc.outPass,
                initialData: FieldState(),
                builder: (context, snapshot) {
                  return TextField(
                    autocorrect: false,
                    obscureText: true,
                    onChanged: _loginBloc.changePass,
                    enabled: snapshot.data.enabled,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      errorText: snapshot.data.error,
                    ),
                  );
                },
              ),
              LoginButton(_loginBloc),
              Divider(
                color: Colors.grey,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  children: <Widget>[
                    const Text(
                      "Nao tem uma conta ? ",
                      style: TextStyle(fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        "Cadastre-se",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue,
                            fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
