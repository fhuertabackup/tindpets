
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/pet.dart';
import '../theme/app_theme.dart';

class PetCard extends StatelessWidget {
  final Pet pet;

  const PetCard({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // Image
            Positioned.fill(
              child: Image.network(
                pet.imageUrls.first,
                fit: BoxFit.cover,
              ),
            ),
            // Gradient Overlay
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.8),
                    ],
                    stops: const [0.6, 1.0],
                  ),
                ),
              ),
            ),
            // Info
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '${pet.name}, ${pet.age}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      _buildVerificationBadge(pet.verificationLevel),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        pet.species == PetSpecies.dog
                            ? FontAwesomeIcons.dog
                            : FontAwesomeIcons.cat,
                        color: Colors.white70,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        pet.breed,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      if (pet.healthBadges['vacunas'] == true)
                        _buildHealthChip('Vacunas OK', AppTheme.accentColor),
                      if (pet.healthBadges['esterilizado'] == true)
                        _buildHealthChip('Esterilizado', Colors.blue),
                      _buildHealthChip(
                        pet.goal == Goal.breeding ? 'Reproducción' : 'Social',
                        pet.goal == Goal.breeding ? AppTheme.primaryColor : Colors.orange,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVerificationBadge(VerificationLevel level) {
    IconData icon;
    Color color;
    switch (level) {
      case VerificationLevel.declared:
        return const SizedBox.shrink();
      case VerificationLevel.inReview:
        icon = Icons.hourglass_empty;
        color = Colors.blue;
        break;
      case VerificationLevel.verifiedDocs:
        icon = Icons.verified;
        color = Colors.green;
        break;
      case VerificationLevel.officialRegistry:
        icon = Icons.stars;
        color = Colors.amber;
        break;
      case VerificationLevel.dnaVerified:
        icon = FontAwesomeIcons.dna;
        color = Colors.purple;
        break;
    }
    return Icon(icon, color: color, size: 24);
  }

  Widget _buildHealthChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.8),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white24),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
