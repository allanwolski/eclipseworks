import 'package:flutter_modular/flutter_modular.dart';

import '../app/app_module.dart';
import 'api/nasa_api.dart';
import 'blocs/nasa_bloc.dart';
import 'pages/favorites_page.dart';
import 'pages/nasa_home_page.dart';
import 'repositories/nasa_repository.dart';
import 'storage/nasa_storage.dart';

class HomeModule extends Module {
  @override
  List<Module> get imports => [
        AppModule(),
      ];

  @override
  void binds(i) {
    i.addLazySingleton(NasaBloc.new);
    i.addLazySingleton(NasaRepository.new);
    i.addLazySingleton<NasaApi>(NasaApiImpl.new);
    i.addLazySingleton<NasaStorage>(NasaStorageImpl.new);
  }

  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) => NasaHomePage(r.args.data),
    );
    r.child(
      '/favorites',
      child: (context) => FavoritesPage(),
    );
  }
}
