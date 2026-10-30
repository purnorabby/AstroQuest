import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

/// Shows a local GLB model when present; otherwise displays a space placeholder.
class Astro3DViewer extends StatefulWidget {
  final String assetPath;
  final String title;
  final String description;
  final Color accentColor;

  const Astro3DViewer({
    super.key,
    required this.assetPath,
    required this.title,
    required this.description,
    this.accentColor = const Color(0xFF55B6FF),
  });

  @override
  State<Astro3DViewer> createState() => _Astro3DViewerState();
}

class _Astro3DViewerState extends State<Astro3DViewer> {
  late Future<bool> assetExists;

  @override
  void initState() {
    super.initState();
    assetExists = _checkAsset();
  }

  @override
  void didUpdateWidget(covariant Astro3DViewer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.assetPath != widget.assetPath) assetExists = _checkAsset();
  }

  Future<bool> _checkAsset() async {
    try {
      await rootBundle.load(widget.assetPath);
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<bool>(
        future: assetExists,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.data == true) {
            return ModelViewer(
              src: widget.assetPath,
              alt: widget.description,
              ar: false,
              autoRotate: true,
              cameraControls: true,
              backgroundColor: const Color(0xFF050B18),
            );
          }
          return Container(
            color: const Color(0xFF050B18),
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Positioned.fill(child: CustomPaint(painter: _StarsPainter())),
                Container(
                  width: 210,
                  height: 210,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFFB7C5D8), Color(0xFF46546B), Color(0xFF151E2D)],
                    ),
                    boxShadow: [BoxShadow(color: widget.accentColor.withOpacity(.25), blurRadius: 45, spreadRadius: 12)],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 230),
                    Icon(Icons.view_in_ar, size: 42, color: widget.accentColor),
                    const SizedBox(height: 10),
                    Text(widget.title.toUpperCase(), style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 2)),
                    const SizedBox(height: 6),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(widget.description, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white70)),
                    ),
                    const SizedBox(height: 12),
                    const Text('3D MODEL SLOT READY', style: TextStyle(color: Colors.white38, fontSize: 11, letterSpacing: 1.5)),
                  ],
                ),
              ],
            ),
          );
        },
      );
}

class _StarsPainter extends CustomPainter {
  const _StarsPainter();
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = Colors.white54;
    const points = [Offset(.08,.16), Offset(.22,.28), Offset(.82,.18), Offset(.91,.37), Offset(.12,.72), Offset(.75,.79), Offset(.56,.11), Offset(.42,.86)];
    for (final point in points) {
      canvas.drawCircle(Offset(point.dx * size.width, point.dy * size.height), 1.6, p);
    }
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
