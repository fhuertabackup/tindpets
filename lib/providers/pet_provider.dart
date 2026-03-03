
import 'package:flutter/material.dart';
import '../models/pet.dart';

class PetProvider with ChangeNotifier {
  final List<Pet> _pets = [
    Pet(
      id: '1',
      name: 'Firulais',
      species: PetSpecies.dog,
      breed: 'Golden Retriever',
      gender: Gender.male,
      birthDate: DateTime(2020, 5, 12),
      energyLevel: EnergyLevel.high,
      goal: Goal.both,
      verificationLevel: VerificationLevel.verifiedDocs,
      imageUrls: [
        'https://images.unsplash.com/photo-1552053831-71594a27632d?q=80&w=1000&auto=format&fit=crop',
        'https://images.unsplash.com/photo-1583511655857-d19b40a7a54e?q=80&w=1000&auto=format&fit=crop',
      ],
      description: 'Soy muy juguetón y busco amigos para correr en el parque o una pareja con papeles al día.',
      healthBadges: {'vacunas': true, 'desparasitado': true, 'esterilizado': false},
    ),
    Pet(
      id: '2',
      name: 'Luna',
      species: PetSpecies.cat,
      breed: 'Siamés',
      gender: Gender.female,
      birthDate: DateTime(2021, 2, 20),
      energyLevel: EnergyLevel.medium,
      goal: Goal.social,
      verificationLevel: VerificationLevel.dnaVerified,
      imageUrls: [
        'https://images.unsplash.com/photo-1513245543132-31f507417b26?q=80&w=1000&auto=format&fit=crop',
      ],
      description: 'Una gatita elegante que busca socializar con otros felinos de su clase.',
      healthBadges: {'vacunas': true, 'desparasitado': true, 'esterilizado': true},
    ),
    Pet(
      id: '3',
      name: 'Rocky',
      species: PetSpecies.dog,
      breed: 'Bulldog Francés',
      gender: Gender.male,
      birthDate: DateTime(2019, 11, 5),
      energyLevel: EnergyLevel.low,
      goal: Goal.breeding,
      verificationLevel: VerificationLevel.officialRegistry,
      imageUrls: [
        'https://images.unsplash.com/photo-1583512603805-3cc6b41f3edb?q=80&w=1000&auto=format&fit=crop',
      ],
      description: 'Macho ALPHA buscando expandir mi linaje. Todos mis papeles están en orden.',
      healthBadges: {'vacunas': true, 'desparasitado': true, 'esterilizado': false},
    ),
  ];

  List<Pet> get pets => [..._pets];

  void removePet(String id) {
    _pets.removeWhere((pet) => pet.id == id);
    notifyListeners();
  }
}
