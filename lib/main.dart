
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'theme/app_theme.dart';
import 'providers/pet_provider.dart';
import 'screens/discovery_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Supabase initialization (commented out until credentials are ready)
  /*
  await Supabase.initialize(
    url: 'YOUR_SUPABASE_URL',
    anonKey: 'YOUR_SUPABASE_ANON_KEY',
  );
  */

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
      theme: AppTheme.lightTheme,
      home: const DiscoveryScreen(),
    );
  }
}
