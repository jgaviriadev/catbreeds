import 'package:cat_breeds/core/core.dart';
import 'package:cat_breeds/features/favorites/domain/repositories/favorite_repository.dart';

class AddFavoriteParams {
  final String imageId;
  final String subId;

  AddFavoriteParams({
    required this.imageId,
    required this.subId,
  });
}

class AddFavoriteUseCase implements UseCase<bool, AddFavoriteParams> {
  final FavoriteRepository repository;

  AddFavoriteUseCase({required this.repository});

  @override
  Future<Result<bool>> call(AddFavoriteParams params) {
    return repository.addFavorite(
      imageId: params.imageId,
      subId: params.subId,
    );
  }
}
