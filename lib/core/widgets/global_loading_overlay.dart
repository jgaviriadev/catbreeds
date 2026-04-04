import 'package:flutter/material.dart';

class GlobalLoadingOverlay extends StatelessWidget {
  const GlobalLoadingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      alignment: Alignment.center,
      child: const CircularProgressIndicator(),
    );
  }
}
