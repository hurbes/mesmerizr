import 'dart:async';
import 'dart:isolate';

class IsolateProcessor {
  Isolate? _isolate;
  SendPort? _sendPort;
  ReceivePort? _receivePort;

  Future<void> initialize<T>(
    Function(T, SendPort) entryPoint,
    T initialMessage,
  ) async {
    _receivePort = ReceivePort();
    _isolate = await Isolate.spawn(
      (message) => entryPoint(message.$1, message.$2),
      (initialMessage, _receivePort!.sendPort),
    );

    _sendPort = await _receivePort!.first;
  }

  Future<R> compute<T, R>(T message) async {
    if (_sendPort == null) {
      throw StateError('IsolateProcessor not initialized');
    }

    final completer = Completer<R>();
    final responsePort = ReceivePort();

    _sendPort!.send((message, responsePort.sendPort));

    responsePort.listen((response) {
      if (response is R) {
        completer.complete(response);
      } else if (response is Exception) {
        completer.completeError(response);
      }
      responsePort.close();
    });

    return completer.future;
  }

  void dispose() {
    _isolate?.kill(priority: Isolate.immediate);
    _isolate = null;
    _sendPort = null;
    _receivePort?.close();
    _receivePort = null;
  }
}
