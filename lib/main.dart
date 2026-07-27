import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme_provider.dart';
import 'core/anime_provider.dart';
import 'routes/app_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => AnimeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp.router(
            title: 'Animes World',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
              colorSchemeSeed: Colors.greenAccent,
              brightness: Brightness.light,
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              colorSchemeSeed: Colors.greenAccent,
              brightness: Brightness.dark,
            ),
            themeMode: themeProvider.themeMode,
            routerConfig: AppRoutes.router,
          );
        },
      ),
    );
  }
}
