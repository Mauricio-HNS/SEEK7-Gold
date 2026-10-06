import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import '../../../core/theme/seek7_theme.dart';
import '../../../shared/widgets/seek7_widgets.dart';

class LiveMiningScreen extends StatefulWidget {
  const LiveMiningScreen({super.key});

  @override
  State<LiveMiningScreen> createState() => _LiveMiningScreenState();
}

class _LiveMiningScreenState extends State<LiveMiningScreen> {
  static const madrid = LatLng(40.4168, -3.7038);

  GoogleMapController? map;
  StreamSubscription<Position>? location;
  Timer? runTimer;
  Timer? rewardTimer;

  int seconds = 1200;
  int mined = 0;
  int rewardSeconds = 0;

  bool locationReady = false;
  bool watching = false;
  bool activated = false;

  String? consumedSpot;

  double? lat;
  double? lng;

  final Set<Marker> markers = {
    const Marker(
      markerId: MarkerId('gold1'),
      position: LatLng(40.4176, -3.7031),
      infoWindow: InfoWindow(
        title: 'GOLD SPOT',
        snippet: '€0.20',
      ),
    ),
    const Marker(
      markerId: MarkerId('gold2'),
      position: LatLng(40.4157, -3.7050),
      infoWindow: InfoWindow(
        title: 'GOLD SPOT',
        snippet: '€0.35',
      ),
    ),
    const Marker(
      markerId: MarkerId('gold3'),
      position: LatLng(40.4182, -3.7009),
      infoWindow: InfoWindow(
        title: 'GOLD SPOT',
        snippet: '€0.15',
      ),
    ),
  };

  @override
  void initState() {
    super.initState();
    start();
  }

  Future<void> start() async {
    runTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        if (!mounted) return;

        if (seconds <= 1) {
          runTimer?.cancel();
          setState(() {
            seconds = 0;
          });
        } else {
          setState(() {
            seconds--;
          });
        }
      },
    );

    if (!await Geolocator.isLocationServiceEnabled()) {
      return;
    }

    var permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return;
    }

    final position = await Geolocator.getCurrentPosition();

    updatePosition(position);

    location = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 5,
      ),
    ).listen(updatePosition);
  }

  void updatePosition(Position position) {
    if (!mounted) return;

    setState(() {
      lat = position.latitude;
      lng = position.longitude;
      locationReady = true;
    });

    map?.animateCamera(
      CameraUpdate.newLatLng(
        LatLng(
          position.latitude,
          position.longitude,
        ),
      ),
    );
  }

  void mineSpot(String id) {
    if (!locationReady) return;
    if (watching) return;
    if (mined >= 5) return;
    if (seconds == 0) return;
    if (consumedSpot == id) return;

    setState(() {
      consumedSpot = id;
      watching = true;
      activated = false;
      rewardSeconds = 5;
    });

    rewardTimer?.cancel();

    rewardTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        if (!mounted || !watching) return;

        if (rewardSeconds <= 1) {
          rewardTimer?.cancel();

          setState(() {
            rewardSeconds = 0;
            activated = true;
          });
        } else {
          setState(() {
            rewardSeconds--;
          });
        }
      },
    );
  }

  void leaveVideo() {
    rewardTimer?.cancel();

    setState(() {
      watching = false;
      activated = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Opportunity lost. €0 earned.'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void activateMoney() {
    if (!activated) return;

    rewardTimer?.cancel();

    setState(() {
      mined++;
      watching = false;
      activated = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('€0.20 ACTIVATED IN WALLET'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  void dispose() {
    runTimer?.cancel();
    location?.cancel();
    rewardTimer?.cancel();
    super.dispose();
  }

  String get clock {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final remainingSeconds = (seconds % 60).toString().padLeft(2, '0');

    return '$minutes:$remainingSeconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SEEK RUN'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18),
            child: Center(
              child: Text(
                clock,
                style: const TextStyle(
                  color: Seek7Colors.goldBright,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: madrid,
              zoom: 16,
            ),
            myLocationEnabled: locationReady,
            myLocationButtonEnabled: true,
            zoomControlsEnabled: false,
            markers: markers,
            onMapCreated: (controller) {
              map = controller;
            },
          ),
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: _status(),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 22,
            child: GoldButton(
              label: locationReady
                  ? 'WALK & FIND GOLD  •  $mined/5'
                  : 'ENABLE LOCATION',
              onPressed: locationReady ? () => mineSpot('gold1') : () {},
            ),
          ),
          if (watching) _experience(),
        ],
      ),
    );
  }

  Widget _status() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Seek7Colors.surface.withValues(alpha: .94),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.location_on_rounded,
            color: Seek7Colors.gold,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              locationReady
                  ? 'GPS ACTIVE  •  WALK THE CITY'
                  : 'LOCATION REQUIRED',
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.1,
              ),
            ),
          ),
          Text(
            '$mined/5',
            style: const TextStyle(
              color: Seek7Colors.goldBright,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _experience() {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withValues(alpha: .72),
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(24),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Seek7Colors.surface,
              borderRadius: BorderRadius.circular(28),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'GOLD SPOT',
                  style: TextStyle(
                    color: Seek7Colors.goldBright,
                    letterSpacing: 2,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Sponsored experience',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  activated
                      ? 'MONEY ACTIVATED'
                      : 'Leave now and this opportunity dies.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Seek7Colors.muted,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 170,
                  decoration: BoxDecoration(
                    color: const Color(0xFF20252B),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: activated
                        ? const Icon(
                            Icons.attach_money_rounded,
                            size: 90,
                            color: Seek7Colors.goldBright,
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.play_circle_fill_rounded,
                                size: 56,
                                color: Seek7Colors.gold,
                              ),
                              Text(
                                '$rewardSeconds',
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w900,
                                  color: Seek7Colors.goldBright,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
                const SizedBox(height: 18),
                GoldButton(
                  label: activated ? 'ACTIVATE +€0.20' : 'LEAVE • €0',
                  onPressed: activated ? activateMoney : leaveVideo,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
