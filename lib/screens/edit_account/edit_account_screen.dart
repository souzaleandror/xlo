import 'package:flutter/material.dart';
import 'package:xlo/models/user.dart';
import 'package:xlo/screens/account/widgets/user_type_widget.dart';

class EditAccountScreen extends StatefulWidget {
  @override
  _EditAccountScreenState createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  final User _user = User(name: "Daniel", phone: "123123");

  @override
  Widget build(BuildContext context) {
    InputDecoration _buildDecoration(String label) {
      return InputDecoration(
        labelText: label,
        contentPadding: const EdgeInsets.only(left: 16, bottom: 8, top: 8),
      );
    }

    return Scaffold(
      appBar: AppBar(elevation: 0, title: const Text('Editar Conta')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          UserTypeWidget(
            initialValue: _user.userType,
            onSaved: (userType) {},
          ),
          TextFormField(
            initialValue: _user.name,
            decoration: _buildDecoration('Nome'),
            validator: (name) {
              if (name.length < 6) {
                return 'Nome Invalido';
              }
              return null;
            },
            onSaved: (name) {},
          ),
          TextFormField(
            initialValue: _user.phone,
            decoration: _buildDecoration('Telefone'),
            validator: (telefone) {
              if (telefone.length < 6) {
                return 'Telefone Invalido';
              }
              return null;
            },
            onSaved: (telefone) {},
          ),
          TextFormField(
            decoration: _buildDecoration('Senha'),
            obscureText: true,
            autovalidate: true,
            validator: (pass) {
              if (pass.isEmpty) return null;
              if (pass.length < 6) {
                return 'Senha muito curta';
              }
              return null;
            },
            onSaved: (pass) {},
          ),
          TextFormField(
            decoration: _buildDecoration('Confirmar Senha'),
            obscureText: true,
            autovalidate: true,
            validator: (pass) {
              if (pass.isEmpty) return null;
              if (pass.length < 6) {
                return 'Senha Muito curta';
              }
              return null;
            },
            onSaved: (pass) {},
          )
        ],
      ),
    );
  }
}
