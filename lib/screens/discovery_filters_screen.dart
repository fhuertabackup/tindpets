
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class DiscoveryFiltersScreen extends StatefulWidget {
  const DiscoveryFiltersScreen({super.key});

  @override
  State<DiscoveryFiltersScreen> createState() => _DiscoveryFiltersScreenState();
}

class _DiscoveryFiltersScreenState extends State<DiscoveryFiltersScreen> {
  RangeValues _ageRange = const RangeValues(0, 15);
  double _distance = 10;
  String _selectedSpecies = 'Todos';
  final List<String> _selectedGoals = ['Socialización'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Filtros', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Limpiar', style: TextStyle(color: Colors.white60)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Especie'),
            const SizedBox(height: 12),
            _buildSpeciesSelector(),
            const SizedBox(height: 32),
            
            _buildSectionTitle('Distancia máxima (${_distance.toInt()} km)'),
            Slider(
              value: _distance,
              min: 1,
              max: 100,
              activeColor: AppTheme.primaryColor,
              inactiveColor: Colors.white10,
              onChanged: (val) => setState(() => _distance = val),
            ),
            const SizedBox(height: 32),

            _buildSectionTitle('Rango de edad (${_ageRange.start.toInt()} - ${_ageRange.end.toInt()} años)'),
            RangeSlider(
              values: _ageRange,
              min: 0,
              max: 20,
              activeColor: AppTheme.primaryColor,
              inactiveColor: Colors.white10,
              onChanged: (val) => setState(() => _ageRange = val),
            ),
            const SizedBox(height: 32),

            _buildSectionTitle('Objetivo'),
            const SizedBox(height: 12),
            _buildGoalChips(),
          ],
        ),
      ),
      bottomNavigationBar: _buildApplyButton(),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white70),
    );
  }

  Widget _buildSpeciesSelector() {
    return Row(
      children: ['Todos', 'Perros', 'Gatos'].map((s) => Expanded(
        child: GestureDetector(
          onTap: () => setState(() => _selectedSpecies = s),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: _selectedSpecies == s ? AppTheme.primaryColor : Colors.white10,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(s, style: TextStyle(
                color: _selectedSpecies == s ? Colors.white : Colors.white60,
                fontWeight: _selectedSpecies == s ? FontWeight.bold : FontWeight.normal,
              )),
            ),
          ),
        ),
      )).toList(),
    );
  }

  Widget _buildGoalChips() {
    final goals = ['Socialización', 'Cruza Responsable', 'Paseos'];
    return Wrap(
      spacing: 8,
      children: goals.map((g) {
        final isSelected = _selectedGoals.contains(g);
        return FilterChip(
          label: Text(g),
          selected: isSelected,
          onSelected: (val) {
            setState(() {
              if (val) _selectedGoals.add(g);
              else _selectedGoals.remove(g);
            });
          },
          selectedColor: AppTheme.primaryColor.withOpacity(0.2),
          checkmarkColor: AppTheme.primaryColor,
          backgroundColor: Colors.white10,
          labelStyle: TextStyle(color: isSelected ? AppTheme.primaryColor : Colors.white60),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        );
      }).toList(),
    );
  }

  Widget _buildApplyButton() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: FilledButton(
          onPressed: () => Navigator.pop(context),
          style: FilledButton.styleFrom(
            backgroundColor: AppTheme.primaryColor,
            padding: const EdgeInsets.symmetric(vertical: 20),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          ),
          child: const Text('Aplicar Filtros', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
