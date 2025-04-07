import 'package:logging/logging.dart';

class Log {
  final String name;
  final Logger _logger;

  Log(this.name) : _logger = Logger(name);

  void warning(dynamic error, StackTrace stackTrace) {
    _logger.warning(error, error, stackTrace);
  }

  void error(dynamic error, StackTrace stackTrace) {
    _logger.severe(error, error, stackTrace);
  }

  void debug(dynamic e) {
    _logger.fine(e);
  }

  void info(dynamic e) {
    _logger.info(e);
  }
}
