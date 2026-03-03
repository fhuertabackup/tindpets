
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme/app_theme.dart';
import 'providers/pet_provider.dart';
import 'screens/discovery_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PetProvider()),
      ],
      child: const TindPetsApp(),
    ),
  );
}

class TindPetsApp extends StatelessWidget {
  const TindPetsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TindPets',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.immersiveTheme, // Fixed theme name
      home: const DiscoveryScreen(),
    );
  }
}
