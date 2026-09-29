import 'package:flutter/material.dart';
import '../../core/theme/seek7_theme.dart';

class Seek7SectionTitle extends StatelessWidget {
  final String title;
  const Seek7SectionTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) => Text(
        title,
        style: const TextStyle(
          letterSpacing: 2,
          fontSize: 11,
          color: Seek7Colors.muted,
        ),
      );
}
