import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme_provider.dart';
import '../widgets/custom_app_bar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: const CustomAppBar(title: 'Paramètres'),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Mode Sombre'),
            secondary: const Icon(Icons.brightness_6),
            value: themeProvider.isDarkMode,
            onChanged: (bool value) {
              themeProvider.toggleTheme();
            },
          ),
          const ListTile(
            title: Text('Version de l\'application'),
            subtitle: Text('1.0.0'),
            leading: Icon(Icons.info_outline),
          ),
        ],
      ),
    );
  }
}
