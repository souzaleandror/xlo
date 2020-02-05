import 'package:rxdart/rxdart.dart';

class DrawerBloc {
  int _page = 0;

  //seeder = inicio 0 sempre na pagina 0
  final BehaviorSubject<int> _pageController = BehaviorSubject<int>.seeded(0);
  Stream<int> get outPage => _pageController.stream;

  void setPage(int page) {
    if (page == _page) return; //se clico na pagina que jah estou
    _page = page;
    _pageController.add(page);
  }

  void dispose() {
    _pageController.close();
  }
}
