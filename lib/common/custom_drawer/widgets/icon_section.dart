import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xlo/blocs/drawer_bloc.dart';
import 'package:xlo/common/custom_drawer/widgets/icon_tile.dart';

class IconSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DrawerBloc _drawerBloc = Provider.of<DrawerBloc>(context);

    void _setPage(int page) {
      Navigator.of(context).pop();
      _drawerBloc.setPage(page);
    }

    return StreamBuilder(
      stream: _drawerBloc.outPage,
      builder: (context, snapsnot) {
        return Column(
          children: <Widget>[
            IconTile(
              label: "Anuncios",
              iconData: Icons.list,
              onTap: () {
                _setPage(0);
              },
              highlighted: snapsnot.data == 0,
            ),
            IconTile(
              label: "Inserir Anuncior",
              iconData: Icons.edit,
              onTap: () {
                _setPage(1);
              },
              highlighted: snapsnot.data == 1,
            ),
            IconTile(
              label: "Chat",
              iconData: Icons.chat,
              onTap: () {
                _setPage(2);
              },
              highlighted: snapsnot.data == 2,
            ),
            IconTile(
              label: "Favoritos",
              iconData: Icons.favorite,
              onTap: () {
                _setPage(3);
              },
              highlighted: snapsnot.data == 3,
            ),
            IconTile(
              label: "Minha Conta",
              iconData: Icons.person,
              onTap: () {
                _setPage(4);
              },
              highlighted: snapsnot.data == 4,
            ),
          ],
        );
      },
    );
  }
}
