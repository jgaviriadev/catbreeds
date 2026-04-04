import 'package:bloc_test/bloc_test.dart';
import 'package:cat_breeds/core/core.dart';
import 'package:cat_breeds/features/breeds/domain/usecases/get_initial_breeds_data_usecase.dart';
import 'package:cat_breeds/features/breeds/domain/usecases/search_breeds_usecase.dart';
import 'package:cat_breeds/features/breeds/presentation/bloc/breed_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/mock_data.dart';

class MockGetBreedsWithImagesUseCase extends Mock implements GetBreedsWithImagesUseCase {}

class MockSearchBreedsUseCase extends Mock implements SearchBreedsUseCase {}

void main() {
  late BreedBloc bloc;
  late MockGetBreedsWithImagesUseCase mockGetBreedsUseCase;
  late MockSearchBreedsUseCase mockSearchBreedsUseCase;

  setUp(() {
    mockGetBreedsUseCase = MockGetBreedsWithImagesUseCase();
    mockSearchBreedsUseCase = MockSearchBreedsUseCase();
    bloc = BreedBloc(
      getBreedsWithImagesUseCase: mockGetBreedsUseCase,
      searchBreedsUseCase: mockSearchBreedsUseCase,
    );
  });

  tearDown(() async {
    await bloc.close();
  });

  group('BreedBloc', () {
    test('initial state should be BreedState with initial status', () {
      expect(bloc.state.status, BreedStatus.initial);
      expect(bloc.state.breeds, isEmpty);
    });

    blocTest<BreedBloc, BreedState>(
      'emits [loading, success] when LoadInitialBreedsEvent succeeds',
      build: () {
        when(() => mockGetBreedsUseCase(0)).thenAnswer((_) async => Success(mockBreedsPageEntity));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadInitialBreedsEvent()),
      verify: (_) {
        verify(() => mockGetBreedsUseCase(0)).called(1);
      },
      expect: () => [
        predicate<BreedState>((state) => state.status == BreedStatus.loading),
        predicate<BreedState>((state) {
          return state.status == BreedStatus.success &&
              state.breeds.length == 2 &&
              state.currentPage == 0 &&
              state.totalCount == 2 &&
              state.hasReachedMax;
        }),
      ],
    );

    blocTest<BreedBloc, BreedState>(
      'emits [loading, error] when LoadInitialBreedsEvent fails',
      build: () {
        when(() => mockGetBreedsUseCase(0)).thenAnswer((_) async => const Error(ServerFailure(message: 'Load failed')));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadInitialBreedsEvent()),
      expect: () => [
        predicate<BreedState>((state) => state.status == BreedStatus.loading),
        predicate<BreedState>((state) {
          return state.status == BreedStatus.error && state.errorMessage == 'Load failed';
        }),
      ],
    );
  });
}
