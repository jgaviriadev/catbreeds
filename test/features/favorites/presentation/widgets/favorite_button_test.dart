import 'package:bloc_test/bloc_test.dart';
import 'package:cat_breeds/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:cat_breeds/features/favorites/presentation/widgets/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/helpers.dart';

class FakeFavoritesEvent extends Fake implements FavoritesEvent {}

void main() {
  late MockFavoritesBloc mockFavoritesBloc;

  setUpAll(() {
    registerFallbackValue(FakeFavoritesEvent());
  });

  setUp(() {
    mockFavoritesBloc = MockFavoritesBloc();
  });

  Widget buildWidget({
    required String imageId,
    required FavoritesState state,
  }) {
    whenListen(
      mockFavoritesBloc,
      Stream.value(state),
      initialState: state,
    );

    return MaterialApp(
      home: BlocProvider<FavoritesBloc>.value(
        value: mockFavoritesBloc,
        child: Scaffold(
          body: FavoriteButton(
            imageId: imageId,
            subId: 'test-user',
          ),
        ),
      ),
    );
  }

  group('FavoriteButton', () {
    const imageId = 'img-123';

    testWidgets('should display unfilled heart when not favorite',
        (tester) async {
      // Arrange
      final state = FavoritesState(
        favoriteImageIds: const {},
        loadingIds: const {},
      );

      // Act
      await tester.pumpWidget(buildWidget(imageId: imageId, state: state));

      // Assert
      expect(find.byIcon(Icons.favorite_border), findsOneWidget);
      expect(find.byIcon(Icons.favorite), findsNothing);
    });

    testWidgets('should display filled heart when is favorite', (tester) async {
      // Arrange
      final state = FavoritesState(
        favoriteImageIds: {imageId},
        loadingIds: const {},
      );

      // Act
      await tester.pumpWidget(buildWidget(imageId: imageId, state: state));

      // Assert
      expect(find.byIcon(Icons.favorite), findsOneWidget);
      expect(find.byIcon(Icons.favorite_border), findsNothing);
    });

    testWidgets('should display loading indicator when toggling',
        (tester) async {
      // Arrange
      final state = FavoritesState(
        favoriteImageIds: const {},
        loadingIds: {imageId},
      );

      // Act
      await tester.pumpWidget(buildWidget(imageId: imageId, state: state));

      // Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should dispatch ToggleFavoriteEvent when tapped',
        (tester) async {
      // Arrange
      final state = FavoritesState(
        favoriteImageIds: const {},
        loadingIds: const {},
      );

      await tester.pumpWidget(buildWidget(imageId: imageId, state: state));

      // Act
      await tester.tap(find.byType(GestureDetector));
      await tester.pump();

      // Assert
      verify(() => mockFavoritesBloc.add(any())).called(1);
    });

    testWidgets('should not dispatch event when loading', (tester) async {
      // Arrange
      final state = FavoritesState(
        favoriteImageIds: const {},
        loadingIds: {imageId},
      );

      await tester.pumpWidget(buildWidget(imageId: imageId, state: state));

      // Verify no interaction since loading
      verifyNever(() => mockFavoritesBloc.add(any()));
    });
  });
}
