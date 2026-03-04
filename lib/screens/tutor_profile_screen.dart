
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/pet_provider.dart';
import '../theme/app_theme.dart';
import 'pet_health_screen.dart';
import 'add_pet_wizard_screen.dart';
import 'settings_screen.dart';
import 'welcome_screen.dart';

class TutorProfileScreen extends StatelessWidget {
  const TutorProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pets = Provider.of<PetProvider>(context).pets;

    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context),
          SliverPadding(
            padding: const EdgeInsets.all(24),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildTutorInfo(),
                const SizedBox(height: 48),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Mis Mascotas', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    TextButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AddPetWizardScreen()),
                        );
                      },
                      icon: const Icon(Icons.add_circle_outline, size: 16),
                      label: const Text('Agregar Mascotas'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ...pets.map((pet) => _buildPetManagerCard(context, pet)),
                const SizedBox(height: 48),
                const Text('Configuración y Privacidad', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                _buildSettingsTile(context, Icons.person_outline, 'Ajustes del perfil'),
                _buildSettingsTile(context, Icons.security_outlined, 'Privacidad y seguridad'),
                _buildSettingsTile(context, Icons.notifications_outlined, 'Notificaciones'),
                _buildSettingsTile(context, Icons.help_outline, 'Ayuda y soporte'),
                const SizedBox(height: 48),
                _buildLogoutButton(context),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, size: 20),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.settings_outlined), 
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen(title: 'Ajustes del perfil')))
        ),
      ],
    );
  }

  Widget _buildTutorInfo() {
    return Column(
      children: [
        const CircleAvatar(
          radius: 60,
          backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=12'),
        ),
        const SizedBox(height: 24),
        const Text(
          'Felipe Huerta',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        Text(
          'Tutor Verificado • 3 Mascotas',
          style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 14),
        ),
        const SizedBox(height: 24),
        _buildVerificationBadge(),
      ],
    );
  }

  Widget _buildVerificationBadge() {
    return GlassContainer(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      borderRadius: 100,
      color: Colors.blueAccent,
      opacity: 0.1,
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.verified, color: Colors.blueAccent, size: 16),
          SizedBox(width: 8),
          Text('Identidad Confirmada', style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildPetManagerCard(BuildContext context, dynamic pet) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PetHealthScreen(pet: pet)),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(pet.imageUrls.first),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(pet.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(pet.breed, style: TextStyle(color: Colors.white.withOpacity(0.5))),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.white30),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsTile(BuildContext context, IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.white70),
      title: Text(title, style: const TextStyle(fontSize: 16)),
      trailing: const Icon(Icons.chevron_right, size: 20, color: Colors.white24),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen(title: title)));
      },
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const WelcomeScreen()),
          (route) => false,
        );
      },
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.redAccent,
        side: const BorderSide(color: Colors.redAccent, width: 1),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: const Text('Cerrar Sesión', style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}
