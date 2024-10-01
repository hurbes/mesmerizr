import 'package:flutter/material.dart';

class NoiseVisualizer extends StatelessWidget {
  final List<double> noiseData;

  const NoiseVisualizer({Key? key, required this.noiseData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: NoiseVisualizerPainter(noiseData),
      size: Size.infinite,
    );
  }
}

class NoiseVisualizerPainter extends CustomPainter {
  final List<double> noiseData;

  NoiseVisualizerPainter(this.noiseData);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    if (noiseData.isEmpty) {
      // Draw a message if there's no data
      final textPainter = TextPainter(
        text: TextSpan(
          text: 'No noise data available',
          style: TextStyle(color: Colors.grey[600], fontSize: 16),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas,
          Offset(size.width / 2 - textPainter.width / 2, size.height / 2));
      return;
    }

    final path = Path();
    final stepX = size.width / (noiseData.length - 1);
    final maxY = noiseData.reduce((max, value) => value > max ? value : max);
    final scaleY = size.height / (maxY * 2);

    for (int i = 0; i < noiseData.length; i++) {
      final x = i * stepX;
      final y = size.height / 2 + noiseData[i] * scaleY;

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
