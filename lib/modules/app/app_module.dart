import 'package:flutter_modular/flutter_modular.dart';

import '../../common/http/http_client.dart';
import '../nasa/nasa_module.dart';

class AppModule extends Module {
  @override
  void exportedBinds(i) {
    i.addSingleton(HttpClient.new);
  }

  @override
  void routes(r) {
    r.module(
      '/',
      module: HomeModule(),
      transition: TransitionType.noTransition,
    );
  }
}
