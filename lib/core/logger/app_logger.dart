import 'package:logger/logger.dart';

class AppLogger {
  final Logger _logger = Logger();

  void log(String message) {
    _logger.i(message);
  }

  void error(String message) {
    _logger.e(message);
  }
}
