import 'package:eco_app/features/main_tabs/model/favourite/favourite_model.dart';
import 'package:eco_app/features/product/general_repo.dart';
import 'package:eco_app/core/api/api_manager.dart';
import 'package:eco_app/core/api/end_points.dart';

import 'package:eco_app/features/product/model/product_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {

  ProductCubit() : super(ProductInitial());
  static ProductCubit get(context) => BlocProvider.of(context);


  final GeneralRepository generalRepo = GeneralRepository();

  ProductModel? productModel;
  FavouriteModel? favouriteModel;



  Future<void> addToCart({required String productId}) async {
    try {
      emit(ProductAddToCartLoading());
      await generalRepo.addToCartRepo(productId);
      emit(ProductAddToCartSuccess());
    } catch (e) {
      emit(ProductAddToCartError());
    }
  }

  getAllProducts(String? id) {
    emit(GetAllProductsLoadingState());
    ApiManager()
        .getData(
        endPoint: EndPoints.products,
        param: {
          'category[in]': id
        }
    )
        .then((value) {
      productModel = ProductModel.fromJson(value.data);
      emit(GetAllProductsSuccessState());
    }).catchError((error) {
      debugPrint('the error ${error.toString()}');
      emit(GetAllProductsErrorState());
    });
  }



  Future<void> getFavourites() async {
    emit(ProductFavouriteLoadingState());
    try {
      favouriteModel = await generalRepo.getFavourites();
      emit(ProductFavouriteSuccessState());
    } catch (error) {
      debugPrint('Error fetching favorites: $error');
      emit(ProductFavouriteErrorState());
    }
  }

  Future<void> addToFavourites({required String productId}) async {
    emit(ProductAddToFavouriteLoadingState());
    try {
      await generalRepo.addToFavourites(productId);
      emit(ProductAddToFavouriteSuccessState());
      await getFavourites(); // Refresh favorites list
    } catch (error) {
      debugPrint('Error adding favorite: $error');
      emit(ProductAddToFavouriteErrorState());
    }
  }

  Future<void> deleteFromFavourites(String productId) async {
    emit(ProductDeleteFromFavouritesLoadingState());
    try {
      // Optimistic update
      if (favouriteModel?.data != null) {
        favouriteModel!.data!.removeWhere((item) => item.sId == productId);
      }

      await generalRepo.deleteFromFavourites(productId);
      emit(ProductDeleteFromFavouritesSuccessState());
    } catch (error) {
      debugPrint('Error removing favorite: $error');
      emit(ProductDeleteFromFavouritesErrorState());
      await getFavourites(); // Revert on error
    }
  }


  void decrement() {
    generalRepo.decrement();
    emit(CounterDecremented(generalRepo.counter));
  }

  void increment() {
    generalRepo.increment();
    emit(CounterIncremented(generalRepo.counter));
  }

}
