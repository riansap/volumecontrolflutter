import 'package:flutter/material.dart';
import 'package:volume_controller/volume_controller.dart';
import 'models/volume.dart';
import 'screens/volume_control_screen.dart';
import 'utils/styles.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Volume Control',
      theme: AppStyles.lightTheme,
      home: VolumeControlScreen(
        volume: Volume(VolumeController()),
      ),
    );
  }
}
