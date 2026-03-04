
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'discovery_screen.dart';
import 'registration_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background Image (Golden Retriever with flower from before)
          Positioned.fill(
            child: Opacity(
              opacity: 0.6,
              child: Image.network(
                'https://images.unsplash.com/photo-1552053831-71594a27632d?q=80&w=800',
                fit: BoxFit.cover,
              ),
            ),
          ),
          
          // Gradient Overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.0),
                    Colors.black.withOpacity(0.8),
                    Colors.black,
                  ],
                ),
              ),
            ),
          ),
          
          // Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(),
                  const Text(
                    'TindPets',
                    style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, letterSpacing: -2),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Encuentra la pareja ideal para tu mascota con responsabilidad y amor.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.white.withOpacity(0.7)),
                  ),
                  const SizedBox(height: 64),
                  _buildPrimaryButton(context),
                  const SizedBox(height: 16),
                  _buildSecondaryButton(),
                  const SizedBox(height: 48),
                  const Text(
                    'Al continuar, aceptas nuestros\nTérminos y Condiciones',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white24, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrimaryButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RegistrationScreen()),
          );
        },
        style: FilledButton.styleFrom(
          backgroundColor: AppTheme.primaryColor,
          padding: const EdgeInsets.symmetric(vertical: 20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        ),
        child: const Text('Comenzar ahora', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildSecondaryButton() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          side: const BorderSide(color: Colors.white24),
          padding: const EdgeInsets.symmetric(vertical: 20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        ),
        child: const Text('Ya tengo una cuenta', style: TextStyle(fontSize: 16)),
      ),
    );
  }
}
