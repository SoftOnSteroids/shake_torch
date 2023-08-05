import 'package:flutter/material.dart';
import 'package:torch_controller/torch_controller.dart';
import 'package:shake/shake.dart';

class TorchShake extends StatefulWidget {
  const TorchShake({super.key});

  @override
  State<TorchShake> createState() => _TorchShakeState();
}

class _TorchShakeState extends State<TorchShake> {
  @override
  void initState() {
    super.initState();
    ShakeDetector detector = ShakeDetector.autoStart(
      onPhoneShake: () {
        _toggleTorch();
      },
      minimumShakeCount: 2,
      shakeSlopTimeMS: 500,
      shakeCountResetTime: 2000,
      shakeThresholdGravity: 2.7,
    );
  }

  /// Returns a singleton with the controller that you had initialized
  /// on `main.dart`
  final torchController = TorchController();
  bool _isActive = false;
  void _toggleTorch() {
    torchController.toggle().then((value) {
      _isActive = value ?? false;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            duration: Duration(milliseconds: 600),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                (_isActive)
                    ? Text(')·•Torch On•·(')
                    : Text(")·• Torch Off •·("),
              ],
            )),
      );
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    const List<Widget> torchButtons = [
      Text("ON"),
      Text("OFF"),
    ];
    List<bool> selected = [
      _isActive,
      !_isActive,
    ];
    return Scaffold(
      appBar: AppBar(title: const Text("Torch Shake")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ToggleButtons(
              onPressed: (int index) {
                setState(() {
                  // The button that is tapped is set to true, and the others to false.
                  for (int i = 0; i < selected.length; i++) {
                    selected[i] = i == index;
                  }
                  ((_isActive && index == 0) || (!_isActive && index == 1))
                      ? null
                      : _toggleTorch();
                });
              },
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              selectedBorderColor: Colors.blue[700],
              selectedColor: Colors.white,
              fillColor: Colors.blue[200],
              color: Colors.blue[400],
              isSelected: [_isActive, !_isActive],
              children: torchButtons,
            )
          ],
        ),
      ),
    );
  }
}
