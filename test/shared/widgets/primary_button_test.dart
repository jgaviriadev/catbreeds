import 'package:cat_breeds/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/pump_app.dart';

void main() {
  group('PrimaryButton', () {
    testWidgets('should render button with text', (tester) async {
      // Arrange
      const buttonText = 'Click Me';

      // Act
      await tester.pumpApp(
        PrimaryButton(
          text: buttonText,
          onPressed: () {},
        ),
      );

      // Assert
      expect(find.text(buttonText), findsOneWidget);
      expect(find.byType(FilledButton), findsOneWidget);
    });

    testWidgets('should call onPressed when tapped', (tester) async {
      // Arrange
      var wasPressed = false;

      await tester.pumpApp(
        PrimaryButton(
          text: 'Test',
          onPressed: () => wasPressed = true,
        ),
      );

      // Act
      await tester.tap(find.byType(FilledButton));
      await tester.pump();

      // Assert
      expect(wasPressed, true);
    });

    testWidgets('should be disabled when onPressed is null', (tester) async {
      // Act
      await tester.pumpApp(
        const PrimaryButton(
          text: 'Disabled',
          onPressed: null,
        ),
      );

      // Assert
      final button = tester.widget<FilledButton>(
        find.byType(FilledButton),
      );
      expect(button.onPressed, isNull);
    });
  });
}
