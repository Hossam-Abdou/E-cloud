import 'package:eco_app/core/api/api_manager.dart';
import 'package:eco_app/core/api/end_points.dart';
import 'package:eco_app/core/cache/secure_storage.dart';
import 'package:eco_app/features/main_tabs/model/category/sub_category_model.dart';
import 'package:eco_app/features/main_tabs/model/category/categories_model.dart';
import 'package:eco_app/features/main_tabs/model/favourite/favourite_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);


  // models
  CategoriesModel? categoriesModel;
  FavouriteModel? favouriteModel;
  SubCategoryModel? subCategoryModel;

  // variables
  int isSelected  = 0;
  int currentIndex  = 0;



  // categories
  categoryToggle(value) {
    isSelected = value;
    emit(CategoryToggleState());
  }
  getCategories()
  {
    emit(CategoryLoadingState());
    ApiManager().getData(
        endPoint: EndPoints.category,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(CategorySuccessState());
    }).catchError((error) {
      debugPrint('the error ${error.toString()}');
      emit(CategoryErrorState());

    });
  }

  getSubCategories(String? id) {
    emit(SubCategoriesLoadingState());
    ApiManager()
        .getData(
      endPoint: '${EndPoints.category}/$id/subcategories',
    )
        .then((value) {
      subCategoryModel = SubCategoryModel.fromJson(value.data);
      emit(SubCategoriesSuccessState());
    }).catchError((error) {
      debugPrint('the error ${error.toString()}');
      emit(SubCategoriesErrorState());
    });
  }



  // favourite
  getFavourites() async {
    emit(FavouriteLoadingState());
    try {
      String? token = await SecureStorage().storage.read(key: 'token');

      if (token == null) {
        emit(FavouriteErrorState(error: 'No authentication token found'));
        return;
      }
      final response = await ApiManager().getData(
        headers: {
          'token': token, // Standard header name
        },
        endPoint: EndPoints.favourite,
      );

      favouriteModel = FavouriteModel.fromJson(response.data);
      emit(FavouriteSuccessState());
    } catch (error) {
      debugPrint('Error fetching favorites: $error');
      emit(FavouriteErrorState(error: error.toString()));
    }
  }

  addToFavourites({required String productId})async {
    String? token = await SecureStorage().storage.read(key: 'token');
    emit(AddToFavouriteLoadingState());
    ApiManager( )
        .postData(
      body: {
        'productId':productId
      },
      headers: {
        'token': token,
      },
      endPoint: EndPoints.favourite,

    )
        .then((value) async{
      emit(AddToFavouriteSuccessState());
    }).catchError((error) {
      debugPrint('the error ${error.toString()}');
      emit(AddToFavouriteErrorState(error: error.toString(),),);
    });
  }

  deleteFromFavourites({required String productId})async {
    String? token = await SecureStorage().storage.read(key: 'token');
    emit(DeleteFromFavouritesLoadingState());
    if (favouriteModel != null && favouriteModel!.data!= null) {
      favouriteModel!.data!.removeWhere((item) => item.sId == productId);
        }
    ApiManager().deleteData(
      headers: {
        'token': token,
      },
      endPoint: '${EndPoints.favourite}/$productId',

    )

        .then((value) {
      emit(DeleteFromFavouritesSuccessState());
    }).catchError((error) {
      debugPrint('the error ${error.toString()}');
      emit(DeleteFromFavouritesErrorState(error: error.toString(),),);
    });
  }





  //
  // changeCarouselIndex(int index) {
  //   currentIndex = index;
  //   emit(ChangeIndexState());
  // }






}
