import 'package:flutter/material.dart';
import 'package:xlo/screens/signup/widgets/field_title.dart';
import 'package:xlo/screens/signup/widgets/password_field.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Cadastrar",
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          children: <Widget>[
            const FieldTitle(
              title: "Apelido",
              subtitle: "Como aparacera em seus anuncios",
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Exemplo: Joao S.",
              ),
              validator: (text) {
                if (text.length < 6) {
                  return "Apelido muito curto";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 26,
            ),
            const FieldTitle(
              title: "Emaill",
              subtitle: "Enviaremos um email para confirmar",
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Exemplo: Joao S.",
              ),
              validator: (text) {
                if (text.length < 6 || !text.contains("@")) {
                  return "Email invalido";
                }
                return null;
              },
            ),
            const FieldTitle(
              title: "Senha",
              subtitle: "Use letras, numeros e caracteres especiais",
            ),
            PasswordField(),
          ],
        ),
      ),
    );
  }
}
