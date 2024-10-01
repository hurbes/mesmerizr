import 'dart:typed_data';

class WavConverter {
  static Uint8List convertToWav(List<dynamic> params) {
    final Uint8List pcmData = params[0];
    final int sampleRate = params[1];
    final int byteRate = sampleRate * 2;
    final int totalAudioLen = pcmData.length;
    final int totalDataLen = totalAudioLen + 36;

    final ByteData byteData = ByteData(44 + pcmData.length);
    int offset = 0;

    // RIFF header
    _writeString(byteData, offset, 'RIFF');
    offset += 4;
    byteData.setUint32(offset, totalDataLen, Endian.little);
    offset += 4;
    _writeString(byteData, offset, 'WAVE');
    offset += 4;

    // Format chunk
    _writeString(byteData, offset, 'fmt ');
    offset += 4;
    byteData.setUint32(offset, 16, Endian.little);
    offset += 4; // Subchunk1Size
    byteData.setUint16(offset, 1, Endian.little);
    offset += 2; // AudioFormat (PCM)
    byteData.setUint16(offset, 1, Endian.little);
    offset += 2; // NumChannels (Mono)
    byteData.setUint32(offset, sampleRate, Endian.little);
    offset += 4; // SampleRate
    byteData.setUint32(offset, byteRate, Endian.little);
    offset += 4; // ByteRate
    byteData.setUint16(offset, 2, Endian.little);
    offset += 2; // BlockAlign
    byteData.setUint16(offset, 16, Endian.little);
    offset += 2; // BitsPerSample

    // Data chunk
    _writeString(byteData, offset, 'data');
    offset += 4;
    byteData.setUint32(offset, totalAudioLen, Endian.little);
    offset += 4;

    // Audio data
    for (int i = 0; i < pcmData.length; i++) {
      byteData.setUint8(offset + i, pcmData[i]);
    }

    return byteData.buffer.asUint8List();
  }

  static void _writeString(ByteData data, int offset, String string) {
    for (int i = 0; i < string.length; i++) {
      data.setUint8(offset + i, string.codeUnitAt(i));
    }
  }
}
