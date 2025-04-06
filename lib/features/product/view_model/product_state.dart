part of 'product_cubit.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}


final class GetAllProductsLoadingState extends ProductState {}
final class GetAllProductsSuccessState extends ProductState {}
final class GetAllProductsErrorState extends ProductState {}

final class ProductAddToCartLoading extends ProductState {}
final class ProductAddToCartSuccess extends ProductState {}
final class ProductAddToCartError extends ProductState {}

final class ProductDeleteFromFavouritesLoadingState extends ProductState {}
final class ProductDeleteFromFavouritesSuccessState extends ProductState {}
final class ProductDeleteFromFavouritesErrorState extends ProductState {}

final class ProductAddToFavouriteLoadingState extends ProductState {}
final class ProductAddToFavouriteSuccessState extends ProductState {}
final class ProductAddToFavouriteErrorState extends ProductState {}

final class ProductFavouriteLoadingState extends ProductState {}
final class ProductFavouriteSuccessState extends ProductState {}
final class ProductFavouriteErrorState extends ProductState {}


final class CounterDecremented extends ProductState {
  final int value;
  CounterDecremented(this.value);
}
final class CounterIncremented extends ProductState {
  final int value;
  CounterIncremented(this.value);
}