import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/app_processor/app_processor.dart';

final appProcessorProvider = Provider<AppProcessor>((ref) {
  return AppProcessor();
});
