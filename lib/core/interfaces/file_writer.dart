import 'dart:typed_data';

abstract class IFileWriter {
  Future<void> writeAudioToFile(Uint8List audio, String filePath);
}
