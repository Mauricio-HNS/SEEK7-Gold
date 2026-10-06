import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../theme/seek7_theme.dart';

class Seek7MarkerIcons {
  Seek7MarkerIcons._();

  static Future<BitmapDescriptor> money() async {
    const size = 96.0;
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);

    final shadow = Paint()
      ..color = const Color(0x55000000)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);

    canvas.drawCircle(const Offset(48, 45), 25, shadow);

    final pin = Path()
      ..moveTo(48, 8)
      ..cubicTo(27, 8, 13, 23, 13, 42)
      ..cubicTo(13, 61, 30, 72, 48, 88)
      ..cubicTo(66, 72, 83, 61, 83, 42)
      ..cubicTo(83, 23, 69, 8, 48, 8)
      ..close();

    final gold = Paint()..color = Seek7Colors.gold;
    canvas.drawPath(pin, gold);

    final border = Paint()
      ..color = Seek7Colors.navy
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    canvas.drawPath(pin, border);

    final inner = Paint()..color = Colors.white;
    canvas.drawCircle(const Offset(48, 41), 20, inner);

    final innerBorder = Paint()
      ..color = Seek7Colors.navy
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;
    canvas.drawCircle(const Offset(48, 41), 20, innerBorder);

    final textPainter = TextPainter(
      text: const TextSpan(
        text: r'$',
        style: TextStyle(
          color: Seek7Colors.navy,
          fontSize: 27,
          fontWeight: FontWeight.w900,
          height: 1,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    textPainter.paint(
      canvas,
      Offset(48 - textPainter.width / 2, 41 - textPainter.height / 2),
    );

    final image = await recorder.endRecording().toImage(
      size.toInt(),
      size.toInt(),
    );
    final data = await image.toByteData(format: ui.ImageByteFormat.png);
    image.dispose();

    return BitmapDescriptor.fromBytes(
      Uint8List.fromList(data!.buffer.asUint8List()),
    );
  }
}
