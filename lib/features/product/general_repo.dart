// cart_repository.dart
import 'package:eco_app/core/api/api_manager.dart';
import 'package:eco_app/core/api/end_points.dart';
import 'package:eco_app/core/cache/secure_storage.dart';
import 'package:eco_app/features/home/model/favourite/favourite_model.dart';

class GeneralRepository {

  // Singleton instance
  static final GeneralRepository _instance = GeneralRepository._internal();

  final ApiManager api = ApiManager();
  final SecureStorage storage = SecureStorage();

  // Private constructor
  GeneralRepository._internal();

  // Public factory constructor
  factory GeneralRepository() => _instance;

  Future<void> addToCartRepo(String productId) async {
    final token = await storage.storage.read(key: 'token');

    await api.postData(
      endPoint: EndPoints.cart,
      body: {'productId': productId},
      headers: {'token': token},
    );
  }

  Future<void> deleteFromCart(String productId) async {
    final token = await storage.storage.read(key: 'token');
    await api.deleteData(
      endPoint: '${EndPoints.cart}/$productId',
      headers: {'token': token},
    );
  }

// favourite

  Future<FavouriteModel> getFavourites() async {
    final token = await storage.storage.read(key: 'token');
    if (token == null) throw Exception('No authentication token found');

    final response = await api.getData(
      headers: {'token': token},
      endPoint: EndPoints.favourite,
    );

    return FavouriteModel.fromJson(response.data);
  }

  Future<void> addToFavourites(String productId) async {
    final token = await storage.storage.read(key: 'token');
    await api.postData(
      body: {'productId': productId},
      headers: {'token': token},
      endPoint: EndPoints.favourite,
    );
  }

  Future<void> deleteFromFavourites(String productId) async {
    final token = await storage.storage.read(key: 'token');
    await api.deleteData(
      headers: {'token': token},
      endPoint: '${EndPoints.favourite}/$productId',
    );
  }

  // counter
  int counter = 1;

  void decrement() {
    if (counter > 1) {
      counter--;
    }
  }

  void increment() {
    counter++;
  }



}