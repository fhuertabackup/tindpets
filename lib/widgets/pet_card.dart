
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/pet.dart';
import '../theme/app_theme.dart';

class PetCard extends StatelessWidget {
  final Pet pet;
  final VoidCallback? onTap;

  const PetCard({super.key, required this.pet, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Stack(
            children: [
              // Image
              Positioned.fill(
                child: Hero(
                  tag: 'pet-${pet.id}',
                  child: Image.network(
                    pet.imageUrls.first,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Glow Overlay
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.1),
                        Colors.black.withOpacity(0.9),
                      ],
                      stops: const [0.4, 1.0],
                    ),
                  ),
                ),
              ),
              // Floating Badge (Top Right)
              if (pet.verificationLevel == VerificationLevel.dnaVerified)
                Positioned(
                  top: 20,
                  right: 20,
                  child: GlassContainer(
                    borderRadius: 15,
                    padding: const EdgeInsets.all(10),
                    child: const Icon(FontAwesomeIcons.dna, color: Colors.purpleAccent, size: 20),
                  ),
                ),
              // Info Panel
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${pet.name}, ${pet.age}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.location_on, color: Colors.white60, size: 14),
                                    const SizedBox(width: 4),
                                    Text(
                                      'A 2.5 km de distancia',
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.7),
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const GlassContainer(
                            borderRadius: 100,
                            padding: EdgeInsets.all(12),
                            child: Icon(Icons.info_outline, color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 8,
                        children: [
                          _buildPremiumChip(
                            pet.species == PetSpecies.dog ? 'Perro' : 'Gato',
                            Colors.grey.withOpacity(0.3),
                          ),
                          _buildPremiumChip(
                            pet.goal == Goal.breeding ? 'Reproducción' : 'Social',
                            AppTheme.primaryColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPremiumChip(String label, Color color) {
    return GlassContainer(
      borderRadius: 12,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      color: color,
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
