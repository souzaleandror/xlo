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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  //Filter _filter = Filter();

  Filter _filter = Filter(
      maxPrice: 100,
      minPrice: 10,
      vendorType: VENDOR_TYPE_PARTICULAR,
      orderBy: OrderBy.DATE);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                OrderByField(
                    initalValue: OrderBy.DATE,
                    onSaved: (v) {
                      _filter.orderBy = v;
                    }),
                SectionTitle("Preco RS"),
                PriceRangeField(
                  filter: _filter,
                ),
                SectionTitle("Tipo de  anunciante"),
                VendorTypeField(
                    initalValue: _filter.vendorType,
                    onSaved: (v) {
                      _filter.vendorType = v;
                    }),
              ],
            ),
          ),
          AnimatedButton(
              scrollController: _scrollController,
              onTap: () {
                print("teste");
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  if (_filter.maxPrice != null && _filter.minPrice != null) {
                    if (_filter.minPrice > _filter.maxPrice) {
                      _scaffoldKey.currentState.showSnackBar(
                        SnackBar(
                          content: const Text("Faixa de preco invalido"),
                          backgroundColor: Colors.pink,
                        ),
                      );
                      return;
                    }
                  }
                }
              }),
        ],
      ),
    );
  }
}
