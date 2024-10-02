import 'dart:io';
import 'dart:typed_data';
import '../interfaces/file_writer.dart';

class ConcreteFileWriter implements IFileWriter {
  @override
  Future<void> writeAudioToFile(Uint8List audio, String filePath) async {
    final file = File(filePath);
    await file.writeAsBytes(audio);
  }
}
