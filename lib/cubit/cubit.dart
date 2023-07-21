import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mego_market/Screens/Categories/category.dart';
import 'package:mego_market/Screens/Favorites/favorite.dart';
import 'package:mego_market/Screens/Products_Home/product_Home.dart';
import 'package:mego_market/Screens/setting/setting.dart';
import 'package:mego_market/cubit/state.dart';
import 'package:mego_market/model/cart/add_cart_model.dart';
import 'package:mego_market/model/cart/get_cart_model.dart';
import 'package:mego_market/model/cart/update_cart_model.dart';
import 'package:mego_market/model/category/category_details_model.dart';
import 'package:mego_market/model/category/category_model.dart';
import 'package:mego_market/model/faq/faq_model.dart';
import 'package:mego_market/model/favorite/favorite_model.dart';
import 'package:mego_market/model/home/home_model.dart';
import 'package:mego_market/model/login/login_model.dart';
import 'package:mego_market/network/dio_helper.dart';
import 'package:mego_market/network/end_points.dart';
import 'package:mego_market/shared/components/components.dart';
import 'package:mego_market/shared/components/constants.dart';

class MainCubit extends Cubit<MainStates> {
  MainCubit() : super(MainInitialStates());

  static MainCubit get(context) => BlocProvider.of(context);

  Map<dynamic, dynamic> favorites = {};
  Map<dynamic, dynamic> cart = {};

  int currentIndex = 0;

  List<Widget> pages = [
    ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    const SettingScreen(),
  ];

  void changeNavBar(int index) {
    currentIndex = index;
    emit(ChangeNavBarItem());
  }

  LoginModel? userData;

  void getUserData() {
    emit(UserLoginLoadingStates());

    DioHelper.getData(
      url: profile,
      token: token,
    ).then((value) {
      userData = LoginModel.fromJson(value.data);
      emit(UserLoginSuccessStates(userData!));
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(UserLoginErrorStates(error.toString()));
    });
  }

  void updateUserData({
    required String email,
    required String name,
    required String phone,
    String? image,
  }) {
    emit(UserUpdateLoadingStates());

    DioHelper.putData(
      url: update,
      token: token,
      data: {
        'email': email,
        'name': name,
        'phone': phone,
      },
    ).then((value) {
      userData = LoginModel.fromJson(value.data);
      emit(UserUpdateSuccessStates(userData!));
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(UserUpdateErrorStates(error.toString()));
    });
  }

  HomeModel? homeModel;

  void getHomeData() {
    emit(HomeLoadingStates());
    DioHelper.getData(
      url: home,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      //printFullText(homeModel.data.banners.toString());
      if (kDebugMode) {
        print(homeModel!.status);
      }
      if (kDebugMode) {
        print(token);
      }
      for (var element in homeModel!.data!.products) {
        favorites.addAll({
          element.id: element.inFavorites,
        });
      }
      for (var element in homeModel!.data!.products) {
        cart.addAll({
          element.id: element.inCart,
        });
      }
      emit(HomeSuccessStates());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(HomeErrorStates());
    });
  }

  CategoriesModel? categoriesModel;
  void getCategoriesData() {
    DioHelper.getData(
      url: categories,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(CategoriesSuccessStates());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(CategoriesErrorStates());
    });
  }

  CategoryDetailModel? categoriesDetailModel;
  void getCategoriesDetailData(int categoryID) {
    emit(CategoryDetailsLoadingStates());
    DioHelper.getData(url: "categories/$categoryID", query: {
      'category_id': '$categoryID',
    }).then((value) {
      categoriesDetailModel = CategoryDetailModel.fromJson(value.data);
      for (var element in categoriesDetailModel!.data!.productData!) {
        if (kDebugMode) {
          print(element.id);
        }
      }
      if (kDebugMode) {
        print('categories Detail ${categoriesDetailModel!.status}');
      }
      emit(CategoryDetailsSuccessStates());
    }).catchError((error) {
      emit(CategoryDetailsErrorStates());
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

// changeCart
  ChangeCartModel? changeCartModel;
  void changeCart(int productId) {
    // cart[productId] = !cart[productId];
    emit(ChangeCartStates());
    DioHelper.postData(
      url: carts,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeCartModel = ChangeCartModel.fromJson(value.data);
      // print('changeCartModel ' + changeCartModel.status.toString());
      if (changeCartModel!.status!) {
        getCartData();
        getHomeData();
      } else {
        showToast(
          text: changeCartModel!.message!,
          state: ToastStates.success,
        );
      }
      emit(ChangeCartSuccessStates(changeCartModel!));
    }).catchError((error) {
      emit(ChangeCartErrorStates());
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  // get cart data
  CartModel? cartModel;

  void getCartData() {
    emit(CartLoadingStates());
    DioHelper.getData(url: carts, token: token).then((value) {
      cartModel = CartModel.fromJson(value.data);
      // print('Get Cart'+cartModel.toString());
      emit(GetCartSuccessStates());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(GetCartErrorStates());
    });
  }

// update cart
  UpdateCartModel? updateCartModel;
  void updateCartData(int id, int quantity) {
    emit(UpdateCartLoadingStates());
    DioHelper.putData(
            url: 'carts/$id',
            data: {
              'quantity': '$quantity',
            },
            token: token)
        .then((value) {
      updateCartModel = UpdateCartModel.fromJson(value.data);
      if (updateCartModel!.status!) {
        getCartData();
      } else {
        showToast(
          text: updateCartModel!.message!,
          state: ToastStates.success,
        );
      }
      //  print('updateCartModel ' + updateCartModel.status.toString());
      emit(UpdateCartSuccessStates());
    }).catchError((error) {
      emit(UpdateCartErrorStates());
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int productID) {
    favorites[productID] = !favorites[productID];
    emit(ChangeFavoritesStates());

    DioHelper.postData(url: favorite, token: token, data: {
      'product_id': productID,
    }).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      if (kDebugMode) {
        print(value.data);
      }

      if (!changeFavoritesModel!.status!) {
        favorites[productID] = !favorites[productID];
      } else {
        getFavoritesData();
      }
      emit(ChangeFavoritesSuccessStates(changeFavoritesModel!));
    }).catchError((error) {
      favorites[productID] = !favorites[productID];
      emit(ChangeFavoritesErrorStates());
    });
  }

  FavoritesModel? favoritesModel;

  void getFavoritesData() {
    emit(FavoritesLoadingStates());
    DioHelper.getData(
      url: favorite,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(GetFavoritesSuccessStates());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(GetFavoritesErrorStates());
    });
  }

  ProductResponse? productResponse;
  Future getProductData(productId) async {
    productResponse;
    emit(ProductLoadingStates());
    return await DioHelper.getData(url: 'products/$productId', token: token)
        .then((value) {
      productResponse = ProductResponse.fromJson(value.data);
      //print('Product Detail '+productsModel.status.toString());
      emit(ProductSuccessStates(productResponse!));
    }).catchError((error) {
      emit(ProductErrorStates());
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  FaqModel? faqModel;
  void getFaqData() {
    emit(FaqLoadingStates());
    DioHelper.getData(url: faqs, token: token).then((value) {
      faqModel = FaqModel.fromJson(value.data);
      emit(GetFaqSuccessStates());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(GetFaqErrorStates());
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void showPassword() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ShowPasswordStates());
  }
}
