import 'dart:async';
import 'dart:isolate';

typedef IsolateFunction = void Function(SendPort);

class IsolateProcessor {
  Isolate? _isolate;
  SendPort? _sendPort;
  ReceivePort? _receivePort;
  StreamController? _streamController;

  Future<void> initialize() async {
    _receivePort = ReceivePort();
    _streamController = StreamController.broadcast();
  }

  Future<void> start(IsolateFunction isolateFunction) async {
    if (_isolate != null) {
      throw StateError('Isolate is already running');
    }

    _isolate = await Isolate.spawn(
      (SendPort sendPort) {
        final receivePort = ReceivePort();
        sendPort.send(receivePort.sendPort);
        isolateFunction(sendPort);
        receivePort.listen((message) {
          if (message is SendPort) {
            _sendPort = message;
          }
        });
      },
      _receivePort!.sendPort,
    );

    _receivePort!.listen((message) {
      if (message is SendPort) {
        _sendPort = message;
      } else {
        _streamController?.add(message);
      }
    });
  }

  void listen(void Function(dynamic) onData) {
    _streamController?.stream.listen(onData);
  }

  Future<void> send(dynamic message) async {
    _sendPort?.send(message);
  }

  Future<void> stop() async {
    _isolate?.kill(priority: Isolate.immediate);
    _isolate = null;
    _sendPort = null;
    _receivePort?.close();
    _receivePort = null;
  }

  Future<void> dispose() async {
    await stop();
    _streamController?.close();
    _streamController = null;
  }
}
