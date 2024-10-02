import 'package:logger/logger.dart';
import '../interfaces/logger.dart';

class ConcreteLogger implements ILogger {
  final Logger _logger = Logger();

  @override
  void log(String message) {
    _logger.i(message);
  }

  @override
  void error(String message) {
    _logger.e(message);
  }
}
