import 'package:cat_breeds/features/breeds/domain/repositories/breed_repository.dart';
import 'package:cat_breeds/features/favorites/domain/repositories/favorite_repository.dart';
import 'package:cat_breeds/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:mocktail/mocktail.dart';

// Mock Repositories
class MockBreedRepository extends Mock implements BreedRepository {}

class MockFavoriteRepository extends Mock implements FavoriteRepository {}

// Mock BLoCs
class MockFavoritesBloc extends Mock implements FavoritesBloc {}
