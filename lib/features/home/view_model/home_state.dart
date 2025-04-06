part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}
final class ChangeFavState extends HomeState {}

final class CategoryToggleState extends HomeState {}

final class CategoryLoadingState extends HomeState {}
final class CategorySuccessState extends HomeState {}
final class CategoryErrorState extends HomeState {}

final class SubCategoriesLoadingState extends HomeState {}
final class SubCategoriesSuccessState extends HomeState {}
final class SubCategoriesErrorState extends HomeState {}




final class FavouriteLoadingState extends HomeState {}
final class FavouriteSuccessState extends HomeState {}
final class FavouriteErrorState extends HomeState {
  String? error;

  FavouriteErrorState({required this.error});
}

final class AddToFavouriteLoadingState extends HomeState {}
final class AddToFavouriteSuccessState extends HomeState {}
final class AddToFavouriteErrorState extends HomeState {
  String? error;

  AddToFavouriteErrorState({required this.error});
}

final class ChangeIndexState extends HomeState {}





final class DeleteFromFavouritesLoadingState extends HomeState {}
final class DeleteFromFavouritesSuccessState extends HomeState {}
final class DeleteFromFavouritesErrorState extends HomeState {
  String? error;

  DeleteFromFavouritesErrorState({required this.error});
}