import 'package:flutter/material.dart';
import 'package:xlo/models/ad.dart';

class LocationPanel extends StatelessWidget {
  LocationPanel(this.ad);

  Ad ad;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 18),
          child: Text(
            'Localizacao',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('CEP'),
                  SizedBox(
                    height: 12,
                  ),
                  Text('Municio'),
                  SizedBox(
                    height: 12,
                  ),
                  Text('Bairro'),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('${ad.address.postalCode}'),
                SizedBox(
                  height: 12,
                ),
                Text('${ad.address.city}'),
                SizedBox(
                  height: 12,
                ),
                Text('${ad.address.district}'),
              ],
            )
          ],
        )
      ],
    );
  }
}
