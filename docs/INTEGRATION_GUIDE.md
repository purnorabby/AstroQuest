# Integration Notes

## What changed in this update

- Added `lib/mission/mission_models.dart` for typed mission inputs and result data.
- Added `lib/mission/mission_simulator.dart` for offline resource checks.
- Added a `MISSION READINESS LAB` entry on the existing home hub.
- Added setup and report screens for crew, duration, oxygen, water, food, solar capacity, power demand, and reserve allowance.
- Fixed the event flow so the final event routes to the mission report.
- Reworked the event score to combine decision points (70%) and average remaining resources (30%), rather than multiplying raw decision points into an always-maxed score.
- Added unit tests for the readiness calculator.

## Verification

Run from `flutter_app/`:

```bash
flutter pub get
flutter analyze
flutter test
```

Flutter/Dart were not available in the packaging environment, so this update has not been compiled or executed there. Run the commands above in a Flutter-enabled environment and fix any version-specific diagnostics before release.

## Current limitations

- The Flutter event scenarios are still declared in `main.dart`; the JSON in `simulation_engine/` is not yet the runtime source for those events.
- NASA links are documented but live API/data integration is not implemented.
- The Blender script creates a starter scene; it is not embedded in the Flutter app.
- Mission Readiness Lab uses simplified educational assumptions, not certified mission engineering values.
