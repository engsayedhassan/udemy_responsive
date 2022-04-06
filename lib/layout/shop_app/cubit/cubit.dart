import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/layout/shop_app/cubit/states.dart';
import 'package:untitled1/models/shop_app/categories_model.dart';
import 'package:untitled1/models/shop_app/change_favorites_model.dart';
import 'package:untitled1/models/shop_app/favorits_model.dart';
import 'package:untitled1/models/shop_app/home_model.dart';
import 'package:untitled1/models/shop_app/shop_login_model.dart';
import 'package:untitled1/modules/shop_app/cateogries/cateogries_screen.dart';
import 'package:untitled1/modules/shop_app/favorites/favorites_screen.dart';
import 'package:untitled1/modules/shop_app/products/products_screen.dart';
import 'package:untitled1/modules/shop_app/settings/settings_screen.dart';
import 'package:untitled1/shared/components/constants.dart';
import 'package:untitled1/shared/network/end_points.dart';
import 'package:untitled1/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int curruntIndex = 0;
  List<Widget> bottomScreens = [
    ProductsScreen(),
    CateogriesScreen(),
    FavoritesScreen(),
    SettingScreen(),
  ];

  void changeBottom(int index) {
    curruntIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;
  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data.products.forEach((element) {
        favorites.addAll({element.id: element.infavorites});
      });
      print(homeModel!.status);
      //printFullText(homeModel.data.products[0].toString());
      // printFullText(homeModel.data.banners.toString());
      print(homeModel!.data.products[0].toString());
      //print(homeModel.data.products);
      print(favorites.toString());
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategeries() {
    DioHelper.getData(
      url: GET_CATEGRIES,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(ShopChangeFavoritesState());
    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print(value.data);
      if (!changeFavoritesModel!.status) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavorites();
      }
      ;
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;
      emit(ShopErrorChangeFavoritesState(changeFavoritesModel));
    });
  }

  FavoritesModel? favoritesModel;

  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      printFullText(value.data.toString());
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }

  ShopLoginModel? userModel;

  void getUserData() {
    emit(ShopLoadingUserDataState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      printFullText('HHHHHHHHHHHH ==== ${userModel!.data!.name}');
      emit(ShopSuccessUserDataState(userModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUserDataState());
    });
  }

  void UpdateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopLoadingUpdateUserState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      printFullText('HHHHHHHHHHHH ==== ${userModel!.data!.name}');
      emit(ShopSuccessUpdateUserState(userModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateUserState());
    });
  }
}
