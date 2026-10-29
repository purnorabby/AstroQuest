# AstroQuest Completion Roadmap

## Phase 1 — Core prototype (partially implemented)
- [x] Moon and Mars mission entry points
- [x] Decision-based mission events
- [x] Resource meters and mission report
- [x] Offline mission-readiness calculator
- [x] Readiness input/result screens
- [x] Basic simulator unit tests
- [ ] Run Flutter analysis and tests in a Flutter-enabled environment
- [ ] Add widget tests for the end-to-end event flow

## Phase 2 — Improve architecture
- [ ] Move event scenarios out of `main.dart` into typed data models or JSON assets
- [ ] Make the Flutter app load `simulation_engine/sample_missions.json`
- [ ] Separate scoring rules into a testable service
- [ ] Add save/resume and reset mission controls
- [ ] Add localization and accessibility review

## Phase 3 — Visual simulation
- [ ] Refine Blender scene, materials, lighting, camera and labels
- [ ] Export optimized assets only if they are intended for app use
- [ ] Choose and document an actual Flutter 3D rendering approach if interactive 3D is required
- [ ] Do not describe a static Blender scene as a live app simulation

## Phase 4 — NASA data
- [ ] Select specific official datasets or APIs
- [ ] Record source URL, license, retrieval date and units
- [ ] Validate data and explain its limitations
- [ ] Add caching and offline fallback
- [ ] Keep educational scenario values clearly separate from sourced measurements

## Phase 5 — Release readiness
- [ ] Run `flutter analyze` and `flutter test`
- [ ] Build and test on an Android device/emulator
- [ ] Add screenshots and a short demo video
- [ ] Update installation instructions and team credits
- [ ] Create a release only after a clean build

## Definition of a complete educational prototype

A learner can launch the app, select Moon or Mars, make choices through the complete event flow, receive a non-broken final report, configure a resource scenario, see resource shortfalls, and repeat a scenario. All scientific assumptions and unimplemented integrations are clearly disclosed.
