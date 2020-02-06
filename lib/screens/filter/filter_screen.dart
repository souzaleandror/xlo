import 'package:flutter/material.dart';
import 'package:xlo/screens/filter/widgets/section_title.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Filtrar Buscar"),
      ),
      body: Stack(
        children: <Widget>[
          Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: <Widget>[
                SectionTitle("Ordenar por"),
                SectionTitle("Preco RS"),
                SectionTitle("Tipo de  anunciante"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
