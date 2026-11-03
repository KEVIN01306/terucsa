import 'package:flutter/cupertino.dart';
import '../models/ethical_content.dart';
import '../services/data_service.dart';
import '../theme/app_theme.dart';
import '../widgets/app_container.dart';
import '../widgets/comic_app_header.dart';
import '../widgets/station_card_widget.dart';
import 'station1/station1_screen.dart';
import 'station2/station2_screen.dart';
import 'station3/station3_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<EthicalContent> _contentFuture;

  @override
  void initState() {
    super.initState();
    _contentFuture = DataService().loadContent();
  }

  void _navigateToStation(String stationId, EthicalContent content) {
    Widget targetScreen;
    switch (stationId) {
      case 's1':
        targetScreen = Station1Screen(content: content);
        break;
      case 's2':
        targetScreen = Station2Screen(content: content);
        break;
      case 's3':
        targetScreen = Station3Screen(content: content);
        break;
      default:
        return;
    }

    Navigator.of(context).push(
      CupertinoPageRoute(builder: (_) => targetScreen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.bgYellow,
      navigationBar: const CupertinoNavigationBar(
        middle: Text(
          'Proyección Ética',
          style: TextStyle(fontWeight: FontWeight.w800, color: AppColors.ink),
        ),
        backgroundColor: AppColors.white,
      ),
      child: SafeArea(
        child: FutureBuilder<EthicalContent>(
          future: _contentFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CupertinoActivityIndicator(radius: 16),
              );
            }

            if (snapshot.hasError || !snapshot.hasData) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text(
                    'Error al cargar el contenido: ${snapshot.error}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: AppColors.danger),
                  ),
                ),
              );
            }

            final data = snapshot.data!;
            final home = data.home;

            final accentColors = [
              AppColors.cyan,
              AppColors.purple.withValues(alpha: 0.3),
              AppColors.red.withValues(alpha: 0.25),
            ];

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: AppContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ComicAppHeader(
                      kicker: data.header.kicker,
                      title: data.header.title,
                      subtitle: data.header.subtitle,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            home.title,
                            style: const TextStyle(
                              color: AppColors.ink,
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.3,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            home.description,
                            style: const TextStyle(
                              color: AppColors.grayMuted,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 24),
                          ...home.stations.asMap().entries.map((entry) {
                            final idx = entry.key;
                            final station = entry.value;
                            return StationCardWidget(
                              station: station,
                              accentColor: accentColors[idx % accentColors.length],
                              onTap: () => _navigateToStation(station.id, data),
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
