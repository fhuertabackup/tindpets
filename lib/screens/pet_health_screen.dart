
import 'package:flutter/material.dart';
import '../models/pet.dart';
import '../models/health.dart';
import '../theme/app_theme.dart';

class PetHealthScreen extends StatelessWidget {
  final Pet pet;

  const PetHealthScreen({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    // Mock health data
    final List<Vaccine> vaccines = [
      Vaccine(id: '1', name: 'Rabia', date: DateTime.now().subtract(const Duration(days: 45)), provider: 'Veterinaria San Roque', status: HealthStatus.verified),
      Vaccine(id: '2', name: 'Parvovirus', date: DateTime.now().subtract(const Duration(days: 10)), provider: 'Veterinaria San Roque', status: HealthStatus.pending),
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context),
          SliverPadding(
            padding: const EdgeInsets.all(24),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildVerificationBanner(),
                const SizedBox(height: 32),
                _buildSectionHeader('Estadísticas'),
                _buildHealthStats(),
                const SizedBox(height: 32),
                _buildSectionHeader('Plan de Vacunación'),
                ...vaccines.map((v) => _buildVaccineCard(v)),
                const SizedBox(height: 32),
                _buildActionButtons(),
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
      expandedHeight: 120,
      floating: true,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        titlePadding: const EdgeInsets.only(left: 24, bottom: 16),
        title: Text('Salud de ${pet.name}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      actions: [
        IconButton(icon: const Icon(Icons.share_outlined), onPressed: () {}),
      ],
    );
  }

  Widget _buildVerificationBanner() {
    return GlassContainer(
      padding: const EdgeInsets.all(20),
      color: Colors.blueAccent,
      opacity: 0.1,
      child: Row(
        children: [
          const Icon(Icons.verified_user, color: Colors.blueAccent, size: 40),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Verificación en progreso', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text('Sube tus documentos para obtener el badge oficial.', style: TextStyle(color: Colors.white.withOpacity(0.6))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(title, style: const TextStyle(fontSize: 18, color: Colors.white70)),
    );
  }

  Widget _buildHealthStats() {
    return Row(
      children: [
        _buildStatBox('Peso', '28kg', Icons.monitor_weight_outlined),
        const SizedBox(width: 16),
        _buildStatBox('Estado', 'Óptimo', Icons.favorite_border),
      ],
    );
  }

  Widget _buildStatBox(String label, String value, IconData icon) {
    return Expanded(
      child: GlassContainer(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, color: AppTheme.primaryColor),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(label, style: const TextStyle(color: Colors.white38, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildVaccineCard(Vaccine v) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(v.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(v.provider, style: TextStyle(color: Colors.white38, fontSize: 12)),
            ],
          ),
          Icon(
            v.status == HealthStatus.verified ? Icons.check_circle : Icons.pending,
            color: v.status == HealthStatus.verified ? Colors.green : Colors.orange,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: FilledButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.upload_file),
            label: const Text('Subir Doc'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.history),
            label: const Text('Historial'),
          ),
        ),
      ],
    );
  }
}
