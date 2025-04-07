import 'package:flutter_modular/flutter_modular.dart';

mixin BlocView<T extends Object> {
  T get bloc => Modular.get<T>();
}
