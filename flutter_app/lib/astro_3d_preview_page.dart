import 'package:flutter/material.dart';
import 'astro_3d_viewer.dart';

class Astro3DPreviewPage extends StatefulWidget {
  const Astro3DPreviewPage({super.key});
  @override
  State<Astro3DPreviewPage> createState() => _Astro3DPreviewPageState();
}

class _Astro3DPreviewPageState extends State<Astro3DPreviewPage> {
  int selected = 0;
  static const scenes = <_SceneInfo>[
    _SceneInfo('Astronaut', 'Junior astronaut model and suit inspection.', 'assets/3d/astronaut/astronaut.glb', Color(0xFF55B6FF)),
    _SceneInfo('Moon Surface', 'Lunar terrain, craters and landing zone.', 'assets/3d/moon/moon_surface.glb', Color(0xFFB8C4D6)),
    _SceneInfo('Mars Surface', 'Red planet terrain and exploration area.', 'assets/3d/mars/mars_surface.glb', Color(0xFFFF805D)),
    _SceneInfo('Lunar Rover', 'Rover model for surface exploration.', 'assets/3d/rover/lunar_rover.glb', Color(0xFFFFD166)),
    _SceneInfo('Spacecraft', 'Mission spacecraft and landing vehicle.', 'assets/3d/spacecraft/spacecraft.glb', Color(0xFFB69CFF)),
  ];

  @override
  Widget build(BuildContext context) {
    final scene = scenes[selected];
    return Scaffold(
      backgroundColor: const Color(0xFF050B18),
      appBar: AppBar(title: const Text('ASTROQUEST 3D LAB'), backgroundColor: const Color(0xFF0A1426)),
      body: Column(children: [
        Expanded(child: Astro3DViewer(key: ValueKey(scene.asset), assetPath: scene.asset, title: scene.title, description: scene.description, accentColor: scene.color)),
        Container(
          color: const Color(0xFF0A1426),
          padding: const EdgeInsets.fromLTRB(14, 14, 14, 22),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(scene.title, style: const TextStyle(color: Colors.white, fontSize: 21, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Text(scene.description, style: const TextStyle(color: Colors.white70)),
            const SizedBox(height: 14),
            SizedBox(height: 48, child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: scenes.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) => ChoiceChip(
                label: Text(scenes[index].title),
                selected: selected == index,
                onSelected: (_) => setState(() => selected = index),
              ),
            )),
            const SizedBox(height: 8),
            const Text('Add a matching GLB file to its assets/3d folder to load the real model.', style: TextStyle(color: Colors.white38, fontSize: 11)),
          ]),
        ),
      ]),
    );
  }
}

class _SceneInfo {
  final String title, description, asset;
  final Color color;
  const _SceneInfo(this.title, this.description, this.asset, this.color);
}
