import 'package:flutter/cupertino.dart';
import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProyeccionEticaApp());
}

class ProyeccionEticaApp extends StatelessWidget {
  const ProyeccionEticaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Proyección Ética',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.cupertinoTheme,
      home: const HomeScreen(),
    );
  }
}
