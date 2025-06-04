import 'package:financeiro/common/theme/app_theme.dart';
import 'package:financeiro/ui/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('pt_BR', null);

  runApp(
    MaterialApp(
      title: 'Financial Tracking App',
      debugShowCheckedModeBanner: false,
      theme: appLightTheme,
      darkTheme: appDarkTheme,
      themeMode: ThemeMode.system,
      home: const HomeScreen(),
    ),
  );
}
