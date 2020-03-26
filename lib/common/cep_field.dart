import 'dart:ui';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xlo/blocs/cep_bloc.dart';
import 'package:xlo/models/address.dart';

class CepField extends StatefulWidget {
  final InputDecoration decoration;
  final FormFieldSetter<Address> onSaved;

  CepField({this.decoration, this.onSaved});

  @override
  _CepFieldState createState() => _CepFieldState();
}

class _CepFieldState extends State<CepField> {
  InputDecoration get decoration => widget.decoration;
  FormFieldSetter<Address> get onSaved => widget.onSaved;

  CepBloc cepBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cepBloc = CepBloc();
  }

  @override
  void dispose() {
    cepBloc?.dispose();
    super.dispose();
    // TODO: implement dispose
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CepBlocState>(
      stream: cepBloc.outCep,
      builder: (context, snapshot) {
        if (snapshot.data.cepFieldState == CepFieldState.INITIALIZING)
          return Container();
        return Column(
          children: <Widget>[
            TextFormField(
              initialValue: snapshot.data.cep,
              decoration: decoration,
              keyboardType: TextInputType.number,
              inputFormatters: [
                WhitelistingTextInputFormatter.digitsOnly,
                CepInputFormatter(),
              ],
              onSaved: (c) {
                print(c);
                onSaved(snapshot.data.address);
              },
              onChanged: cepBloc.onChanged,
              validator: (c) {
                switch (snapshot.data.cepFieldState) {
                  case CepFieldState.INITIALIZING:
                  case CepFieldState.INCOMPLETE:
                  case CepFieldState.INVALID:
                    return "Campo Obrigatorio";
                  case CepFieldState.VALID:
                }
                return null;
              },
            ),
            buildInformation(snapshot.data),
          ],
        );
      },
    );
  }

  Widget buildInformation(CepBlocState blocState) {
    switch (blocState.cepFieldState) {
      case CepFieldState.INITIALIZING:
      case CepFieldState.INCOMPLETE:
        return Container();
      case CepFieldState.INVALID:
        return Container(
          height: 50,
          padding: const EdgeInsets.all(8.0),
          color: Colors.red.withAlpha(100),
          alignment: Alignment.center,
          child: Text(
            "CEP Invalido",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
        );
      case CepFieldState.VALID:
        final _address = blocState.address;
        return Container(
          height: 50,
          padding: const EdgeInsets.all(8.0),
          color: Colors.green,
          alignment: Alignment.center,
          child: Text(
            "Localizacao: ${_address.district} - ${_address.city} - ${_address.fererativeUnit} - ${_address.postalCode}",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        );
    }
    return Container();
  }
}
