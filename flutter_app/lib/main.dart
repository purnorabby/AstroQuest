
import 'package:flutter/material.dart';

import 'mission/mission_models.dart';
import 'mission/mission_simulator.dart';

void main() => runApp(const AstroQuestApp());

const accent = Color(0xFF55B6FF);

class AstroQuestApp extends StatelessWidget {
  const AstroQuestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AstroQuest',
      theme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: accent,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void start(BuildContext context, MissionDestination destination) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MissionPage(destination: destination),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              const Icon(Icons.rocket_launch, size: 68, color: accent),
              const SizedBox(height: 18),
              const Text(
                'ASTROQUEST',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 3,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Junior Astronaut Mission Trainer',
                style: TextStyle(fontSize: 17, color: Colors.white70),
              ),
              const SizedBox(height: 30),
              _missionButton(
                context,
                'MOON MISSION',
                'Lunar landing & exploration',
                Icons.nightlight_round,
                () => start(context, MissionDestination.moon),
              ),
              const SizedBox(height: 14),
              _missionButton(
                context,
                'MARS MISSION',
                'Surface expedition simulation',
                Icons.public,
                () => start(context, MissionDestination.mars),
              ),
              const Spacer(),
              const Center(
                child: Text(
                  'TEAM VARENDRA ORBIT • NASA SPACE APPS 2026',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 11, color: Colors.white38),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _missionButton(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Icon(icon, color: accent, size: 34),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(subtitle,
                        style: const TextStyle(color: Colors.white60)),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}

class MissionPage extends StatefulWidget {
  final MissionDestination destination;

  const MissionPage({super.key, required this.destination});

  @override
  State<MissionPage> createState() => _MissionPageState();
}

class _MissionPageState extends State<MissionPage> {
  static const simulator = MissionSimulator();

  late final List<MissionEvent> events;
  late MissionState mission;
  bool navigatingToReport = false;

  String get missionName =>
      widget.destination == MissionDestination.moon ? 'Moon' : 'Mars';

  @override
  void initState() {
    super.initState();

    events = widget.destination == MissionDestination.moon
        ? moonEvents
        : marsEvents;

    mission = simulator.start(
      MissionState(
        id: '${missionName.toLowerCase()}-${DateTime.now().millisecondsSinceEpoch}',
        destination: widget.destination,
        totalEvents: events.length,
      ),
    );
  }

  void choose(MissionEvent event, bool chooseA) {
    if (mission.status != MissionStatus.inProgress ||
        navigatingToReport) {
      return;
    }

    final updated = simulator.applyDecision(
      mission: mission,
      event: event,
      chooseA: chooseA,
    );

    setState(() {
      mission = updated;
    });

    if (updated.status == MissionStatus.success ||
        updated.status == MissionStatus.failed) {
      navigatingToReport = true;
      Future.delayed(const Duration(milliseconds: 250), () {
        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => ResultPage(mission: mission),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final index = mission.completedEvents;

    if (index >= events.length) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final event = events[index];
    final resources = mission.resources;

    return Scaffold(
      appBar: AppBar(
        title: Text('${missionName.toUpperCase()} MISSION'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: _resource('OXYGEN', resources.oxygen)),
                      Expanded(child: _resource('FUEL', resources.fuel)),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(child: _resource('BATTERY', resources.battery)),
                      Expanded(child: _resource('FOOD', resources.food)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(value: mission.progress),
          const SizedBox(height: 8),
          Text(
            'MISSION EVENT ${index + 1}/${events.length}',
            style: const TextStyle(
              color: accent,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.explore, size: 42, color: accent),
                  const SizedBox(height: 14),
                  Text(
                    event.title,
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    event.description,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (resources.needsWarning) ...[
            const SizedBox(height: 10),
            const Card(
              child: ListTile(
                leading: Icon(Icons.warning_amber, color: Colors.orange),
                title: Text('Resource warning'),
                subtitle: Text(
                  'A resource is running low. Choose your next action carefully.',
                ),
              ),
            ),
          ],
          const SizedBox(height: 14),
          _choiceButton(
            event.choiceA,
            () => choose(event, true),
          ),
          const SizedBox(height: 12),
          _choiceButton(
            event.choiceB,
            () => choose(event, false),
          ),
          const SizedBox(height: 20),
          Center(
            child: Text(
              'Current score: ${mission.score}',
              style: const TextStyle(color: Colors.white60),
            ),
          ),
        ],
      ),
    );
  }

  Widget _resource(String label, double value) {
    final amount = value.round();
    final color = amount <= 25 ? Colors.redAccent : accent;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(color: Colors.white54, fontSize: 11)),
        const SizedBox(height: 5),
        Text(
          '$amount%',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: LinearProgressIndicator(
            value: amount / 100,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _choiceButton(String text, VoidCallback onPressed) {
    return FilledButton(
      onPressed: navigatingToReport ? null : onPressed,
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
      ),
      child: Text(text, textAlign: TextAlign.center),
    );
  }
}

class ResultPage extends StatelessWidget {
  final MissionState mission;

  const ResultPage({super.key, required this.mission});

  @override
  Widget build(BuildContext context) {
    final resources = mission.resources;
    final average = (
      resources.oxygen +
      resources.fuel +
      resources.battery +
      resources.food
    ) / 4;

    final rawScore = mission.totalEvents > 0
        ? (mission.score / (mission.totalEvents * 10)) * 70 +
            average * 0.30
        : 0.0;

    final finalScore = rawScore.round().clamp(0, 100);
    final success = mission.status == MissionStatus.success;
    final destination =
        mission.destination == MissionDestination.moon ? 'MOON' : 'MARS';

    return Scaffold(
      appBar: AppBar(title: const Text('MISSION REPORT')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Icon(
            success ? Icons.emoji_events : Icons.warning_amber_rounded,
            size: 80,
            color: success ? accent : Colors.orangeAccent,
          ),
          const SizedBox(height: 18),
          Text(
            success ? '$destination MISSION COMPLETE' : '$destination MISSION FAILED',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            success
                ? 'Mission objectives completed.'
                : 'A critical resource was depleted. Review your decisions and try again.',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 20),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Text(
                    '$finalScore',
                    style: const TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const Text(
                    'MISSION SCORE',
                    style: TextStyle(color: Colors.white54),
                  ),
                  const Divider(height: 30),
                  _reportResource('Oxygen', resources.oxygen),
                  _reportResource('Fuel', resources.fuel),
                  _reportResource('Battery', resources.battery),
                  _reportResource('Food', resources.food),
                  const Divider(height: 24),
                  Text('Decisions completed: ${mission.completedEvents}'),
                  Text('Decision points: ${mission.score}'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 22),
          FilledButton.icon(
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            icon: const Icon(Icons.home),
            label: const Text('RETURN TO MISSION HUB'),
          ),
        ],
      ),
    );
  }

  Widget _reportResource(String label, double value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text('${value.round()}%'),
        ],
      ),
    );
  }
}

// Resource values are percentages. For example, oxygen: 98 means
// oxygen decreases from 100% to 98%.
const moonEvents = <MissionEvent>[
  MissionEvent(
    id: 'moon-landing',
    title: 'Landing Guidance Alert',
    description: 'A navigation warning appears during lunar descent.',
    choiceA: 'Slow down and recalibrate navigation',
    choiceB: 'Continue at current descent rate',
    effectA: MissionResources(oxygen: 98, fuel: 97, battery: 98, food: 100),
    effectB: MissionResources(oxygen: 99, fuel: 99, battery: 99, food: 100),
    scoreA: 10,
    scoreB: 4,
  ),
  MissionEvent(
    id: 'moon-power',
    title: 'Power Fluctuation',
    description: 'A non-essential system is consuming extra battery power.',
    choiceA: 'Disable non-essential systems',
    choiceB: 'Keep all systems active',
    effectA: MissionResources(battery: 100, food: 100),
    effectB: MissionResources(battery: 92, food: 100),
    scoreA: 10,
    scoreB: 2,
  ),
  MissionEvent(
    id: 'moon-route',
    title: 'Surface Route',
    description: 'Choose a route to the lunar exploration zone.',
    choiceA: 'Take the safer mapped route',
    choiceB: 'Take the shorter unknown route',
    effectA: MissionResources(fuel: 96, battery: 98, food: 100),
    effectB: MissionResources(fuel: 98, battery: 95, food: 100),
    scoreA: 10,
    scoreB: 4,
  ),
];

const marsEvents = <MissionEvent>[
  MissionEvent(
    id: 'mars-storm',
    title: 'Dust Storm Warning',
    description: 'A regional dust storm is approaching the exploration zone.',
    choiceA: 'Return to habitat and secure equipment',
    choiceB: 'Continue exploration',
    effectA: MissionResources(oxygen: 97, fuel: 98, battery: 98, food: 100),
    effectB: MissionResources(oxygen: 98, fuel: 99, battery: 94, food: 100),
    scoreA: 10,
    scoreB: 3,
  ),
  MissionEvent(
    id: 'mars-communication',
    title: 'Communication Delay',
    description: 'Direct communication with mission control is temporarily unavailable.',
    choiceA: 'Follow the pre-approved contingency plan',
    choiceB: 'Attempt repeated transmissions',
    effectA: MissionResources(oxygen: 99, fuel: 99, battery: 99, food: 100),
    effectB: MissionResources(oxygen: 99, fuel: 100, battery: 95, food: 100),
    scoreA: 10,
    scoreB: 3,
  ),
  MissionEvent(
    id: 'mars-sample',
    title: 'Sample Collection',
    description: 'A scientifically interesting surface sample is within reach.',
    choiceA: 'Collect the sample using the planned procedure',
    choiceB: 'Collect it quickly without full procedure',
    effectA: MissionResources(oxygen: 98, fuel: 100, battery: 97, food: 100),
    effectB: MissionResources(oxygen: 99, fuel: 100, battery: 99, food: 100),
    scoreA: 10,
    scoreB: 4,
  ),
];
