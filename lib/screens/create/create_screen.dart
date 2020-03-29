import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:xlo/api/api_postalcode.dart';
import 'package:xlo/blocs/create_bloc.dart';
import 'package:xlo/blocs/drawer_bloc.dart';
import 'package:xlo/blocs/home_bloc.dart';
import 'package:xlo/common/cep_field.dart';
import 'package:xlo/common/custom_drawer/custom_drawer.dart';
import 'package:xlo/models/ad.dart';
import 'package:xlo/screens/create/widgets/hide_phone_widget.dart';
import 'package:xlo/screens/create/widgets/images_field.dart';

class CreateScreen extends StatefulWidget {
  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Ad ad = Ad();

  CreateBloc _createBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _createBloc = CreateBloc();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _createBloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Inserir anuncio"),
      ),
      drawer: CustomDrawer(),
      body: Form(
        key: _formKey,
        child: StreamBuilder<CreateState>(
            stream: _createBloc.outState,
            builder: (context, snapshot) {
              if (snapshot.data == CreateState.LOADING) {
                return Center(
                  child: Container(
                    width: 300.0,
                    height: 300.0,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
                      strokeWidth: 5.0,
                    ),
                  ),
                );
              }
              return ListView(
                children: <Widget>[
                  ImagesField(
                    onSaved: (images) {
                      print(images);
                      ad.images = images;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Titulo*',
                      labelStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Colors.grey,
                      ),
                      contentPadding: const EdgeInsets.fromLTRB(16, 10, 12, 10),
                    ),
                    validator: (text) {
                      if (text.isEmpty) return 'Campo obrigatorio';
                      return null;
                    },
                    onSaved: (text) {
                      ad.title = text;
                    },
                  ),
                  TextFormField(
                    maxLength: null,
                    decoration: InputDecoration(
                      labelText: 'Descricao*',
                      labelStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Colors.grey,
                      ),
                      contentPadding: const EdgeInsets.fromLTRB(16, 10, 12, 10),
                    ),
                    validator: (text) {
                      if (text.isEmpty) return 'Campo obrigatorio';
                      if (text.length <= 10) return 'Descricao muito curta';
                      return null;
                    },
                    onSaved: (text) {
                      ad.description = text;
                    },
                  ),
                  CepField(
                    decoration: InputDecoration(
                      labelText: 'Cep*',
                      labelStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Colors.grey,
                      ),
                      contentPadding: const EdgeInsets.fromLTRB(16, 10, 12, 10),
                    ),
                    onSaved: (a) {
                      ad.address = a;
                    },
                  ),
                  TextFormField(
                    maxLength: null,
                    decoration: InputDecoration(
                      labelText: 'Preco*',
                      labelStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Colors.grey,
                      ),
                      contentPadding: const EdgeInsets.fromLTRB(16, 10, 12, 10),
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                        decimal: true, signed: false),
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                      RealInputFormatter(centavos: true),
                    ],
                    validator: (text) {
                      if (text.isEmpty) return 'Campo obrigatorio';
                      if (double.tryParse(getSanitizedText(text)) == null)
                        return 'Utilize valores validos';
                      return null;
                    },
                    onSaved: (price) {
                      ad.price = int.parse(getSanitizedText(price)) / 100;
                    },
                  ),
                  HidePhoneWidget(
                    onSaved: (b) {
                      ad.hidePhone = b;
                    },
                    initialValue: false,
                  ),
                  Container(
                    height: 50,
                    child: RaisedButton(
                      color: Colors.pink,
                      child: Text(
                        "Enviar",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      onPressed: () async {
                        getAddressFromAPI("");
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();

                          Provider.of<HomeBloc>(context).addAd(ad);

                          print(ad);
                          final bool success = await _createBloc.saveAd(ad);

                          if (success) {
                            Provider.of<DrawerBloc>(context).setPage(0);
                          } else {}
                        }
                      },
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }

  String getSanitizedText(String text) {
    return text.replaceAll(RegExp(r'[^\d]'), '');
  }
}
