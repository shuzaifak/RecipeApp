// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'splash_screen.dart';
import 'models/recipe_provider.dart';
import 'models/theme_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RecipeProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Recipe App',
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.light(
                primary: Colors.blue,
                secondary: Colors.blueAccent,
                background: Colors.grey[50]!,
                surface: Colors.white,
              ),
              cardTheme: CardTheme(
                elevation: 2,
                margin: const EdgeInsets.all(8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.dark(
                primary: Colors.blue,
                secondary: Colors.blueAccent,
                background: Colors.grey[900]!,
                surface: Colors.grey[850]!,
                onSurface: Colors.white,
              ),
              cardTheme: CardTheme(
                elevation: 2,
                margin: const EdgeInsets.all(8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}