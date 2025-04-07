import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'common/storage/storage.dart';
import 'modules/app/app_module.dart';
import 'modules/app/app_widget.dart';

void main() async {
  await Storage.instance.init();
  runApp(
    ModularApp(
      module: AppModule(),
      child: const AppWidget(),
    ),
  );
}
