part of 'search_cubit.dart';

sealed class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchSuccess extends SearchState {
  final List<dynamic> items;

  const SearchSuccess(this.items);

  @override
  List<Object> get props => [items];
}

final class SearchEmpty extends SearchState {}

final class SearchReset extends SearchState {
  final List<dynamic> items;

  const SearchReset(this.items);

  @override
  List<Object> get props => [items];
}
