
enum HealthStatus { pending, verified, rejected }

class Vaccine {
  final String id;
  final String name;
  final DateTime date;
  final String provider;
  final HealthStatus status;

  Vaccine({
    required this.id,
    required this.name,
    required this.date,
    required this.provider,
    this.status = HealthStatus.pending,
  });
}

class HealthRecord {
  final String petId;
  final List<Vaccine> vaccines;
  final bool isNeutered;
  final String weight;
  final String bloodType;

  HealthRecord({
    required this.petId,
    required this.vaccines,
    this.isNeutered = false,
    this.weight = '---',
    this.bloodType = '---',
  });
}
