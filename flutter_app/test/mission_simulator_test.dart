
import 'package:flutter_test/flutter_test.dart';
import 'package:astroquest/mission/mission_models.dart';
import 'package:astroquest/mission/mission_simulator.dart';

void main() {
  const simulator = MissionSimulator();

  group('MissionSimulator', () {
    test('starts a ready mission', () {
      const mission = MissionState(
        id: 'moon-01',
        destination: MissionDestination.moon,
        totalEvents: 2,
      );

      final result = simulator.start(mission);

      expect(result.status, MissionStatus.inProgress);
    });

    test('applies a decision and records its event', () {
      const mission = MissionState(
        id: 'moon-01',
        destination: MissionDestination.moon,
        status: MissionStatus.inProgress,
        totalEvents: 2,
      );

      const event = MissionEvent(
        id: 'event-01',
        title: 'Power warning',
        description: 'Power is running low.',
        choiceA: 'Save power',
        choiceB: 'Continue normally',
        effectA: MissionResources(
          oxygen: 100,
          fuel: 100,
          battery: 90,
          food: 100,
        ),
        effectB: MissionResources(),
        scoreA: 10,
        scoreB: 5,
      );

      final result = simulator.applyDecision(
        mission: mission,
        event: event,
        chooseA: true,
      );

      expect(result.resources.battery, 90);
      expect(result.score, 10);
      expect(result.completedEvents, 1);
      expect(result.decisionHistory, contains('event-01'));
    });

    test('does not apply the same event twice', () {
      const mission = MissionState(
        id: 'moon-01',
        destination: MissionDestination.moon,
        status: MissionStatus.inProgress,
        totalEvents: 3,
        score: 10,
        completedEvents: 1,
        decisionHistory: ['event-01'],
      );

      const event = MissionEvent(
        id: 'event-01',
        title: 'Power warning',
        description: 'Power is running low.',
        choiceA: 'Save power',
        choiceB: 'Continue normally',
        effectA: MissionResources(
          battery: 90,
        ),
        effectB: MissionResources(),
      );

      final result = simulator.applyDecision(
        mission: mission,
        event: event,
        chooseA: true,
      );

      expect(result.score, 10);
      expect(result.completedEvents, 1);
    });
  });
}
