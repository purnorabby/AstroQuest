
enum MissionDestination {
  moon,
  mars,
}

enum MissionStatus {
  ready,
  inProgress,
  success,
  failed,
}

enum ResourceType {
  oxygen,
  fuel,
  battery,
  food,
}

class MissionResources {
  final double oxygen;
  final double fuel;
  final double battery;
  final double food;

  const MissionResources({
    this.oxygen = 100,
    this.fuel = 100,
    this.battery = 100,
    this.food = 100,
  });

  MissionResources copyWith({
    double? oxygen,
    double? fuel,
    double? battery,
    double? food,
  }) {
    return MissionResources(
      oxygen: oxygen ?? this.oxygen,
      fuel: fuel ?? this.fuel,
      battery: battery ?? this.battery,
      food: food ?? this.food,
    );
  }

  double valueOf(ResourceType type) {
    switch (type) {
      case ResourceType.oxygen:
        return oxygen;
      case ResourceType.fuel:
        return fuel;
      case ResourceType.battery:
        return battery;
      case ResourceType.food:
        return food;
    }
  }

  bool get hasCriticalResource =>
      oxygen <= 0 || fuel <= 0 || battery <= 0 || food <= 0;

  bool get needsWarning =>
      oxygen <= 25 || fuel <= 25 || battery <= 25 || food <= 25;
}

class MissionEvent {
  final String id;
  final String title;
  final String description;
  final String choiceA;
  final String choiceB;
  final MissionResources effectA;
  final MissionResources effectB;
  final int scoreA;
  final int scoreB;

  const MissionEvent({
    required this.id,
    required this.title,
    required this.description,
    required this.choiceA,
    required this.choiceB,
    required this.effectA,
    required this.effectB,
    this.scoreA = 10,
    this.scoreB = 5,
  });
}

class MissionState {
  final String id;
  final MissionDestination destination;
  final MissionStatus status;
  final MissionResources resources;
  final int score;
  final int completedEvents;
  final int totalEvents;
  final List<String> decisionHistory;

  const MissionState({
    required this.id,
    required this.destination,
    this.status = MissionStatus.ready,
    this.resources = const MissionResources(),
    this.score = 0,
    this.completedEvents = 0,
    this.totalEvents = 0,
    this.decisionHistory = const [],
  });

  double get progress {
    if (totalEvents <= 0) return 0;
    return (completedEvents / totalEvents).clamp(0.0, 1.0).toDouble();
  }

  MissionState copyWith({
    MissionStatus? status,
    MissionResources? resources,
    int? score,
    int? completedEvents,
    int? totalEvents,
    List<String>? decisionHistory,
  }) {
    return MissionState(
      id: id,
      destination: destination,
      status: status ?? this.status,
      resources: resources ?? this.resources,
      score: score ?? this.score,
      completedEvents: completedEvents ?? this.completedEvents,
      totalEvents: totalEvents ?? this.totalEvents,
      decisionHistory: decisionHistory ?? this.decisionHistory,
    );
  }
}
