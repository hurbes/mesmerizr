import 'package:just_audio/just_audio.dart';
import 'dart:typed_data';

class UInt8ListAudioSource extends StreamAudioSource {
  final Uint8List _buffer;

  UInt8ListAudioSource(this._buffer);

  @override
  Future<StreamAudioResponse> request([int? start, int? end]) async {
    start ??= 0;
    end ??= _buffer.length;

    return StreamAudioResponse(
      sourceLength: _buffer.length,
      contentLength: end - start,
      offset: start,
      stream: Stream.value(_buffer.sublist(start, end)),
      contentType: 'audio/wav',
    );
  }
}
