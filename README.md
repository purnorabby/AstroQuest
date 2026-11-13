# AstroQuest — Junior Astronaut Mission Trainer

**Team:** Team Varendra Orbit  
**Event:** NASA Space Apps Challenge 2026  
**Region:** Rajshahi, Bangladesh

## Overview

AstroQuest is an educational mission-training prototype designed to introduce young learners to the challenges of Moon and Mars exploration.

It transforms space-science learning into a decision-based simulation where junior astronauts monitor mission resources, respond to unexpected events, make critical decisions, and receive a mission performance score.

The project aims to make space exploration more interactive, engaging, and accessible through a simple simulation experience.

## Prototype Features

- Moon and Mars mission selection
- Interactive mission dashboard
- Oxygen, fuel, and battery monitoring
- Decision-based mission events
- Resource changes based on astronaut decisions
- Mission scoring system
- Final mission report
- NASA data-source documentation
- Blender procedural scene starter
- Offline local mission data

## Technologies Used

- Flutter
- Dart
- Blender
- GitHub
- NASA Open APIs and publicly available NASA data references

## Repository Structure

```text
AstroQuest/
│
├── flutter_app/          # Flutter application
├── simulation_engine/    # Mission rules and sample scenarios
├── blender/              # Blender procedural starter
├── nasa_data/            # NASA data-source documentation
├── docs/                 # Architecture and mission design
│
└── README.md
```

## Getting Started

### Requirements

- Flutter SDK
- Dart SDK
- Android Studio or Visual Studio Code
- Chrome (for Web version)

### Installation

Clone the repository:

```bash
git clone https://github.com/purnorabby/AstroQuest.git
```

Open the Flutter application directory:

```bash
cd AstroQuest/flutter_app
```

Install dependencies:

```bash
flutter pub get
```

Run the application:

```bash
flutter run
```

### Run on Web

```bash
flutter run -d chrome
```

Build the Web version:

```bash
flutter build web
```

## Automated Verification

AstroQuest uses GitHub Actions for automated Flutter verification.

The CI workflow performs the following checks:

- Flutter code analysis
- Automated widget tests
- Flutter Web build

**Latest successful CI run:** All three checks passed.

Workflow configuration:

`.github/workflows/flutter-ci.yml`

## NASA Data and References

AstroQuest includes documentation of NASA data sources relevant to Moon and Mars mission environments.

The prototype currently uses local sample values for its core simulation. NASA datasets and API references are documented separately in the `nasa_data/` directory.

Official NASA API Portal:

https://api.nasa.gov/

## Current Development Status

AstroQuest is an educational prototype demonstrating a decision-based approach to astronaut mission training.

The Flutter application has passed its current automated code analysis, widget tests, and Web build checks through GitHub Actions.

Further development can expand the simulation, improve 3D environments, and integrate validated NASA datasets.

## Team Varendra Orbit

NASA Space Apps Challenge 2026 — Rajshahi, Bangladesh

**GitHub Repository:**  
https://github.com/purnorabby/AstroQuest

---

*Exploring the Moon and Mars through learning, simulation, and decisions.*
