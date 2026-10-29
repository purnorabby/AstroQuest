
import 'mission_models.dart';

class MissionSimulator {
  const MissionSimulator();

  MissionState start(MissionState mission) {
    if (mission.status != MissionStatus.ready) {
      return mission;
    }

    return mission.copyWith(
      status: MissionStatus.inProgress,
    );
  }

  MissionState applyDecision({
    required MissionState mission,
    required MissionEvent event,
    required bool chooseA,
  }) {
    if (mission.status != MissionStatus.inProgress) {
      return mission;
    }

    if (mission.decisionHistory.contains(event.id)) {
      return mission;
    }

    final effect = chooseA ? event.effectA : event.effectB;
    final points = chooseA ? event.scoreA : event.scoreB;

    final current = mission.resources;

    final updatedResources = MissionResources(
      oxygen: _clamp(current.oxygen + effect.oxygen - 100),
      fuel: _clamp(current.fuel + effect.fuel - 100),
      battery: _clamp(current.battery + effect.battery - 100),
      food: _clamp(current.food + effect.food - 100),
    );

    final updatedHistory = [
      ...mission.decisionHistory,
      event.id,
    ];

    final updatedCount = mission.completedEvents + 1;
    final completed = mission.totalEvents > 0 &&
        updatedCount >= mission.totalEvents;

    final failed = updatedResources.hasCriticalResource;

    return mission.copyWith(
      resources: updatedResources,
      score: mission.score + points,
      completedEvents: updatedCount,
      decisionHistory: updatedHistory,
      status: failed
          ? MissionStatus.failed
          : completed
              ? MissionStatus.success
              : MissionStatus.inProgress,
    );
  }

  double _clamp(double value) {
    return value.clamp(0.0, 100.0).toDouble();
  }
}
