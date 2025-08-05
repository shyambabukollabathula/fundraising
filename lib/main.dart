import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/theme_provider.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const FundraisingPortalApp());
}

class FundraisingPortalApp extends StatelessWidget {
  const FundraisingPortalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Fundraising Portal',
            theme: themeProvider.currentTheme.copyWith(
              // Add global text overflow prevention
              textTheme: themeProvider.currentTheme.textTheme.apply(
                fontSizeFactor: 1.0,
              ),
            ),
            home: const SplashScreen(),
            debugShowCheckedModeBanner: false,
            builder: (context, child) {
              // Global overflow prevention
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaler: TextScaler.linear(
                    MediaQuery.of(context).textScaler.scale(1.0).clamp(0.8, 1.2),
                  ),
                ),
                child: child!,
              );
            },
          );
        },
      ),
    );
  }
}
