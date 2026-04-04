

import 'package:cat_breeds/core/core.dart';

abstract class UseCase<T, Params> {
  Future<Result<T>> call(Params params);
}

class NoParams {
  const NoParams();
}
