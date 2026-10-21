class Tournament {
  final String id;
  final String name;
  final String location;
  final String sport;
  final int maxTeams;
  final int currentTeams;

  const Tournament({
    required this.id,
    required this.name,
    required this.location,
    required this.sport,
    required this.maxTeams,
    required this.currentTeams,
  });
}
