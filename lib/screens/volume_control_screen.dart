import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../models/volume.dart';

class VolumeControlScreen extends StatefulWidget {
  final Volume volume;

  const VolumeControlScreen({super.key, required this.volume});

  @override
  State<VolumeControlScreen> createState() => _VolumeControlScreenState();
}

class _VolumeControlScreenState extends State<VolumeControlScreen> {
  String _version = '';

  @override
  void initState() {
    super.initState();
    _loadVersion();
    widget.volume.addListener(_onVolumeChanged);
  }

  @override
  void dispose() {
    widget.volume.removeListener(_onVolumeChanged);
    super.dispose();
  }

  void _onVolumeChanged() {
    setState(() {});
  }

  Future<void> _loadVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _version = packageInfo.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Volume Control'),
        centerTitle: true,
        elevation: 2,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              colorScheme.surface,
              colorScheme.surfaceContainerHighest,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Column(
              children: [
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Slider(
                          value: widget.volume.level,
                          onChanged: (value) => widget.volume.setVolume(value),
                        ),
                        IconButton(
                          icon: Icon(
                            widget.volume.isMuted
                                ? Icons.volume_off
                                : Icons.volume_up,
                          ),
                          onPressed: () => widget.volume.toggleMute(),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  'Version $_version',
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Made with ❤️ by Rian Sap',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
