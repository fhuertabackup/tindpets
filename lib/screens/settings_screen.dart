
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SettingsScreen extends StatelessWidget {
  final String title;
  const SettingsScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    switch (title) {
      case 'Ajustes del perfil':
        return _buildProfileSettings();
      case 'Privacidad y seguridad':
        return _buildPrivacySettings();
      case 'Notificaciones':
        return _buildNotificationSettings();
      case 'Ayuda y soporte':
        return _buildHelpSupport();
      default:
        return const Center(child: Text('Pantalla en construcción'));
    }
  }

  Widget _buildProfileSettings() {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        _buildUserHeader(),
        const SizedBox(height: 32),
        _buildSectionTitle('Información Personal'),
        _buildSettingTile(Icons.person_outline, 'Nombre', 'Felipe Huerta'),
        _buildSettingTile(Icons.email_outlined, 'Email', 'felipe@example.com'),
        _buildSettingTile(Icons.phone_outlined, 'Teléfono', '+56 9 1234 5678'),
        const SizedBox(height: 32),
        _buildSectionTitle('Ubicación'),
        _buildSettingTile(Icons.location_on_outlined, 'Ciudad', 'Santiago, Chile'),
        const SizedBox(height: 48),
        _buildActionButton('Guardar Cambios', AppTheme.primaryColor),
      ],
    );
  }

  Widget _buildPrivacySettings() {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        _buildSwitchTile('Perfil público', true),
        _buildSwitchTile('Mostrar ubicación', false),
        _buildSwitchTile('Confirmación de lectura', true),
        const SizedBox(height: 32),
        _buildSectionTitle('Seguridad'),
        _buildSettingTile(Icons.lock_outline, 'Cambiar contraseña', ''),
        _buildSettingTile(Icons.phonelink_lock_outlined, 'Autenticación de dos pasos', 'Desactivado'),
        const SizedBox(height: 48),
        _buildActionButton('Eliminar cuenta', Colors.redAccent.withOpacity(0.1), textColor: Colors.redAccent),
      ],
    );
  }

  Widget _buildNotificationSettings() {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        _buildSectionTitle('Push Notifications'),
        _buildSwitchTile('Nuevos Matches', true),
        _buildSwitchTile('Mensajes', true),
        _buildSwitchTile('Recordatorios de salud', true),
        _buildSwitchTile('Anuncios de la comunidad', false),
        const SizedBox(height: 32),
        _buildSectionTitle('Email Notifications'),
        _buildSwitchTile('Resumen semanal', false),
        _buildSwitchTile('Alertas de seguridad', true),
      ],
    );
  }

  Widget _buildHelpSupport() {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        _buildSettingTile(Icons.help_outline, 'Centro de ayuda', ''),
        _buildSettingTile(Icons.bug_report, 'Reportar un problema', ''),
        _buildSettingTile(Icons.info_outline, 'Términos y condiciones', ''),
        _buildSettingTile(Icons.privacy_tip, 'Política de privacidad', ''),
        const SizedBox(height: 48),
        const Center(
          child: Text(
            'TindPets v1.0.0',
            style: TextStyle(color: Colors.white24, fontSize: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildUserHeader() {
    return Center(
      child: Stack(
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=12'),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: AppTheme.primaryColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.camera_alt, color: Colors.white, size: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 14, color: Colors.white38, fontWeight: FontWeight.bold, letterSpacing: 1),
      ),
    );
  }

  Widget _buildSettingTile(IconData icon, String title, String value) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: Colors.white70, size: 22),
      title: Text(title, style: const TextStyle(fontSize: 16)),
      subtitle: value.isNotEmpty ? Text(value, style: TextStyle(color: Colors.white.withOpacity(0.4))) : null,
      trailing: const Icon(Icons.chevron_right, color: Colors.white24),
      onTap: () {},
    );
  }

  Widget _buildSwitchTile(String title, bool value) {
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title, style: const TextStyle(fontSize: 16)),
      value: value,
      onChanged: (val) {},
      activeColor: AppTheme.primaryColor,
    );
  }

  Widget _buildActionButton(String label, Color color, {Color textColor = Colors.white}) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: () {},
        style: FilledButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: Text(label, style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
