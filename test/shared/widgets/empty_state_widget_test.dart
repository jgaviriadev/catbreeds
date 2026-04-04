import 'package:cat_breeds/shared/widgets/empty_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/pump_app.dart';

void main() {
  group('EmptyStateWidget', () {
    testWidgets('should display icon, title and subtitle', (tester) async {
      // Arrange
      const icon = Icons.inbox;
      const title = 'No items found';
      const subtitle = 'Try adding some items';

      // Act
      await tester.pumpApp(
        const EmptyStateWidget(
          icon: icon,
          title: title,
          subtitle: subtitle,
        ),
      );

      // Assert
      expect(find.byIcon(icon), findsOneWidget);
      expect(find.text(title), findsOneWidget);
      expect(find.text(subtitle), findsOneWidget);
    });

    testWidgets('should display icon and title without subtitle',
        (tester) async {
      // Act
      await tester.pumpApp(
        const EmptyStateWidget(
          icon: Icons.favorite_border,
          title: 'No favorites',
        ),
      );

      // Assert
      expect(find.byIcon(Icons.favorite_border), findsOneWidget);
      expect(find.text('No favorites'), findsOneWidget);
    });

    testWidgets('should use custom icon size', (tester) async {
      // Act
      await tester.pumpApp(
        const EmptyStateWidget(
          icon: Icons.search,
          title: 'Search',
          iconSize: 100,
        ),
      );

      // Assert
      final iconWidget = tester.widget<Icon>(find.byIcon(Icons.search));
      expect(iconWidget.size, 100);
    });
  });
}
