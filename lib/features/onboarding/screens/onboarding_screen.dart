import 'package:flutter/material.dart';
import '../../../core/theme/seek7_theme.dart';
import '../../../shared/widgets/seek7_widgets.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int page = 0;

  final items = const [
    ('ENCONTRE DINHEIRO NO MAPA', 'Comércios próximos podem publicar oportunidades pagas no SEEK7.'),
    ('CLIQUE NO PIN DOURADO', 'Encontre um pin discreto, abra a oferta e veja quanto ela paga.'),
    ('ASSISTA. RECEBA.', 'Complete a experiência patrocinada e o valor entra na sua carteira.'),
  ];

  @override
  Widget build(BuildContext context) {
    final item = items[page];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(26, 30, 26, 26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Seek7Colors.gold,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Icon(Icons.location_on_rounded, color: Seek7Colors.navy, size: 29),
                ),
                const SizedBox(width: 12),
                const Text('SEEK7', style: TextStyle(
                  color: Seek7Colors.navy, fontSize: 28, fontWeight: FontWeight.w900, letterSpacing: 2,
                )),
              ]),
              const Spacer(),
              Container(
                width: 86,
                height: 86,
                decoration: BoxDecoration(
                  color: Seek7Colors.blueLight,
                  borderRadius: BorderRadius.circular(26),
                ),
                child: const Icon(Icons.map_rounded, color: Seek7Colors.navy, size: 46),
              ),
              const SizedBox(height: 30),
              Text(item.$1, style: const TextStyle(
                color: Seek7Colors.navy, fontSize: 32, fontWeight: FontWeight.w900, height: 1.05,
              )),
              const SizedBox(height: 16),
              Text(item.$2, style: const TextStyle(
                color: Seek7Colors.muted, fontSize: 17, height: 1.45,
              )),
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
                label: page == 2 ? 'COMEÇAR A PROCURAR' : 'CONTINUAR',
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
