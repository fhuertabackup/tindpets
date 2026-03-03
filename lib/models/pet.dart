
enum PetSpecies { dog, cat }
enum Gender { male, female }
enum EnergyLevel { low, medium, high, explosive }
enum Goal { social, breeding, both }
enum VerificationLevel { declared, inReview, verifiedDocs, officialRegistry, dnaVerified }

class Pet {
  final String id;
  final String name;
  final PetSpecies species;
  final String breed;
  final Gender gender;
  final DateTime birthDate;
  final EnergyLevel energyLevel;
  final Goal goal;
  final VerificationLevel verificationLevel;
  final List<String> imageUrls;
  final String description;
  final Map<String, bool> healthBadges; // e.g., {'vacunas': true, 'desparasitado': true}

  Pet({
    required this.id,
    required this.name,
    required this.species,
    required this.breed,
    required this.gender,
    required this.birthDate,
    required this.energyLevel,
    required this.goal,
    required this.verificationLevel,
    required this.imageUrls,
    required this.description,
    this.healthBadges = const {},
  });

  int get age {
    final now = DateTime.now();
    int age = now.year - birthDate.year;
    if (now.month < birthDate.month || (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    return age;
  }
}
