
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'discovery_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool _acceptedTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 64.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              const SizedBox(height: 32),
              const Text('Crea tu cuenta 👤', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Text('Inicia tu viaje para encontrar la pareja ideal para tu mascota.', style: TextStyle(color: Colors.white.withOpacity(0.5))),
              const SizedBox(height: 48),
              _buildInputField('Nombre completo', Icons.person_outline),
              const SizedBox(height: 24),
              _buildInputField('Correo electrónico', Icons.mail_outline),
              const SizedBox(height: 24),
              _buildInputField('Contraseña', Icons.lock_outline, isPassword: true),
              const SizedBox(height: 24),
              _buildInputField('Ubicación (Ciudad)', Icons.location_on_outlined),
              const SizedBox(height: 32),
              _buildTermsCheckbox(),
              const SizedBox(height: 48),
              _buildRegisterButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String label, IconData icon, {bool isPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 14)),
        const SizedBox(height: 8),
        TextField(
          obscureText: isPassword,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Colors.white38, size: 20),
            filled: true,
            fillColor: Colors.white.withOpacity(0.05),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
          ),
        ),
      ],
    );
  }

  Widget _buildTermsCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: _acceptedTerms,
          onChanged: (val) => setState(() => _acceptedTerms = val!),
          activeColor: AppTheme.primaryColor,
        ),
        const Expanded(
          child: Text(
            'Acepto los Términos de Servicio y la Política de Privacidad de TindPets.',
            style: TextStyle(color: Colors.white38, fontSize: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: _acceptedTerms ? () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const DiscoveryScreen()),
            (route) => false,
          );
        } : null,
        style: FilledButton.styleFrom(
          backgroundColor: AppTheme.primaryColor,
          padding: const EdgeInsets.symmetric(vertical: 20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        ),
        child: const Text('Crear Cuenta', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
