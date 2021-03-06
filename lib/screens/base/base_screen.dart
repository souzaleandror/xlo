import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xlo/blocs/drawer_bloc.dart';
import 'package:xlo/screens/account/account_screen.dart';
import 'package:xlo/screens/create/create_screen.dart';
import 'package:xlo/screens/home/home_screen.dart';

class BaseScreen extends StatefulWidget {
  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final PageController _pageController = PageController();

  DrawerBloc _drawerBloc;
  StreamSubscription _drawerSubscription;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    final DrawerBloc drawerBloc = Provider.of<DrawerBloc>(context);
    if (_drawerBloc != drawerBloc) {
      _drawerBloc = drawerBloc;

      _drawerSubscription?.cancel();
      _drawerSubscription = _drawerBloc.outPage.listen((page) {
        try {
          _pageController.jumpToPage(page);
        } catch (e) {}
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _drawerSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //_pageController.jumpTo(2);

    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          HomeScreen(),
          CreateScreen(),
          Container(
            color: Colors.red,
          ),
          Container(
            color: Colors.blue,
          ),
          AccountScreen()
        ],
      ),
    );
  }
}
