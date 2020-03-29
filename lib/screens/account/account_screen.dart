import 'package:flutter/material.dart';
import 'package:xlo/common/custom_drawer/custom_drawer.dart';
import 'package:xlo/screens/edit_account/edit_account_screen.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        elevation: 0,
        title: const Text('Minha conta'),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EditAccountScreen(),
                ),
              );
            },
            child: Text(
              'Editar',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 100,
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            alignment: Alignment.center,
            child: Text(
              'Daniel Ciolfi',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
          ListTile(
            title: Text(
              'Meus Anuncios',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
            ),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {},
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          ListTile(
            title: Text(
              'Meus Favoritos',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
            ),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {},
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
        ],
      ),
    );
  }
}
