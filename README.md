# AstroQuest — Junior Astronaut Mission Trainer

Team: Team Varendra Orbit
NASA Space Apps Challenge 2026 — Rajshahi

AstroQuest is an educational mission-training prototype for Moon and Mars missions. It turns space-science learning into a decision-based simulation where a junior astronaut monitors mission resources, responds to events, makes decisions, and receives a mission score.

## Prototype features
- Moon and Mars mission selection
- Mission dashboard
- Oxygen, fuel and battery monitoring
- Decision-based mission events
- Resource changes caused by decisions
- Mission scoring and final report
- NASA data-source documentation
- Blender procedural scene starter
- Offline local mission data

## Repository structure
- `flutter_app/` — Flutter prototype
- `simulation_engine/` — mission rules and sample scenarios
- `blender/` — Blender procedural starter
- `nasa_data/` — NASA source documentation
- `docs/` — project architecture and mission design

## Run
From `flutter_app`:

```bash
flutter pub get
flutter run
```

The prototype uses local sample values so the core simulation can work offline. Official NASA datasets can be integrated and validated during later development.
