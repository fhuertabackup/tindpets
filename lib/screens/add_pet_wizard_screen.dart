
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AddPetWizardScreen extends StatefulWidget {
  const AddPetWizardScreen({super.key});

  @override
  State<AddPetWizardScreen> createState() => _AddPetWizardScreenState();
}

class _AddPetWizardScreenState extends State<AddPetWizardScreen> {
  int _currentStep = 0;
  
  // Step 1: Basic Info
  final _nameController = TextEditingController();
  String _selectedSpecies = 'Perro';
  String _selectedGender = 'Macho';

  // Step 2: Details
  String _selectedEnergy = 'Media';
  String _selectedGoal = 'Socialización';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: _buildStepIndicator(),
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _buildBasicInfoStep(),
          _buildDetailsStep(),
          _buildMediaStep(),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildStepIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: index <= _currentStep ? AppTheme.primaryColor : Colors.white24,
          borderRadius: BorderRadius.circular(2),
        ),
      )),
    );
  }

  Widget _buildBasicInfoStep() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Cuéntanos de tu\nmascota 🐾', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
          const SizedBox(height: 32),
          _buildTextField('¿Cómo se llama?', _nameController),
          const SizedBox(height: 24),
          _buildDropdown('Especie', ['Perro', 'Gato'], _selectedSpecies, (val) => setState(() => _selectedSpecies = val!)),
          const SizedBox(height: 24),
          _buildDropdown('Sexo', ['Macho', 'Hembra'], _selectedGender, (val) => setState(() => _selectedGender = val!)),
        ],
      ),
    );
  }

  Widget _buildDetailsStep() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Personalidad y\nObjetivos ✨', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
          const SizedBox(height: 32),
          _buildDropdown('Nivel de energía', ['Baja', 'Media', 'Alta', 'Explosiva'], _selectedEnergy, (val) => setState(() => _selectedEnergy = val!)),
          const SizedBox(height: 24),
          _buildDropdown('¿Qué buscas?', ['Socialización', 'Cruza Responsable', 'Ambos'], _selectedGoal, (val) => setState(() => _selectedGoal = val!)),
          const SizedBox(height: 24),
          _buildTextField('Breve descripción', TextEditingController(), maxLines: 3),
        ],
      ),
    );
  }

  Widget _buildMediaStep() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Sube sus mejores\nfotos 📸', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
          const SizedBox(height: 32),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: 6,
              itemBuilder: (context, index) => Container(
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white24, style: BorderStyle.merge(BorderSide.none, BorderSide.none)),
                ),
                child: const Icon(Icons.add_a_photo_outlined, color: Colors.white38),
              ),
            ),
          ),
          const Center(
            child: Text(
              'Añade al menos 2 fotos para continuar',
              style: TextStyle(color: Colors.white38, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          children: [
            if (_currentStep > 0)
              IconButton(
                onPressed: () => setState(() => _currentStep--),
                icon: const Icon(Icons.arrow_back, color: Colors.white),
              ),
            const Spacer(),
            SizedBox(
              width: 200,
              child: FilledButton(
                onPressed: () {
                  if (_currentStep < 2) {
                    setState(() => _currentStep++);
                  } else {
                    Navigator.pop(context);
                  }
                },
                style: FilledButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                ),
                child: Text(_currentStep < 2 ? 'Siguiente' : 'Finalizar'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 14)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white.withOpacity(0.05),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown(String label, List<String> items, String current, Function(String?) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 14)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: current,
              isExpanded: true,
              dropdownColor: Colors.grey[900],
              style: const TextStyle(color: Colors.white),
              items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
