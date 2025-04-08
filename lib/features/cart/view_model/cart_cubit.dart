import 'package:eco_app/features/product/general_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eco_app/core/api/api_manager.dart';
import 'package:eco_app/core/api/end_points.dart';
import 'package:eco_app/core/cache/secure_storage.dart';
import 'package:eco_app/features/cart/model/cart_model.dart';
import 'package:flutter/material.dart';
part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  static CartCubit get(context) => BlocProvider.of(context);
  final GeneralRepository generalRepo = GeneralRepository();

  CartModel? cartModel;


  // cart
  getCart()async {
    String? token = await SecureStorage().storage.read(key: 'token');
    emit(CartLoadingState());
    ApiManager( )
        .getData(
      headers: {
        'token': token, // Standard header name
      },
      endPoint: EndPoints.cart,

    )
        .then((value) {
      cartModel = CartModel.fromJson(value.data);
      emit(CartSuccessState());
    }).catchError((error) {
      debugPrint('the error ${error.toString()}');
      emit(CartErrorState(error: error.toString(),),);
    });
  }

  deleteFromCart({required String productId})async {
    String? token = await SecureStorage().storage.read(key: 'token');
    emit(DeleteFromCartLoadingState());



    ApiManager().deleteData(
      headers: {
        'token': token,
      },
      endPoint: '${EndPoints.cart}/$productId',

    )

        .then((value) {
      emit(DeleteFromCartSuccessState());
      // if (cartModel != null && cartModel!.data!.products != null) {
      //   cartModel!.data!.products!.removeWhere((item) => item.product!.id == productId);}
      getCart();
    }).catchError((error) {
      debugPrint('the error ${error.toString()}');
      emit(DeleteFromCartErrorState(error: error.toString(),),);
    });
  }


  void decrement() {
    generalRepo.decrement();
    emit(CounterDecremented(generalRepo.counter));
  }

  void increment() {
    generalRepo.increment();
    emit(CounterIncremented(generalRepo.counter));
  }

  // addToCart({required String productId})async {
  //   String? token = await SecureStorage().storage.read(key: 'token');
  //   emit(AddToCartLoadingState());
  //   ApiManager( )
  //       .postData(
  //     body: {
  //       'productId':productId
  //     },
  //     headers: {
  //       'token': token,
  //     },
  //     endPoint: EndPoints.cart,
  //
  //   )
  //       .then((value) {
  //     emit(AddToCartSuccessState());
  //   }).catchError((error) {
  //     debugPrint('the error ${error.toString()}');
  //     emit(AddToCartErrorState(error: error.toString(),),);
  //   });
  // }


  // Future<void> deleteFromCart({required String productId}) async {
  //   String? token = await SecureStorage().storage.read(key: 'token');
  //   emit(DeleteFromCartLoadingState());
  //   try {
  //     // Optimistically update UI by removing the item locally
  //     if (cartModel != null && cartModel!.data!.products != null) {
  //       cartModel!.data!.products!.removeWhere((item) => item.sId == productId);
  //     }
  //
  //
  //     await ApiManager().deleteData(
  //       endPoint: '${EndPoints.cart}/$productId',
  //       headers: { 'token': token,},
  //     );
  //
  //
  //     await getCart();
  //     emit(DeleteFromCartSuccessState()); // Notify UI to rebuild
  //   } catch (e) {
  //     emit(DeleteFromCartErrorState(error: e.toString()));
  //
  //     // await getCart();
  //   }
  // }



}
