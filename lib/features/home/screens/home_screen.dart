import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/theme/seek7_theme.dart';
import '../../../shared/widgets/seek7_widgets.dart';
import '../../market/market_store.dart';
import '../../market/models/gold_opportunity.dart';
import '../../wallet/wallet_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const madrid = LatLng(40.4168, -3.7038);
  final market = Seek7MarketStore.instance;
  final wallet = Seek7WalletController.instance;

  GoogleMapController? mapController;

  Set<Marker> get markers {
    return market.opportunities.map((opportunity) {
      return Marker(
        markerId: MarkerId(opportunity.id),
        position: LatLng(opportunity.latitude, opportunity.longitude),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
        consumeTapEvents: true,
        onTap: () => _openOpportunity(opportunity),
      );
    }).toSet();
  }

  Future<void> _openOpportunity(GoldOpportunity opportunity) async {
    if (!market.canComplete(opportunity)) return;

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      isDismissible: false,
      backgroundColor: Colors.transparent,
      builder: (_) => _OpportunitySheet(opportunity: opportunity),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([market, wallet]),
      builder: (context, _) {
        return Scaffold(
          body: Stack(
            children: [
              GoogleMap(
                initialCameraPosition: const CameraPosition(
                  target: madrid,
                  zoom: 15.7,
                ),
                mapType: MapType.normal,
                myLocationButtonEnabled: true,
                zoomControlsEnabled: false,
                markers: markers,
                onMapCreated: (controller) => mapController = controller,
              ),
              Positioned(
                top: MediaQuery.of(context).padding.top + 10,
                left: 16,
                right: 16,
                child: _TopBar(balance: wallet.balance),
              ),
              Positioned(
                left: 16,
                right: 16,
                bottom: MediaQuery.of(context).padding.bottom + 14,
                child: _MapHint(count: market.opportunities.length),
              ),
            ],
          ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: 0,
            onDestinationSelected: (index) {
              if (index == 1) Navigator.pushNamed(context, '/wallet');
              if (index == 2) Navigator.pushNamed(context, '/merchant');
              if (index == 3) Navigator.pushNamed(context, '/profile');
            },
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.map_outlined),
                selectedIcon: Icon(Icons.map),
                label: 'Procurar',
              ),
              NavigationDestination(
                icon: Icon(Icons.account_balance_wallet_outlined),
                selectedIcon: Icon(Icons.account_balance_wallet),
                label: 'Carteira',
              ),
              NavigationDestination(
                icon: Icon(Icons.storefront_outlined),
                selectedIcon: Icon(Icons.storefront),
                label: 'Publicar',
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outline),
                selectedIcon: Icon(Icons.person),
                label: 'Perfil',
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TopBar extends StatelessWidget {
  final double balance;

  const _TopBar({required this.balance});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: .96),
              borderRadius: BorderRadius.circular(18),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x22000000),
                  blurRadius: 12,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: const BoxDecoration(
                    color: Seek7Colors.gold,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.location_on,
                    color: Seek7Colors.navy,
                    size: 21,
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  'SEEK7',
                  style: TextStyle(
                    color: Seek7Colors.navy,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                  ),
                ),
                const Spacer(),
                Text(
                  '€' + balance.toStringAsFixed(2),
                  style: const TextStyle(
                    color: Seek7Colors.navy,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: .96),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.search,
            color: Seek7Colors.navy,
          ),
        ),
      ],
    );
  }
}

class _MapHint extends StatelessWidget {
  final int count;

  const _MapHint({required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Seek7Colors.navy.withValues(alpha: .95),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          const Icon(Icons.touch_app_rounded, color: Seek7Colors.gold),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              count == 1
                  ? '1 oportunidade paga perto de você'
                  : count.toString() + ' oportunidades pagas perto de você',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const Text(
            'TOQUE NO PIN',
            style: TextStyle(
              color: Seek7Colors.gold,
              fontSize: 10,
              fontWeight: FontWeight.w900,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _OpportunitySheet extends StatefulWidget {
  final GoldOpportunity opportunity;

  const _OpportunitySheet({required this.opportunity});

  @override
  State<_OpportunitySheet> createState() => _OpportunitySheetState();
}

class _OpportunitySheetState extends State<_OpportunitySheet> {
  Timer? timer;
  int seconds = 5;
  bool completed = false;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;

      if (seconds <= 1) {
        timer?.cancel();
        final wallet = Seek7WalletController.instance;
        final market = Seek7MarketStore.instance;

        wallet.credit(
          merchant: widget.opportunity.merchant,
          amount: widget.opportunity.reward,
        );
        market.consume(widget.opportunity.id);

        setState(() {
          seconds = 0;
          completed = true;
        });
      } else {
        setState(() => seconds--);
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.fromLTRB(22, 14, 22, 22),
        decoration: const BoxDecoration(
          color: Seek7Colors.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 42,
              height: 4,
              decoration: BoxDecoration(
                color: Seek7Colors.surface2,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: const BoxDecoration(
                    color: Seek7Colors.gold,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.location_on_rounded,
                    color: Seek7Colors.navy,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.opportunity.merchant,
                        style: const TextStyle(
                          color: Seek7Colors.navy,
                          fontSize: 19,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        widget.opportunity.category,
                        style: const TextStyle(color: Seek7Colors.muted),
                      ),
                    ],
                  ),
                ),
                Text(
                  '€' + widget.opportunity.reward.toStringAsFixed(2),
                  style: const TextStyle(
                    color: Seek7Colors.success,
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Container(
              height: 190,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Seek7Colors.navy, Seek7Colors.blue],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(22),
              ),
              child: completed
                  ? const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check_circle_rounded,
                          color: Seek7Colors.gold,
                          size: 58,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'DINHEIRO RECEBIDO',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.4,
                          ),
                        ),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.play_circle_fill_rounded,
                          color: Seek7Colors.gold,
                          size: 62,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          seconds.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const Text(
                          'ANÚNCIO PATROCINADO',
                          style: TextStyle(
                            color: Seek7Colors.blueLight,
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ],
                    ),
            ),
            const SizedBox(height: 16),
            Text(
              completed
                  ? '€' + widget.opportunity.reward.toStringAsFixed(2) + ' foi adicionado à sua carteira.'
                  : widget.opportunity.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Seek7Colors.text,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 18),
            if (completed)
              GoldButton(
                label: 'VOLTAR AO MAPA',
                onPressed: () => Navigator.pop(context),
              )
            else
              const Text(
                'Assista por 5 segundos para liberar a recompensa.',
                style: TextStyle(color: Seek7Colors.muted, fontSize: 12),
              ),
          ],
        ),
      ),
    );
  }
}
