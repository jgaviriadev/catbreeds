import 'package:cat_breeds/shared/widgets/error_retry_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/pump_app.dart';

void main() {
  group('ErrorRetryWidget', () {
    testWidgets('should display error message', (tester) async {
      // Arrange
      const errorMessage = 'Something went wrong';

      // Act
      await tester.pumpApp(
        ErrorRetryWidget(
          errorMessage: errorMessage,
          onRetry: () {},
        ),
      );

      // Assert
      expect(find.text(errorMessage), findsOneWidget);
    });

    testWidgets('should call onRetry when retry button is tapped',
        (tester) async {
      // Arrange
      var retryPressed = false;

      await tester.pumpApp(
        ErrorRetryWidget(
          errorMessage: 'Error',
          onRetry: () => retryPressed = true,
        ),
      );

      // Act
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Assert
      expect(retryPressed, true);
    });

    testWidgets('should display error icon', (tester) async {
      // Act
      await tester.pumpApp(
        ErrorRetryWidget(
          errorMessage: 'Test error',
          onRetry: () {},
        ),
      );

      // Assert
      expect(find.byIcon(Icons.error_outline), findsOneWidget);
    });
  });
}
