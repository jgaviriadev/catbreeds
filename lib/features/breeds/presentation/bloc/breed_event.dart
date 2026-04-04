part of 'breed_bloc.dart';

abstract class BreedEvent {}

class LoadInitialBreedsEvent extends BreedEvent {}

class LoadMoreBreedsEvent extends BreedEvent {}

class RefreshBreedsEvent extends BreedEvent {}

class SearchBreedsEvent extends BreedEvent {
  final String query;
  SearchBreedsEvent(this.query);
}

class ClearSearchEvent extends BreedEvent {}
