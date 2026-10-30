
import 'package:flutter/material.dart';
import '../mission/mission_models.dart';

class MissionReadinessPage extends StatefulWidget {
  final ValueChanged<MissionState> onLaunch;

  const MissionReadinessPage({
    super.key,
    required this.onLaunch,
  });

  @override
  State<MissionReadinessPage> createState() =>
      _MissionReadinessPageState();
}

class _MissionReadinessPageState
    extends State<MissionReadinessPage> {
  MissionDestination destination = MissionDestination.moon;

  double oxygen = 100;
  double fuel = 100;
  double battery = 100;
  double food = 100;

  int get readinessScore =>
      ((oxygen + fuel + battery + food) / 4).round();

  Widget resourceSlider(
    String name,
    IconData icon,
    double value,
    ValueChanged<double> onChanged,
  ) {
    return Card(
      color: const Color(0xFF192B45),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.lightBlueAccent),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                Text(
                  '${value.round()}%',
                  style: const TextStyle(
                    color: Colors.greenAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Slider(
              value: value,
              min: 0,
              max: 100,
              divisions: 20,
              activeColor: Colors.lightBlueAccent,
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }

  void launchMission() {
    final mission = MissionState(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      destination: destination,
      status: MissionStatus.ready,
      resources: MissionResources(
        oxygen: oxygen,
        fuel: fuel,
        battery: battery,
        food: food,
      ),
      score: 0,
      completedEvents: 0,
      totalEvents: 0,
      decisionHistory: const [],
    );

    widget.onLaunch(mission);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF081426),
      appBar: AppBar(
        title: const Text('Mission Readiness Lab'),
        backgroundColor: const Color(0xFF10243D),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'PREPARE FOR SPACE EXPLORATION',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.lightBlueAccent,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Choose Your Mission',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: destinationCard(
                      'MOON',
                      '🌙',
                      MissionDestination.moon,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: destinationCard(
                      'MARS',
                      '🔴',
                      MissionDestination.mars,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),
              const Text(
                'Mission Resources',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              resourceSlider(
                'Oxygen Supply',
                Icons.air,
                oxygen,
                (v) => setState(() => oxygen = v),
              ),
              resourceSlider(
                'Fuel Supply',
                Icons.rocket_launch,
                fuel,
                (v) => setState(() => fuel = v),
              ),
              resourceSlider(
                'Battery Power',
                Icons.battery_charging_full,
                battery,
                (v) => setState(() => battery = v),
              ),
              resourceSlider(
                'Food Supply',
                Icons.restaurant,
                food,
                (v) => setState(() => food = v),
              ),

              const SizedBox(height: 22),
              Card(
                color: const Color(0xFF193B59),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Text(
                        'MISSION READINESS SCORE',
                        style: TextStyle(
                          color: Colors.white70,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '$readinessScore%',
                        style: const TextStyle(
                          color: Colors.greenAccent,
                          fontSize: 38,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        readinessScore >= 80
                            ? 'Ready for launch!'
                            : readinessScore >= 50
                                ? 'Preparation needs improvement'
                                : 'Mission resources are critical',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 22),
              ElevatedButton.icon(
                onPressed: launchMission,
                icon: const Icon(Icons.rocket_launch),
                label: const Text('LAUNCH MISSION'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 17),
                  textStyle: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  Widget destinationCard(
    String name,
    String emoji,
    MissionDestination value,
  ) {
    final selected = destination == value;

    return GestureDetector(
      onTap: () => setState(() => destination = value),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 22),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFF174A70)
              : const Color(0xFF192B45),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected
                ? Colors.lightBlueAccent
                : Colors.white24,
            width: selected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Text(
              emoji,
              style: const TextStyle(fontSize: 38),
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            if (selected)
              const Icon(
                Icons.check_circle,
                color: Colors.greenAccent,
              ),
          ],
        ),
      ),
    );
  }
}
