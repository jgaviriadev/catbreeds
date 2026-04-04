import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Helper to wrap widgets with MaterialApp for testing
extension PumpApp on WidgetTester {
  Future<void> pumpApp(Widget widget) {
    return pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: widget,
        ),
      ),
    );
  }
}
