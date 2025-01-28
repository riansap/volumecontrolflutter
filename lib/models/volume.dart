import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:volume_controller/volume_controller.dart';

enum VolumeType { media }

class Volume extends ChangeNotifier {
  final VolumeController _controller;
  double _level = 0.0;
  bool _isMuted = false;
  final _volumeController = StreamController<double>.broadcast();

  Volume(this._controller) {
    _initVolumeListener();
    _loadInitialVolume();
  }

  double get level => _level;
  bool get isMuted => _isMuted;
  Stream<double> get onVolumeChanged => _volumeController.stream;

  void _initVolumeListener() {
    _controller.listener((volume) {
      _level = volume;
      _volumeController.add(volume);
      notifyListeners();
    });
  }

  Future<void> _loadInitialVolume() async {
    _level = await _controller.getVolume();
    notifyListeners();
  }

  Future<void> setVolume(double level) async {
    _level = level;
    _controller.setVolume(level);
    if (level > 0) _isMuted = false;
    notifyListeners();
  }

  Future<void> toggleMute() async {
    _isMuted = !_isMuted;
    if (_isMuted) {
      _controller.setVolume(0);
    } else {
      _controller.setVolume(_level);
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _controller.removeListener();
    _volumeController.close();
    super.dispose();
  }
}
