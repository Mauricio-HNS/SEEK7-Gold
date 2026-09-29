import 'package:flutter/material.dart';
import '../theme/seek7_theme.dart';
import '../widgets/seek7_widgets.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int page = 0;
  final items = const [
    ('THE CITY IS YOUR GOLD MINE', 'Discover real opportunities around you.'),
    ('20 MINUTES. YOUR RUN.', 'Explore nearby Gold Spots during a timed SEEK Run.'),
    ('WATCH. COMPLETE. EARN.', 'Finish sponsored experiences and receive verified rewards.'),
  ];

  @override
  Widget build(BuildContext context) {
    final item = items[page];
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Container(
                width: 74, height: 74,
                decoration: BoxDecoration(color: Seek7Colors.gold.withOpacity(.12), shape: BoxShape.circle),
                child: const Icon(Icons.location_on_rounded, size: 38, color: Seek7Colors.goldBright),
              ),
              const SizedBox(height: 34),
              Text(item.$1, style: const TextStyle(fontSize: 34, fontWeight: FontWeight.w800, height: 1.05)),
              const SizedBox(height: 16),
              Text(item.$2, style: const TextStyle(fontSize: 17, color: Seek7Colors.muted, height: 1.5)),
              const Spacer(),
              Row(children: List.generate(3, (i) => Expanded(child: Container(
                margin: EdgeInsets.only(right: i == 2 ? 0 : 6),
                height: 4,
                decoration: BoxDecoration(
                  color: i == page ? Seek7Colors.gold : Seek7Colors.surface2,
                  borderRadius: BorderRadius.circular(8),
                ),
              )))),
              const SizedBox(height: 24),
              GoldButton(
                label: page == 2 ? 'CREATE MY SEEK7' : 'CONTINUE',
                onPressed: () {
                  if (page == 2) {
                    Navigator.pushReplacementNamed(context, '/auth');
                  } else {
                    setState(() => page++);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
