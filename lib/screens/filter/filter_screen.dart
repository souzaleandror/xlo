import 'package:flutter/material.dart';
import 'package:xlo/models/filter.dart';
import 'package:xlo/screens/filter/widgets/animated_button.dart';
import 'package:xlo/screens/filter/widgets/order_by_field.dart';
import 'package:xlo/screens/filter/widgets/price_rage_field.dart';
import 'package:xlo/screens/filter/widgets/section_title.dart';
import 'package:xlo/screens/filter/widgets/vendor_type_field.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();

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
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              children: <Widget>[
                SectionTitle("Ordenar por"),
                OrderByField(initalValue: OrderBy.DATE, onSaved: (v) {}),
                SectionTitle("Preco RS"),
                PriceRangeField(),
                SectionTitle("Tipo de  anunciante"),
                VendorTypeField(
                    initalValue:
                        VENDOR_TYPE_PROFESSIONAL | VENDOR_TYPE_PARTICULAR,
                    onSaved: (s) {}),
              ],
            ),
          ),
          AnimatedButton(
              scrollController: _scrollController,
              onTap: () {
                print("teste");
              }),
        ],
      ),
    );
  }
}
